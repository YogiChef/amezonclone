class SuppModel {
  String? name;
  String? id;
  String? email;
  String? photoUrl;
  String? ratings;

  SuppModel({
    this.name,
    this.id,
    this.email,
    this.photoUrl,
    this.ratings,
  });

  SuppModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    email = json['email'];
    photoUrl = json['photoUrl'];
    ratings = json['ratings'];


  }
}
