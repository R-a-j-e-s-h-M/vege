









import 'dart:io' as io;
import 'package:path/path.dart';


import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:vegetable/presentation/farmerdetails/farmermodel.dart';

class DB {

  static Database? _db ;

  Future<Database?> get db async {
    if(_db != null){
      return _db!;
    }

    _db = await initDatabase();
  }

  initDatabase()async{
    io.Directory documentDirectory = await getApplicationDocumentsDirectory() ;
    String path = join(documentDirectory.path , 'farme.db');
    var db = await openDatabase(path , version: 1 , onCreate: _onCreate,);
    return db ;
  }

  _onCreate (Database db , int version )async{
    await db
        .execute('CREATE TABLE farme (id INTEGER PRIMARY KEY , productId VARCHAR UNIQUE,name TEXT, phone TEXT , address TEXT )');
  }

  Future<Farmer> insert(Farmer farmer)async{
    print(farmer.toMap());
    var dbClient = await db ;
    await dbClient!.insert('farme', farmer.toMap());
    return farmer ;
  }

  Future<List<Farmer>> getCartList()async{
    var dbClient = await db ;
    final List<Map<String , Object?>> queryResult =  await dbClient!.query('farme');
    return queryResult.map((e) => Farmer.fromMap(e)).toList();

  }

  Future<int> delete(int id)async{
    var dbClient = await db ;
    return await dbClient!.delete(
      'farme',
      where: 'id = ?',
      whereArgs: [id]
    );
  }

  Future<int> updateQuantity(Farmer cart)async{
    var dbClient = await db ;
    return await dbClient!.update(
        'farme',
        cart.toMap(),
        where: 'id = ?',
        whereArgs: [cart.id]
    );
  }
}


