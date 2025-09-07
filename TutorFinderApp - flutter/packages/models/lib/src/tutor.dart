import 'package:equatable/equatable.dart';

class Tutor extends Equatable {
  final String id;
  final String name;
  final String bio;
  final String profileImageUrl;
  final String category;
  final List<dynamic> subjects;
  final double rating;
  final int reviewCount;
  final int studentCount;

  const Tutor({
    required this.id,
    required this.name,
    required this.bio,
    required this.profileImageUrl,
    required this.category,
    required this.subjects,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.studentCount = 0,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        bio,
        profileImageUrl,
        category,
        subjects,
        rating,
        reviewCount,
        studentCount,
      ];

  factory Tutor.fromJson(
    Map<String, dynamic> json, {
    String? id,
  }) {
    return Tutor(
      id: id ?? json['id'] ?? '',
      name: json['name'] ?? '',
      bio: json['bio'] ?? '',
      profileImageUrl: json['profileImageUrl'] ??
          'https://source.unsplash.com/random/?fashion',
      category: json['category'] ?? '',
      subjects: List<String>.from(json['subjects']),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] as int? ?? 0,
      studentCount: json['studentCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'bio': bio,
      'profileImageUrl': profileImageUrl,
      'category': category,
      'subjects': subjects,
      'rating': rating,
      'reviewCount': reviewCount,
      'studentCount': studentCount,
    };
  }

  /*static const sampleTutors = [
    Tutor(
      id: '1',
      name: 'Amer Alloush',
      bio:
          'Born into a family of educators, I discovered my love for mathematics at a young age. With a desire to inspire and innovate, I embarked on a mission to teach math in a way that sparks curiosity and fosters understanding. Through creativity and dedication, I strive to empower my students to embrace math as both a tool for problem-solving and a source of endless fascination.',
      profileImageUrl:
          'https://images.unsplash.com/photo-1557683316-973673baf926',
      category: TutorCategories.math,
      subjects: TutorSubjects.sampleSubjects,
      rating: 4.5,
      reviewCount: 100,
      studentCount: 1000,
    ),
    Tutor(
      id: '2',
      name: 'Amer Alloush',
      bio: 'Geographic teacher',
      profileImageUrl:
          'https://images.unsplash.com/photo-1557683316-973673baf926',
      category: TutorCategories.geography,
      subjects: TutorSubjects.sampleSubjects,
      rating: 4.5,
      reviewCount: 100,
      studentCount: 1000,
    ),
    Tutor(
      id: '3',
      name: 'Amer Alloush',
      bio: 'Geographic teacher',
      profileImageUrl:
          'https://images.unsplash.com/photo-1557683316-973673baf926',
      category: TutorCategories.geography,
      subjects: TutorSubjects.sampleSubjects,
      rating: 4.5,
      reviewCount: 100,
      studentCount: 1000,
    ),
    Tutor(
      id: '4',
      name: 'Amer Alloush',
      bio: 'Geographic teacher',
      profileImageUrl:
          'https://images.unsplash.com/photo-1557683316-973673baf926',
      category: TutorCategories.geography,
      subjects: TutorSubjects.sampleSubjects,
      rating: 4.5,
      reviewCount: 100,
      studentCount: 1000,
    ),
  ];
  */
}
