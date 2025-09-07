import 'package:flutter/material.dart';

enum TutorCategories {
  math(
    name: 'Mathematics',
    icon: Icons.calculate,
  ),
  english(
    name: 'English',
    icon: Icons.book,
  ),
  informatics(
    name: 'Informatics',
    icon: Icons.computer,
  ),
  science(
    name: 'Science',
    icon: Icons.science,
  ),
  history(
    name: 'History',
    icon: Icons.history,
  ),
  geography(
    name: 'Geography',
    icon: Icons.public,
  ),
  art(
    name: 'Art',
    icon: Icons.palette,
  ),
  music(
    name: 'Music',
    icon: Icons.music_note,
  ),
  physicalEducation(
    name: 'Physical Education',
    icon: Icons.directions_run,
  ),
  religion(
    name: 'Religion',
    icon: Icons.account_balance,
  );

  final String name;
  final IconData icon;

  const TutorCategories({
    required this.name,
    required this.icon,
  });
}
