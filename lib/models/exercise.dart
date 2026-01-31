import 'package:flutter/material.dart';

enum ExerciseType {
  boxBreathing,
  breathing478,
  grounding54321,
  progressiveMuscleRelaxation,
  bodyScan,
  countingBreath,
}

class Exercise {
  final String id;
  final String name;
  final String shortDescription;
  final String fullDescription;
  final String duration;
  final IconData icon;
  final Color color;
  final ExerciseType type;
  final List<String> benefits;
  final String evidenceBasis;

  const Exercise({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.fullDescription,
    required this.duration,
    required this.icon,
    required this.color,
    required this.type,
    required this.benefits,
    required this.evidenceBasis,
  });
}

class BreathingPhase {
  final String name;
  final int durationSeconds;
  final String instruction;

  const BreathingPhase({
    required this.name,
    required this.durationSeconds,
    required this.instruction,
  });
}

class GroundingStep {
  final int count;
  final String sense;
  final String instruction;
  final IconData icon;

  const GroundingStep({
    required this.count,
    required this.sense,
    required this.instruction,
    required this.icon,
  });
}

class MuscleGroup {
  final String name;
  final String tensionInstruction;
  final String releaseInstruction;
  final int tensionDuration;
  final int relaxDuration;

  const MuscleGroup({
    required this.name,
    required this.tensionInstruction,
    required this.releaseInstruction,
    this.tensionDuration = 5,
    this.relaxDuration = 10,
  });
}

class BodyRegion {
  final String name;
  final String instruction;
  final int durationSeconds;

  const BodyRegion({
    required this.name,
    required this.instruction,
    required this.durationSeconds,
  });
}
