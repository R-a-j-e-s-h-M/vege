



import 'dart:convert';



class  Orderdelivered{


  final String orderdelivered;


Orderdelivered({
    required this.orderdelivered, 
  });

  Map<String, dynamic> toMap() {
    return {
    
      'orderdelivered': orderdelivered,
    };
  }

  factory Orderdelivered.fromMap(Map<String, dynamic> map) {
    return Orderdelivered(
    
      orderdelivered: map['orderdelivered'] ?? '',
     
    );
  }

  String toJson() => json.encode(toMap());

  factory Orderdelivered.fromJson(String source) => Orderdelivered.fromMap(json.decode(source));

  Orderdelivered copyWith({
    
    String? orderdelivered,
  
  }) {
    return Orderdelivered(
      orderdelivered: orderdelivered?? this.orderdelivered,
      
    );
  }
}

class  Orderdispatched{

  final String orderdispatched;


Orderdispatched({
    required this.orderdispatched, 
  });

  Map<String, dynamic> toMap() {
    return {
    
      'orderdispatched': orderdispatched,
    };
  }

  factory Orderdispatched.fromMap(Map<String, dynamic> map) {
    return Orderdispatched(
    
      orderdispatched: map['orderdispatched'] ?? '',
     
    );
  }

  String toJson() => json.encode(toMap());

  factory Orderdispatched.fromJson(String source) => Orderdispatched.fromMap(json.decode(source));

  Orderdispatched copyWith({
    
    String? orderdispatched,
  
  }) {
    return Orderdispatched(
      orderdispatched: orderdispatched?? this.orderdispatched,
      
    );
  }
}



class  Orderpacked{

  final String orderpacked;


Orderpacked({
    required this.orderpacked, 
  });

  Map<String, dynamic> toMap() {
    return {
    
      'orderpacked': orderpacked,
    };
  }

  factory Orderpacked.fromMap(Map<String, dynamic> map) {
    return Orderpacked(
    
      orderpacked: map['orderpacked'] ?? '',
     
    );
  }

  String toJson() => json.encode(toMap());

  factory Orderpacked.fromJson(String source) => Orderpacked.fromMap(json.decode(source));

  Orderpacked copyWith({
    
    String? orderpacked,
  
  }) {
    return Orderpacked(
      orderpacked: orderpacked?? this.orderpacked,
      
    );
  }
}







class  Orderplaced{

  final String orderplaced;


Orderplaced({
    required this.orderplaced, 
  });

  Map<String, dynamic> toMap() {
    return {
    
      'orderplaced': orderplaced,
    };
  }

  factory Orderplaced.fromMap(Map<String, dynamic> map) {
    return Orderplaced(
    
      orderplaced: map['orderplaced'] ?? '',
     
    );
  }

  String toJson() => json.encode(toMap());

  factory Orderplaced.fromJson(String source) => Orderplaced.fromMap(json.decode(source));

  Orderplaced copyWith({
    
    String? orderplaced,
  
  }) {
    return Orderplaced(
      orderplaced: orderplaced?? this.orderplaced,
      
    );
  }
}


