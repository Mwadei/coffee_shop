import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    // ignore: unnecessary_null_comparison
    if (db == null) {
      _db = await initalDb();
      return _db;
    } else {
      return _db;
    }
  }

  initalDb() async {
    //database path
    String databasePath = await getDatabasesPath();

    // create database
    String path = join(databasePath, 'coffee_shop.db');
    Database db =
        await openDatabase(path, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return db;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) {
    print("yyeeess");
  }

  //onCreata function to create tables
  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE "coffee" (
      "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "name" TEXT NOT NULL,
      "imagePath" TEXT,
      "price" REAL,
      "description" TEXT,
      "volume" TEXT
    )
    ''');

    print("good");
  }

  //Select function
  select(String sql) async {
    Database? db = await _db;
    List<Map> result = await db!.rawQuery(sql);
    return result;
  }

  //delete function
  delete(String sql) async {
    Database? db = await _db;
    int result = await db!.rawDelete(sql);
    return result;
  }

  //update function
  update(String sql) async {
    Database? db = await _db;
    int result = await db!.rawUpdate(sql);
    return result;
  }

  //insert function
  insert(String sql) async {
    Database? db = await _db;
    int result = await db!.rawInsert(sql);
    return result;
  }
}
