class RemoveFavoriteResponse {
  String? message;

  RemoveFavoriteResponse({this.message});

  RemoveFavoriteResponse.fromJson(dynamic json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }
}
