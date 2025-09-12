class AddToFavoriteResponse {
  AddToFavoriteResponse({
    this.message,
    this.data,
  });

  AddToFavoriteResponse.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'] != null ? FavoriteData.fromJson(json['data']) : null;
  }

  String? message;
  FavoriteData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class FavoriteData {
  FavoriteData({
    this.movieId,
    this.name,
    this.rating,
    this.imageURL,
    this.year,
  });

  FavoriteData.fromJson(dynamic json) {
    movieId = json['movieId'];
    name = json['name'];
    rating = (json['rating'] as num?)?.toDouble();
    imageURL = json['imageURL'];
    year = json['year'];
  }

  int? movieId;
  String? name;
  double? rating;
  String? imageURL;
  int? year;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['movieId'] = movieId;
    map['name'] = name;
    map['rating'] = rating;
    map['imageURL'] = imageURL;
    map['year'] = year;
    return map;
  }
}
