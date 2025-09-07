class TutorSubjects {
  final String id;
  final String tutorId;
  final String subjectName;
  final String description;
  final Duration duration;
  final double price;

  const TutorSubjects({
    required this.id,
    required this.tutorId,
    required this.subjectName,
    required this.description,
    required this.duration,
    required this.price,
  });

  static const sampleSubjects = [
    TutorSubjects(
      id: '1',
      tutorId: '1',
      subjectName: 'Basic',
      description: 'Basic consultation package',
      duration: Duration(minutes: 30),
      price: 100,
    ),
    TutorSubjects(
      id: '2',
      tutorId: '1',
      subjectName: 'Standard',
      description: 'Standard consultation package',
      duration: Duration(minutes: 60),
      price: 200,
    ),
    TutorSubjects(
      id: '3',
      tutorId: '1',
      subjectName: 'Premium',
      description: 'Premium consultation package',
      duration: Duration(minutes: 90),
      price: 300,
    ),
  ];
}
