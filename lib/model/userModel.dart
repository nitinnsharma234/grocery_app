class User {
  User({
    this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.carbs,
    this.fats,
    this.sugar,
    this.fiber,
    this.protein,
  });

  final String email;
  final String? id;
  final String firstName;
  final String lastName;
  final int? protein;
  final int? carbs;
  final int? fats;
  final int? sugar;
  final int? fiber;

  User.fromJson(Map<String, dynamic> json,String id)
      : this(
      id:id,
      email: json['email']!,
      firstName: json['firstName']!,
      lastName: json['lastName']!,
      protein: json['protein']!,
      carbs: json['carbs']!,
      fats: json['fats']!,
      sugar: json['sugar']!,
      fiber: json['fiber']!
  );
}


class UserProfile {

  UserProfile({
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.sugar,
    required this.fiber,
  });


  final int protein;
  final int carbs;
  final int fats;
  final int sugar;
  final int fiber;

  Map<String, Object?> toJson() {
    return {
      'protein': protein,
      'carbs': carbs,
      'fats': fats,
      'sugar': sugar,
      'fiber': fiber,
    };
  }
}
