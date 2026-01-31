import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../theme/app_theme.dart';

class ExercisesData {
  static const List<Exercise> exercises = [
    Exercise(
      id: 'box_breathing',
      name: 'Box Breathing',
      shortDescription: 'Calm your mind with 4-4-4-4 rhythm',
      fullDescription:
          'Box breathing is a powerful stress-relief technique used by Navy SEALs. '
          'By breathing in a square pattern—inhale, hold, exhale, hold—each for 4 seconds, '
          'you activate your parasympathetic nervous system and reduce anxiety.',
      duration: '2-5 min',
      icon: Icons.crop_square_rounded,
      color: AppTheme.primaryColor,
      type: ExerciseType.boxBreathing,
      benefits: [
        'Activates parasympathetic nervous system',
        'Reduces cortisol levels',
        'Improves focus and clarity',
        'Can be done anywhere, anytime',
      ],
      evidenceBasis: 'Used by Navy SEALs and clinically proven to reduce stress response',
    ),
    Exercise(
      id: 'breathing_478',
      name: '4-7-8 Breathing',
      shortDescription: 'The relaxing breath technique',
      fullDescription:
          'Developed by Dr. Andrew Weil based on ancient yogic breathing practices (pranayama). '
          'This technique acts as a natural tranquilizer for the nervous system. '
          'Inhale for 4, hold for 7, exhale for 8 counts.',
      duration: '1-3 min',
      icon: Icons.circle_outlined,
      color: AppTheme.secondaryColor,
      type: ExerciseType.breathing478,
      benefits: [
        'Natural tranquilizer for nervous system',
        'Helps with falling asleep',
        'Reduces anxiety quickly',
        'Based on ancient yogic practices',
      ],
      evidenceBasis: 'Developed by Dr. Andrew Weil, based on pranayama yoga',
    ),
    Exercise(
      id: 'grounding_54321',
      name: '5-4-3-2-1 Grounding',
      shortDescription: 'Ground yourself using your senses',
      fullDescription:
          'A core CBT technique that helps during panic attacks or moments of dissociation. '
          'By focusing on what you can perceive with each sense, you anchor yourself '
          'to the present moment and break the cycle of anxious thoughts.',
      duration: '3-5 min',
      icon: Icons.self_improvement,
      color: AppTheme.accentColor,
      type: ExerciseType.grounding54321,
      benefits: [
        'Effective for panic attacks',
        'Grounds you in present moment',
        'Breaks cycle of anxious thoughts',
        'No special equipment needed',
      ],
      evidenceBasis: 'Core CBT technique for panic and dissociation',
    ),
    Exercise(
      id: 'pmr',
      name: 'Muscle Relaxation',
      shortDescription: 'Release tension through your body',
      fullDescription:
          'Progressive Muscle Relaxation (PMR) was developed by Dr. Edmund Jacobson. '
          'By systematically tensing and releasing muscle groups, you become aware of '
          'physical tension and learn to release it, reducing overall anxiety.',
      duration: '5-15 min',
      icon: Icons.accessibility_new,
      color: AppTheme.warmPeach,
      type: ExerciseType.progressiveMuscleRelaxation,
      benefits: [
        'Releases physical tension',
        'Increases body awareness',
        'Reduces muscle pain from stress',
        'Improves sleep quality',
      ],
      evidenceBasis: 'Developed by Edmund Jacobson, extensively studied',
    ),
    Exercise(
      id: 'body_scan',
      name: 'Body Scan',
      shortDescription: 'Mindful attention through your body',
      fullDescription:
          'A core technique from Mindfulness-Based Stress Reduction (MBSR). '
          'Guide your attention slowly through each part of your body, '
          'noticing sensations without judgment. This cultivates present-moment awareness.',
      duration: '5-10 min',
      icon: Icons.person_outline,
      color: AppTheme.mintGreen,
      type: ExerciseType.bodyScan,
      benefits: [
        'Cultivates mindfulness',
        'Reduces physical tension',
        'Increases body awareness',
        'Promotes relaxation',
      ],
      evidenceBasis: 'Core MBSR technique, clinically validated',
    ),
    Exercise(
      id: 'counting_breath',
      name: 'Counting Breath',
      shortDescription: 'Simple meditation with breath counting',
      fullDescription:
          'A traditional meditation technique that uses counting to maintain focus. '
          'Simply count each exhale from 1 to 10, then start over. '
          'When your mind wanders, gently return to counting.',
      duration: '2-10 min',
      icon: Icons.filter_1,
      color: AppTheme.paleBlue,
      type: ExerciseType.countingBreath,
      benefits: [
        'Improves concentration',
        'Calms racing thoughts',
        'Easy for beginners',
        'Builds meditation habit',
      ],
      evidenceBasis: 'Traditional meditation technique, clinically validated',
    ),
  ];

  // Box Breathing phases (4-4-4-4)
  static const List<BreathingPhase> boxBreathingPhases = [
    BreathingPhase(name: 'Inhale', durationSeconds: 4, instruction: 'Breathe in slowly'),
    BreathingPhase(name: 'Hold', durationSeconds: 4, instruction: 'Hold your breath'),
    BreathingPhase(name: 'Exhale', durationSeconds: 4, instruction: 'Breathe out slowly'),
    BreathingPhase(name: 'Hold', durationSeconds: 4, instruction: 'Hold empty'),
  ];

