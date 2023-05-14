import 'package:firebase_database/firebase_database.dart';
import 'package:sqflite/sqflite.dart'; // sqflite for database
import 'package:path/path.dart'; // the path package
import './todo_model.dart'; // the todo model we created before

class DatabaseConnect {
  Database? _database;

  // create a getter and open a connection to database
  Future<Database> get database async {
    // this is the location of our database in device. ex - data/data/....
    final dbpath = await getDatabasesPath();
    // this is the name of our database.
    const dbname = 'todo.db';
    // this joins the dbpath and dbname and creates a full path for database.
    // ex - data/data/todo.db
    final path = join(dbpath, dbname);

    // open the connection
    _database = await openDatabase(path, version: 1, onCreate: _createDB);
    // we will create the _createDB function separately

    return _database!;
  }

  // the _create db function
  // this creates Tables in our database
  Future<void> _createDB(Database db, int version) async {
    // make sure the columns we create in our table match the todo_model field.
    await db.execute('''
      CREATE TABLE todo(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        creationDate TEXT,
        isChecked INTEGER
      )
    ''');
  }

  // function to add data into our database


  // function to delete a  todo from our database
  /*Future<void> deleteTodo(Todo todo) async {
    final db = await database;
    // delete the todo from database based on its id.
    await db.delete(
      'todo',
      where: 'id == ?', // this condition will check for id in todo list
      whereArgs: [todo.id],
    );
  }*/

  // function to fetch all the todo data from our database
  /*Future<List<Todo>> getTodo() async {
    final databaseReference = FirebaseDatabase.instance.reference();
    final items = <Map<String, dynamic>>[];
    databaseReference.child('todo').onValue.listen((event) {
      final data = event.snapshot.value as Map<String, dynamic>?;
      if (data != null) {

        data.forEach((key, value) {
          final todoItem = {
            'id': key.toString(),
            'title': value['title'] ?? '',
            'creationDate': value['creationDate'] ?? '',
            'isChecked': value['isChecked'] ?? false,
          };
          print(value+"\n");
          items.add(todoItem);
        });

        // Do something with the todoList
      }
    });

    return List.generate(
      items.length,
          (i) => Todo(
          id: items[i]['id'],
          title: items[i]['title'],
          creationDate: DateTime.parse(items[i][
          'date']), // this is in Text format right now. let's convert it to dateTime format
          isChecked: true/*items[i]['isChecked'] ==
            ? true
            : false, // this will convert the Integer to boolean. 1 = true, 0 = false.
            */
      ),
    );
  }
*/
  // ------- not included in video--------

  // function for updating a todo in todoList
  Future<void> updateTodo(int id, String title) async {
    final db = await database;

    await db.update(
      'todo', // table name
      {
        //
        'title': title, // data we have to update
      }, //
      where: 'id == ?', // which Row we have to update
      whereArgs: [id],
    );
  }
}
