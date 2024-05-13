


class Farmer {

late final int? id;
  final String? productId;
  final String? name;
  
  final String? phone;
  final String? address;

 Farmer({this.id, this.productId, this.name, this.phone, this.address});

Farmer.fromMap(Map<dynamic , dynamic>  res)
:
   id=res["id"],
   productId = res["productId"],
  name = res["name"],
  phone = res["phone"],
  address = res["address"];

  Map<String, Object?> toMap(){
    return {
      "id":id,
      "productId":productId,
      'name' : name,
      'phone' : phone,
      'address' : address,
    };
  }
}