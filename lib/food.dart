import 'dart:convert';

class Food {
  String? id;
  String? name;
  String? price;
  String? photo;
  Food({
    this.id,
    this.name,
    this.price,
    this.photo,
  });

  Food copyWith({
    String? id,
    String? name,
    String? price,
    String? photo,
  }) {
    return Food(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      photo: photo ?? this.photo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'photo': photo,
    };
  }

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
      photo: map['photo'] != null ? map['photo'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Food.fromJson(String source) =>
      Food.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Food(id: $id, name: $name, price: $price, photo: $photo)';
  }

  @override
  bool operator ==(covariant Food other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.price == price &&
        other.photo == photo;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ price.hashCode ^ photo.hashCode;
  }
}
