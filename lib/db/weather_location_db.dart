import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '/models/saved_location.dart';

class LocationDB {

  static Database? _database;

  static Future<Database> get database async {

    if (_database != null) {
      return _database!;
    }

    _database = await initDB();

    return _database!;
  }

  static Future<Database> initDB() async {

    final dbPath = await getDatabasesPath();

    final path = join(dbPath, 'locations.db');

    return await openDatabase(
      path,

      version: 1,

      onCreate: (db, version) async {

        await db.execute('''
          CREATE TABLE locations(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            city TEXT,
            label TEXT,
            description TEXT
          )
        ''');
      },
    );
  }
  //*simpan lokasi
  static Future<void> insertLocation(SavedLocation location) async {
    final db = await database;
    await db.insert(
      'locations',
      location.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //*ambil semua lokasi
  static Future<List<SavedLocation>> getLocations() async {
  final db = await database;
    final maps = await db.query(
      'locations',
      orderBy: 'id DESC', // ← terbaru di atas
    );
    return maps.map((e) => SavedLocation.fromMap(e)).toList();
  }

  //*hapus lokasi by id
  static Future<void> deleteLocation(int id) async {
    final db = await database;
    await db.delete('locations', where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> updateLocation(SavedLocation location) async {
  final db = await database;
  await db.update(
    'locations',
    location.toMap(),
    where: 'id = ?',
    whereArgs: [location.id],
    );
  }
}