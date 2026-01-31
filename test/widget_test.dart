import 'package:flutter_test/flutter_test.dart';
import 'package:selfhelp/app.dart';
import 'package:selfhelp/data/exercises_data.dart';

void main() {
  testWidgets('App renders home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const SelfHelpApp());

    // Verify app title is displayed
    expect(find.text('SelfHelp'), findsOneWidget);

    // Verify exercises section exists
    expect(find.text('Exercises'), findsOneWidget);
  });

  test('Exercises data is properly configured', () {
    // Verify we have all 6 exercises
    expect(ExercisesData.exercises.length, 6);

    // Verify each exercise has required data
    for (final exercise in ExercisesData.exercises) {
      expect(exercise.id.isNotEmpty, true);
      expect(exercise.name.isNotEmpty, true);
      expect(exercise.shortDescription.isNotEmpty, true);
      expect(exercise.fullDescription.isNotEmpty, true);
      expect(exercise.benefits.isNotEmpty, true);
    }
  });

  test('Box breathing phases are correctly configured', () {
    final phases = ExercisesData.boxBreathingPhases;
    expect(phases.length, 4);

    // Each phase should be 4 seconds for box breathing
    for (final phase in phases) {
      expect(phase.durationSeconds, 4);
    }
  });

  test('4-7-8 breathing phases are correctly configured', () {
    final phases = ExercisesData.breathing478Phases;
    expect(phases.length, 3);

    // Verify timing: 4-7-8
    expect(phases[0].durationSeconds, 4); // Inhale
    expect(phases[1].durationSeconds, 7); // Hold
    expect(phases[2].durationSeconds, 8); // Exhale
  });

  test('Grounding steps follow 5-4-3-2-1 pattern', () {
    final steps = ExercisesData.groundingSteps;
    expect(steps.length, 5);

    expect(steps[0].count, 5);
    expect(steps[1].count, 4);
    expect(steps[2].count, 3);
    expect(steps[3].count, 2);
    expect(steps[4].count, 1);
  });

  test('PMR has 10 muscle groups', () {
    expect(ExercisesData.muscleGroups.length, 10);
  });

  test('Body scan has multiple regions', () {
    expect(ExercisesData.bodyScanRegions.length, greaterThan(5));
  });
}
