class Contact {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String url;
  final String photo;
  final String address;
  final String notes;

  Contact({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.url,
    required this.photo,
    required this.address,
    required this.notes,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      url: json['url'],
      photo: json['photo'],
      address: json['address'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'url': url,
      'photo': photo,
      'address': address,
      'notes': notes,
    };
  }
}
