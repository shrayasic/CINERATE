import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String user;
  final String comment;
  final Timestamp timestamp;

  Review({required this.user, required this.comment, required this.timestamp});

  Map<String, dynamic> toJson() => {
    'user': user,
    'comment': comment,
    'timestamp': timestamp, // Store directly as Timestamp
  };

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      user: json['user'],
      comment: json['comment'],
      timestamp: json['timestamp'] as Timestamp, // Cast to Timestamp
    );
  }
}
