import 'dart:async';
import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../data/exercises_data.dart';
import '../theme/app_theme.dart';
import '../utils/haptic_feedback.dart';
import '../widgets/breathing_circle.dart';
import '../widgets/breathing_square.dart';
import '../widgets/grounding_steps.dart';
import '../widgets/body_diagram.dart';
import '../widgets/session_timer.dart';

class ExerciseSessionScreen extends StatefulWidget {
  final Exercise exercise;

  const ExerciseSessionScreen({
    super.key,
    required this.exercise,
  });

  @override
  State<ExerciseSessionScreen> createState() => _ExerciseSessionScreenState();
}

class _ExerciseSessionScreenState extends State<ExerciseSessionScreen> {
  bool _isStarted = false;
  bool _isComplete = false;
  int _totalElapsedSeconds = 0;
  Timer? _sessionTimer;

  // Breathing exercise state
  int _currentPhaseIndex = 0;
  int _phaseSecondsRemaining = 0;
  int _cycleCount = 0;
  Timer? _breathingTimer;

  // Grounding exercise state
  int _currentGroundingStepIndex = 0;
  int _currentGroundingItemCount = 0;

  // PMR exercise state
  int _currentMuscleGroupIndex = 0;
  bool _isTensing = true;
  int _pmrSecondsRemaining = 0;
  Timer? _pmrTimer;

  // Body scan state
  int _currentBodyRegionIndex = 0;
  int _bodyScanSecondsRemaining = 0;
  Timer? _bodyScanTimer;

  // Counting breath state
  int _breathCount = 0;
  bool _isInhaling = true;
  int _countingBreathSeconds = 0;
  Timer? _countingBreathTimer;

  @override
  void dispose() {
    _sessionTimer?.cancel();
    _breathingTimer?.cancel();
    _pmrTimer?.cancel();
    _bodyScanTimer?.cancel();
    _countingBreathTimer?.cancel();
    super.dispose();
  }

