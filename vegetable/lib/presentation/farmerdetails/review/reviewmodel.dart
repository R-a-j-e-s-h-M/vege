






import 'dart:convert';




class ReviewModal {

  final String username;
  final String rating;
  final String date;
  final String reviewcontent;
ReviewModal({
    required this.username,
    required this.rating,
    required this.date,
    required this.reviewcontent,  
    
  });

  Map<String, dynamic> toMap() {
    return {
    
      'username': username,
      'rating': rating,
      'date': date,
      "reviewcontent": reviewcontent,
     
    
    };
  }

  factory ReviewModal.fromMap(Map<String, dynamic> map) {
    return ReviewModal(
    
      username: map['username'] ?? '',
      rating: map['rating'] ?? '',
      date: map['date'] ?? '',
      reviewcontent: map['reviewcontent'] ?? '',
     
     
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewModal.fromJson(String source) => ReviewModal.fromMap(json.decode(source));

  ReviewModal copyWith({
    
    String? username,
    String? rating,
    String? date,
    String? reviewcontent,
    
  
  }) {
    return ReviewModal(
      
      username: username ?? this.username,
      rating: rating ?? this.rating,
      date: date ?? this.date,
      reviewcontent: reviewcontent ?? this.reviewcontent,
    
      
      
    );
  }
}