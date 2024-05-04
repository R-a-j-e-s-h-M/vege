
import 'dart:convert';




class Addressmodel {

  final String address;
  final String phonenumber;
  final String  landmark;

Addressmodel({
    required this.address,
    required this.phonenumber,
    required this.landmark
    
  });

  Map<String, dynamic> toMap() {
    return {
    
      'address': address,
      'phonenumber': phonenumber,
      'landmark': landmark,
   
     
    
    };
  }

  factory Addressmodel.fromMap(Map<String, dynamic> map) {
    return Addressmodel(
    
      address: map['address'] ?? '',
      phonenumber: map['phonenumber'] ?? '',
      landmark: map['landmark'] ?? '',
     
     
     
    );
  }

  String toJson() => json.encode(toMap());

  factory Addressmodel.fromJson(String source) => Addressmodel.fromMap(json.decode(source));

  Addressmodel copyWith({
    
    String? address,
    String? phonenumber,
    String? landmark,
    
    
  
  }) {
    return Addressmodel(
      
      address: address?? this.address,
      phonenumber: phonenumber?? this.phonenumber,
      landmark: landmark ?? this.landmark,
    
      
      
    );
  }
}