class GetAllFavoriteMovie {
  GetAllFavoriteMovie({
    this.message,
    this.data,
  });

  GetAllFavoriteMovie.fromJson(dynamic json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(FavoriteMovie.fromJson(v));
      });
    }
  }

  String? message;
  List<FavoriteMovie>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class FavoriteMovie {
  FavoriteMovie({
    this.movieId,
    this.name,
    this.rating,
    this.imageURL,
    this.year,
  });

  FavoriteMovie.fromJson(dynamic json) {
    if (json['movieId'] is String) {
      movieId = int.tryParse(json['movieId']);
    } else {
      movieId = json['movieId'];
    }

    name = json['name'];
    rating = (json['rating'] as num?)?.toDouble();
    imageURL = json['imageURL'];

    if (json['year'] is String) {
      year = int.tryParse(json['year']);
    } else {
      year = json['year'];
    }
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
