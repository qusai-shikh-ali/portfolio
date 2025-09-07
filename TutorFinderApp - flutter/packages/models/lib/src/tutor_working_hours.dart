import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class TutorWorkingHours extends Equatable {
  final String id;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String dayOfWeek;

  const TutorWorkingHours({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.dayOfWeek,
  });

  @override
  List<Object?> get props => [id, startTime, endTime, dayOfWeek];

  static const sampleTutorWorkingHours = [
    TutorWorkingHours(
      id: '1',
      startTime: TimeOfDay(hour: 8, minute: 0),
      endTime: TimeOfDay(hour: 12, minute: 0),
      dayOfWeek: 'Monday',
    ),
    TutorWorkingHours(
      id: '2',
      startTime: TimeOfDay(hour: 8, minute: 0),
      endTime: TimeOfDay(hour: 12, minute: 0),
      dayOfWeek: 'Tuesday',
    ),
    TutorWorkingHours(
      id: '3',
      startTime: TimeOfDay(hour: 8, minute: 0),
      endTime: TimeOfDay(hour: 12, minute: 0),
      dayOfWeek: 'Wednesday',
    ),
    TutorWorkingHours(
      id: '4',
      startTime: TimeOfDay(hour: 8, minute: 0),
      endTime: TimeOfDay(hour: 12, minute: 0),
      dayOfWeek: 'Thursday',
    ),
    TutorWorkingHours(
      id: '5',
      startTime: TimeOfDay(hour: 8, minute: 0),
      endTime: TimeOfDay(hour: 12, minute: 0),
      dayOfWeek: 'Friday',
    ),
    TutorWorkingHours(
      id: '6',
      startTime: TimeOfDay(hour: 8, minute: 0),
      endTime: TimeOfDay(hour: 12, minute: 0),
      dayOfWeek: 'Saturday',
    ),
    TutorWorkingHours(
      id: '7',
      startTime: TimeOfDay(hour: 8, minute: 0),
      endTime: TimeOfDay(hour: 12, minute: 0),
      dayOfWeek: 'Sunday',
    ),
  ];
}