  // 4-7-8 Breathing phases
  static const List<BreathingPhase> breathing478Phases = [
    BreathingPhase(name: 'Inhale', durationSeconds: 4, instruction: 'Breathe in through your nose'),
    BreathingPhase(name: 'Hold', durationSeconds: 7, instruction: 'Hold your breath'),
    BreathingPhase(name: 'Exhale', durationSeconds: 8, instruction: 'Exhale completely through mouth'),
  ];

  // 5-4-3-2-1 Grounding steps
  static const List<GroundingStep> groundingSteps = [
    GroundingStep(
      count: 5,
      sense: 'See',
      instruction: 'Look around and name 5 things you can see',
      icon: Icons.visibility,
    ),
    GroundingStep(
      count: 4,
      sense: 'Touch',
      instruction: 'Notice 4 things you can physically feel',
      icon: Icons.touch_app,
    ),
    GroundingStep(
      count: 3,
      sense: 'Hear',
      instruction: 'Listen for 3 sounds you can hear',
      icon: Icons.hearing,
    ),
    GroundingStep(
      count: 2,
      sense: 'Smell',
      instruction: 'Notice 2 things you can smell',
      icon: Icons.air,
    ),
    GroundingStep(
      count: 1,
      sense: 'Taste',
      instruction: 'Notice 1 thing you can taste',
      icon: Icons.restaurant,
    ),
  ];

  // Progressive Muscle Relaxation muscle groups
  static const List<MuscleGroup> muscleGroups = [
    MuscleGroup(
      name: 'Hands & Forearms',
      tensionInstruction: 'Make tight fists and bend your wrists',
      releaseInstruction: 'Release and feel the warmth flow in',
    ),
    MuscleGroup(
      name: 'Upper Arms',
      tensionInstruction: 'Bend your elbows and tense your biceps',
      releaseInstruction: 'Let your arms fall relaxed',
    ),
    MuscleGroup(
      name: 'Forehead',
      tensionInstruction: 'Raise your eyebrows as high as you can',
      releaseInstruction: 'Let your forehead become smooth',
    ),
    MuscleGroup(
      name: 'Eyes & Cheeks',
      tensionInstruction: 'Squeeze your eyes shut tightly',
      releaseInstruction: 'Relax and let your eyes rest',
    ),
    MuscleGroup(
      name: 'Jaw',
      tensionInstruction: 'Clench your jaw and press your tongue to the roof',
      releaseInstruction: 'Let your jaw drop and mouth relax',
    ),
    MuscleGroup(
      name: 'Neck & Shoulders',
      tensionInstruction: 'Raise your shoulders up toward your ears',
      releaseInstruction: 'Drop your shoulders and feel the release',
    ),
    MuscleGroup(
      name: 'Chest',
      tensionInstruction: 'Take a deep breath and hold it',
      releaseInstruction: 'Exhale slowly and relax',
    ),
    MuscleGroup(
      name: 'Stomach',
      tensionInstruction: 'Tighten your stomach muscles',
      releaseInstruction: 'Release and let your belly soften',
    ),
    MuscleGroup(
      name: 'Thighs',
      tensionInstruction: 'Press your knees together and tighten',
      releaseInstruction: 'Release and feel the warmth',
    ),
    MuscleGroup(
      name: 'Calves & Feet',
      tensionInstruction: 'Point your toes and tense your calves',
      releaseInstruction: 'Release and wiggle your toes',
    ),
  ];

  // Body Scan regions
  static const List<BodyRegion> bodyScanRegions = [
    BodyRegion(
      name: 'Feet',
      instruction: 'Bring your attention to your feet. Notice any sensations—warmth, coolness, pressure, or tingling.',
      durationSeconds: 20,
    ),
    BodyRegion(
      name: 'Lower Legs',
      instruction: 'Move your attention up to your calves and shins. Simply observe whatever you feel.',
      durationSeconds: 20,
    ),
    BodyRegion(
      name: 'Upper Legs',
      instruction: 'Notice your thighs and knees. Feel the weight of your legs resting.',
      durationSeconds: 20,
    ),
    BodyRegion(
      name: 'Hips & Pelvis',
      instruction: 'Bring awareness to your hips and lower back. Notice where your body contacts the surface.',
      durationSeconds: 20,
    ),
    BodyRegion(
      name: 'Stomach',
      instruction: 'Feel your belly rising and falling with each breath. Notice any tension.',
      durationSeconds: 20,
    ),
    BodyRegion(
      name: 'Chest',
      instruction: 'Observe your chest expanding and contracting. Feel your heartbeat if you can.',
      durationSeconds: 20,
    ),
    BodyRegion(
      name: 'Hands & Arms',
      instruction: 'Notice your fingers, palms, and arms. Feel any tingling or warmth.',
      durationSeconds: 20,
    ),
    BodyRegion(
      name: 'Shoulders',
      instruction: 'Bring attention to your shoulders. This is where we often hold stress.',
      durationSeconds: 20,
    ),
    BodyRegion(
      name: 'Neck & Throat',
      instruction: 'Notice your neck and throat. Let any tension melt away.',
      durationSeconds: 20,
    ),
    BodyRegion(
      name: 'Face',
      instruction: 'Scan your jaw, cheeks, eyes, and forehead. Let your face soften.',
      durationSeconds: 20,
    ),
    BodyRegion(
      name: 'Top of Head',
      instruction: 'Finally, notice the top of your head. Feel your whole body at once.',
      durationSeconds: 20,
    ),
  ];
}