  void _startExercise() {
    setState(() {
      _isStarted = true;
    });
    AppHaptics.mediumTap();

    // Start session timer
    _sessionTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _totalElapsedSeconds++;
      });
    });

    // Start exercise-specific logic
    switch (widget.exercise.type) {
      case ExerciseType.boxBreathing:
        _startBoxBreathing();
        break;
      case ExerciseType.breathing478:
        _startBreathing478();
        break;
      case ExerciseType.grounding54321:
        // Grounding is user-paced, no timer needed
        break;
      case ExerciseType.progressiveMuscleRelaxation:
        _startPMR();
        break;
      case ExerciseType.bodyScan:
        _startBodyScan();
        break;
      case ExerciseType.countingBreath:
        _startCountingBreath();
        break;
    }
  }

  void _startBoxBreathing() {
    final phases = ExercisesData.boxBreathingPhases;
    _currentPhaseIndex = 0;
    _phaseSecondsRemaining = phases[0].durationSeconds;

    _breathingTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _phaseSecondsRemaining--;

        if (_phaseSecondsRemaining <= 0) {
          _currentPhaseIndex = (_currentPhaseIndex + 1) % phases.length;
          _phaseSecondsRemaining = phases[_currentPhaseIndex].durationSeconds;
          AppHaptics.breathingPhaseChange();

          if (_currentPhaseIndex == 0) {
            _cycleCount++;
          }
        }
      });
    });
  }

  void _startBreathing478() {
    final phases = ExercisesData.breathing478Phases;
    _currentPhaseIndex = 0;
    _phaseSecondsRemaining = phases[0].durationSeconds;

    _breathingTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _phaseSecondsRemaining--;

        if (_phaseSecondsRemaining <= 0) {
          _currentPhaseIndex = (_currentPhaseIndex + 1) % phases.length;
          _phaseSecondsRemaining = phases[_currentPhaseIndex].durationSeconds;
          AppHaptics.breathingPhaseChange();

          if (_currentPhaseIndex == 0) {
            _cycleCount++;
          }
        }
      });
    });
  }

  void _onGroundingItemTap() {
    final steps = ExercisesData.groundingSteps;
    final currentStep = steps[_currentGroundingStepIndex];

    setState(() {
      _currentGroundingItemCount++;
      AppHaptics.tick();

      if (_currentGroundingItemCount >= currentStep.count) {
        // Move to next step
        if (_currentGroundingStepIndex < steps.length - 1) {
          _currentGroundingStepIndex++;
          _currentGroundingItemCount = 0;
        } else {
          // Exercise complete
          _completeExercise();
        }
      }
    });
  }

  void _startPMR() {
    final groups = ExercisesData.muscleGroups;
    _currentMuscleGroupIndex = 0;
    _isTensing = true;
    _pmrSecondsRemaining = groups[0].tensionDuration;

    _pmrTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _pmrSecondsRemaining--;

        if (_pmrSecondsRemaining <= 0) {
          if (_isTensing) {
            // Switch to relax phase
            _isTensing = false;
            _pmrSecondsRemaining = groups[_currentMuscleGroupIndex].relaxDuration;
            AppHaptics.breathingPhaseChange();
          } else {
            // Move to next muscle group
            if (_currentMuscleGroupIndex < groups.length - 1) {
              _currentMuscleGroupIndex++;
              _isTensing = true;
              _pmrSecondsRemaining = groups[_currentMuscleGroupIndex].tensionDuration;
              AppHaptics.breathingPhaseChange();
            } else {
              _completeExercise();
            }
          }
        }
      });
    });
  }

  void _startBodyScan() {
    final regions = ExercisesData.bodyScanRegions;
    _currentBodyRegionIndex = 0;
    _bodyScanSecondsRemaining = regions[0].durationSeconds;

    _bodyScanTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _bodyScanSecondsRemaining--;

        if (_bodyScanSecondsRemaining <= 0) {
          if (_currentBodyRegionIndex < regions.length - 1) {
            _currentBodyRegionIndex++;
            _bodyScanSecondsRemaining = regions[_currentBodyRegionIndex].durationSeconds;
            AppHaptics.breathingPhaseChange();
          } else {
            _completeExercise();
          }
        }
      });
    });
  }

  void _startCountingBreath() {
    _breathCount = 0;
    _isInhaling = true;
    _countingBreathSeconds = 4; // 4 seconds inhale

    _countingBreathTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _countingBreathSeconds--;

        if (_countingBreathSeconds <= 0) {
          if (_isInhaling) {
            _isInhaling = false;
            _countingBreathSeconds = 6; // 6 seconds exhale
          } else {
            _isInhaling = true;
            _countingBreathSeconds = 4;
            _breathCount++;
            if (_breathCount >= 10) {
              _breathCount = 0; // Reset to 1 after 10
            }
            AppHaptics.tick();
          }
        }
      });
    });
  }

  void _completeExercise() {
    _breathingTimer?.cancel();
    _pmrTimer?.cancel();
    _bodyScanTimer?.cancel();
    _countingBreathTimer?.cancel();
    _sessionTimer?.cancel();

    setState(() {
      _isComplete = true;
    });
    AppHaptics.exerciseComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      AppHaptics.lightTap();
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close_rounded),
                    style: IconButton.styleFrom(
                      backgroundColor: AppTheme.surfaceColor,
                    ),
                  ),
                  if (_isStarted && !_isComplete)
                    SessionTimer(
                      elapsedSeconds: _totalElapsedSeconds,
                      color: widget.exercise.color,
                    ),
                  const SizedBox(width: 48), // Balance for close button
                ],
              ),
            ),
            // Content
            Expanded(
              child: _isComplete
                  ? _buildCompletionScreen()
                  : _isStarted
                      ? _buildActiveExercise()
                      : _buildStartScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStartScreen() {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: widget.exercise.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusXl),
            ),
            child: Icon(
              widget.exercise.icon,
              size: 60,
              color: widget.exercise.color,
            ),
          ),
          const SizedBox(height: AppTheme.spacingXl),
          Text(
            widget.exercise.name,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: AppTheme.spacingMd),
          Text(
            'Find a comfortable position\nand take a deep breath',
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.textColor.withOpacity(0.7),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spacingXxl),
          ElevatedButton(
            onPressed: _startExercise,
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.exercise.color,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 18),
            ),
            child: const Text(
              'Begin',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveExercise() {
    switch (widget.exercise.type) {
      case ExerciseType.boxBreathing:
        return _buildBoxBreathingExercise();
      case ExerciseType.breathing478:
        return _buildBreathing478Exercise();
      case ExerciseType.grounding54321:
        return _buildGroundingExercise();
      case ExerciseType.progressiveMuscleRelaxation:
        return _buildPMRExercise();
      case ExerciseType.bodyScan:
        return _buildBodyScanExercise();
      case ExerciseType.countingBreath:
        return _buildCountingBreathExercise();
    }
  }

  Widget _buildBoxBreathingExercise() {
    final phases = ExercisesData.boxBreathingPhases;
    final phase = phases[_currentPhaseIndex];
    final totalPhaseSeconds = phase.durationSeconds;
    final phaseProgress = 1 - (_phaseSecondsRemaining / totalPhaseSeconds);

    return Column(
      children: [
        const Spacer(),
        BreathingSquare(
          currentPhaseIndex: _currentPhaseIndex,
          phaseProgress: phaseProgress,
          phaseName: phase.name,
          instruction: phase.instruction,
          secondsRemaining: _phaseSecondsRemaining,
          color: widget.exercise.color,
        ),
        const Spacer(),
        _buildCycleCounter(),
        const SizedBox(height: AppTheme.spacingLg),
        _buildFinishButton(),
        const SizedBox(height: AppTheme.spacingLg),
      ],
    );
  }

  Widget _buildBreathing478Exercise() {
    final phases = ExercisesData.breathing478Phases;
    final phase = phases[_currentPhaseIndex];
    final totalPhaseSeconds = phase.durationSeconds;
    final phaseProgress = 1 - (_phaseSecondsRemaining / totalPhaseSeconds);
    final isExpanding = phase.name == 'Inhale';

    return Column(
      children: [
        const Spacer(),
        BreathingCircle(
          progress: phaseProgress,
          phaseName: phase.name,
          instruction: phase.instruction,
          secondsRemaining: _phaseSecondsRemaining,
          color: widget.exercise.color,
          isExpanding: isExpanding,
        ),
        const Spacer(),
        _buildCycleCounter(),
        const SizedBox(height: AppTheme.spacingLg),
        _buildFinishButton(),
        const SizedBox(height: AppTheme.spacingLg),
      ],
    );
  }

  Widget _buildGroundingExercise() {
    final steps = ExercisesData.groundingSteps;

    return Column(
      children: [
        // Progress indicator
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingLg),
          child: Row(
            children: List.generate(steps.length, (index) {
              final isComplete = index < _currentGroundingStepIndex;
              final isActive = index == _currentGroundingStepIndex;
              return Expanded(
                child: Container(
                  height: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: isComplete || isActive
                        ? widget.exercise.color
                        : widget.exercise.color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
        ),
        // Steps list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: AppTheme.spacingLg),
            itemCount: steps.length,
            itemBuilder: (context, index) {
              final step = steps[index];
              final isActive = index == _currentGroundingStepIndex;
              final isComplete = index < _currentGroundingStepIndex;

              return GroundingStepCard(
                step: step,
                currentCount: isActive ? _currentGroundingItemCount : (isComplete ? step.count : 0),
                isActive: isActive,
                isComplete: isComplete,
                color: widget.exercise.color,
                onItemTap: isActive ? _onGroundingItemTap : null,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPMRExercise() {
    final groups = ExercisesData.muscleGroups;
    final group = groups[_currentMuscleGroupIndex];

    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      child: Column(
        children: [
          // Progress
          LinearProgressIndicator(
            value: (_currentMuscleGroupIndex + (_isTensing ? 0 : 0.5)) / groups.length,
            backgroundColor: widget.exercise.color.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation(widget.exercise.color),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          Text(
            '${_currentMuscleGroupIndex + 1} of ${groups.length}',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textColor.withOpacity(0.6),
            ),
          ),
          const Spacer(),
          // Body diagram
          BodyDiagram(
            activeRegion: group.name,
            isTensing: _isTensing,
            color: widget.exercise.color,
          ),
          const SizedBox(height: AppTheme.spacingXl),
          // Muscle group name
          Text(
            group.name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: widget.exercise.color,
            ),
          ),
          const SizedBox(height: AppTheme.spacingMd),
          // Phase indicator
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingLg,
              vertical: AppTheme.spacingMd,
            ),
            decoration: BoxDecoration(
              color: _isTensing
                  ? widget.exercise.color.withOpacity(0.2)
                  : AppTheme.secondaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            ),
            child: Column(
              children: [
                Text(
                  _isTensing ? 'TENSE' : 'RELAX',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: _isTensing ? widget.exercise.color : AppTheme.secondaryColor,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _isTensing ? group.tensionInstruction : group.releaseInstruction,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textColor.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spacingLg),
          // Timer
          Text(
            '$_pmrSecondsRemaining',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w300,
              color: _isTensing ? widget.exercise.color : AppTheme.secondaryColor,
            ),
          ),
          const Spacer(),
          _buildFinishButton(),
          const SizedBox(height: AppTheme.spacingLg),
        ],
      ),
    );
  }

  Widget _buildBodyScanExercise() {
    final regions = ExercisesData.bodyScanRegions;
    final region = regions[_currentBodyRegionIndex];

    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      child: Column(
        children: [
          // Progress
          LinearProgressIndicator(
            value: (_currentBodyRegionIndex + 1) / regions.length,
            backgroundColor: widget.exercise.color.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation(widget.exercise.color),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          Text(
            '${_currentBodyRegionIndex + 1} of ${regions.length}',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textColor.withOpacity(0.6),
            ),
          ),
          const Spacer(),
          // Body diagram
          BodyDiagram(
            activeRegion: region.name,
            isTensing: false,
            color: widget.exercise.color,
          ),
          const SizedBox(height: AppTheme.spacingXl),
          // Region name
          Text(
            region.name,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: widget.exercise.color,
            ),
          ),
          const SizedBox(height: AppTheme.spacingMd),
          // Instruction
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingLg),
            decoration: BoxDecoration(
              color: widget.exercise.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            ),
            child: Text(
              region.instruction,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: AppTheme.textColor.withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: AppTheme.spacingLg),
          // Timer
          Text(
            '$_bodyScanSecondsRemaining',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w300,
              color: widget.exercise.color,
            ),
          ),
          const Spacer(),
          _buildFinishButton(),
          const SizedBox(height: AppTheme.spacingLg),
        ],
      ),
    );
  }

  Widget _buildCountingBreathExercise() {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      child: Column(
        children: [
          const Spacer(),
          // Breath count
          Text(
            'Breath',
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.textColor.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          Text(
            '${_breathCount + 1}',
            style: TextStyle(
              fontSize: 72,
              fontWeight: FontWeight.w300,
              color: widget.exercise.color,
            ),
          ),
          const SizedBox(height: AppTheme.spacingXl),
          // Breathing animation (simple circle)
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: _isInhaling ? 200 : 140,
            height: _isInhaling ? 200 : 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.exercise.color.withOpacity(0.2),
              border: Border.all(
                color: widget.exercise.color,
                width: 3,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _isInhaling ? Icons.arrow_upward : Icons.arrow_downward,
                    size: 32,
                    color: widget.exercise.color,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _isInhaling ? 'Inhale' : 'Exhale',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: widget.exercise.color,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppTheme.spacingXl),
          Text(
            'Count to 10, then start again',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textColor.withOpacity(0.6),
            ),
          ),
          const Spacer(),
          _buildFinishButton(),
          const SizedBox(height: AppTheme.spacingLg),
        ],
      ),
    );
  }

  Widget _buildCycleCounter() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingLg,
        vertical: AppTheme.spacingMd,
      ),
      decoration: BoxDecoration(
        color: widget.exercise.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.repeat_rounded,
            size: 18,
            color: widget.exercise.color,
          ),
          const SizedBox(width: 8),
          Text(
            'Cycle $_cycleCount',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: widget.exercise.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinishButton() {
    return TextButton(
      onPressed: _completeExercise,
      child: Text(
        'Finish Early',
        style: TextStyle(
          fontSize: 14,
          color: AppTheme.textColor.withOpacity(0.5),
        ),
      ),
    );
  }

  Widget _buildCompletionScreen() {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: widget.exercise.color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_rounded,
              size: 50,
              color: widget.exercise.color,
            ),
          ),
          const SizedBox(height: AppTheme.spacingXl),
          const Text(
            'Well done',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: AppTheme.spacingMd),
          Text(
            'You completed ${widget.exercise.name}',
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.textColor.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: AppTheme.spacingLg),
          // Stats
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingLg),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.timer_outlined,
                  color: widget.exercise.color,
                ),
                const SizedBox(width: 8),
                Text(
                  '${(_totalElapsedSeconds / 60).floor()}:${(_totalElapsedSeconds % 60).toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: widget.exercise.color,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spacingXxl),
          ElevatedButton(
            onPressed: () {
              AppHaptics.lightTap();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.exercise.color,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 18),
            ),
            child: const Text(
              'Done',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
