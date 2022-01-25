class UserModel {
  final String? id;
  final String? name;
  final String? imageUrl;
  final int? mobileNumber;
  final String? address;
  final String? email;
  final int? points;
  final List<Map<String, dynamic>>? orders;
  final List<Map<String, dynamic>>? payments;

//<editor-fold desc="Data Methods">

  UserModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.mobileNumber,
    required this.address,
    required this.email,
    required this.points,
    required this.orders,
    required this.payments,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          imageUrl == other.imageUrl &&
          mobileNumber == other.mobileNumber &&
          address == other.address &&
          email == other.email &&
          points == other.points &&
          orders == other.orders &&
          payments == other.payments);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      imageUrl.hashCode ^
      mobileNumber.hashCode ^
      address.hashCode ^
      email.hashCode ^
      points.hashCode ^
      orders.hashCode ^
      payments.hashCode;

  @override
  String toString() {
    return 'User{' +
        ' id: $id,' +
        ' name: $name,' +
        ' imageUrl: $imageUrl,' +
        ' mobileNumber: $mobileNumber,' +
        ' address: $address,' +
        ' email: $email,' +
        ' points: $points,' +
        ' orders: $orders,' +
        ' payments: $payments,' +
        '}';
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? imageUrl,
    int? mobileNumber,
    String? address,
    String? email,
    int? points,
    List<Map<String, dynamic>>? orders,
    List<Map<String, dynamic>>? payments,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      address: address ?? this.address,
      email: email ?? this.email,
      points: points ?? this.points,
      orders: orders ?? this.orders,
      payments: payments ?? this.payments,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'mobileNumber': mobileNumber,
      'address': address,
      'email': email,
      'points': points,
      'orders': orders,
      'payments': payments,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
      mobileNumber: map['mobileNumber'] as int,
      address: map['address'] as String,
      email: map['email'] as String,
      points: map['points'] as int,
      orders: map['orders'] as List<Map<String, dynamic>>,
      payments: map['payments'] as List<Map<String, dynamic>>,
    );
  }
//</editor-fold>
}
