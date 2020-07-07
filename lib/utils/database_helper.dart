import 'package:flutter/cupertino.dart';
import 'package:myapp/models/route.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

	static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
	static Database _database;                // Singleton Database

	String trackTable = 'track_table';
	String colId = 'id';
	String colDate = 'date';
	String colRoute = 'route';

	DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

	factory DatabaseHelper() {

		if (_databaseHelper == null) {
			_databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
		}
		return _databaseHelper;
	}

	Future<Database> get database async {

		if (_database == null) {
			_database = await initializeDatabase();
		}
		return _database;
	}

	Future<Database> initializeDatabase() async {
		// Get the directory path for both Android and iOS to store database.
		Directory directory = await getApplicationDocumentsDirectory();
		String path = directory.path + 'tracks.db';

		// Open/create the database at a given path
		var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
		return notesDatabase;
	}

	void _createDb(Database db, int newVersion) async {

		await db.execute('CREATE TABLE $trackTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colDate TEXT, '
				'$colRoute TEXT)');
	}


	// Fetch Operation: Get all note objects from database
	Future<List<Map<String, dynamic>>> getRouteMapList() async {
		Database db = await this.database;

		var result = await db.rawQuery('SELECT * FROM $trackTable order by $colDate DESC');
		//var result = await db.query(noteTable, orderBy: '$colPriority ASC');
		return result;
	}

	Future<List<Track>> getRoutesByDate(String date) async {
		Database db = await this.database;

		var result = await db.rawQuery('SELECT * FROM $trackTable WHERE $colDate ="$date"');
		debugPrint("date " + date + " result " +result.length.toString());
		List<Track> routeList = List<Track>();
		// For loop to create a 'Note List' from a 'Map List'
		for (int i = 0; i < result.length; i++) {
			routeList.add(Track.fromMapObject(result[i]));
		}

		return routeList;
	}

	// Insert Operation: Insert a Track object to database
	Future<int> insertTrack(Track track) async {
		Database db = await this.database;
		var result = await db.insert(trackTable, track.toMap());
		return result;
	}

	Future<int> deleteTrack(int id) async {
		Database db = await this.database;
		var result = await db.rawDelete('DELETE FROM $trackTable WHERE $colId = $id');
		return result;
	}


	// Get number of Note objects in database
	Future<int> getCount() async {
		Database db = await this.database;
		List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT ( DISTINCT $colDate ) FROM $trackTable');
		int result = Sqflite.firstIntValue(x);
		return result;
	}

	Future<List<Map<String, dynamic>>> getDates() async {
		Database db = await this.database;
		List<Map<String, dynamic>> result = await db.rawQuery('SELECT  DISTINCT $colDate  FROM $trackTable');
		debugPrint(result[0]['date']);
		return result;
	}

	Future<List<Map<String, dynamic>>> fuckme() async {
		Database db = await this.database;
		List<Map<String, dynamic>> result = await db.rawQuery('SELECT  * FROM $trackTable');
		debugPrint(result[0]['id'].toString() + ", " + result[0]['date']  + ", " + result[0]['route']);
		return result;
	}

}







