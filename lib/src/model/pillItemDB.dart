import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class pillItemDB {
  final int id;
  final int day;
  final String name;
  final int iseat;
  final int time1;
  final int time2;

  pillItemDB(
      {required this.id,
      required this.day,
      required this.name,
      required this.iseat,
      required this.time1,
      required this.time2});

  // dog를 Map으로 변환합니다. key는 데이터베이스 컬럼 명과 동일해야 합니다.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'day': day,
      'name': name,
      'iseat': iseat,
      'time1': time1,
      'time2': time2
    };
  }

  String toString() {
    return 'Pillsitem{id: $id, name: $name, day: $day,iseat:$iseat,time1:$time1,time2:$time2}';
  }
}

Future getPillsDatabase() async {
  final Future<Database> database = openDatabase(
    // 데이터베이스 경로를 지정합니다.
    join(await getDatabasesPath(), 'pills_db'),
    // 데이터베이스가 처음 생성될 때, dog를 저장하기 위한 테이블을 생성합니다.
    onCreate: (db, version) {
      // 데이터베이스에 CREATE TABLE 수행
      return db.execute(
        "CREATE TABLE pills(id INTEGER PRIMARY KEY, day INTEGER, name TEXT, iseat INTEGER, time1 INTEGER, time2 INTEGER)",
      );
    },
    // 버전을 설정하세요. onCreate 함수에서 수행되며 데이터베이스 업그레이드와 다운그레이드를
    // 수행하기 위한 경로를 제공합니다.
    version: 1,
  );
  return database;
}

// 데이터베이스에 dog를 추가하는 함수를 정의합니다.
Future<void> insertPillsDatabase(pillItemDB pillitem) async {
  // 데이터베이스 reference를 얻습니다.
  final Database db = await getPillsDatabase();

  // Dog를 올바른 테이블에 추가합니다. 동일한 dog가 두번 추가되는 경우를 처리하기 위해
  // `conflictAlgorithm`을 명시할 수 있습니다.
  //
  // 본 예제에서는, 이전 데이터를 갱신하도록 하겠습니다.
  await db.insert(
    'pills',
    pillitem.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<pillItemDB>> pillItemDBs() async {
  // 데이터베이스 reference를 얻습니다.
  final Database db = await getPillsDatabase();

  // 모든 Dog를 얻기 위해 테이블에 질의합니다.
  final List<Map<String, dynamic>> maps = await db.query('pills');

  // List<Map<String, dynamic>를 List<Dog>으로 변환합니다.
  return List.generate(maps.length, (i) {
    return pillItemDB(
      id: maps[i]['id'],
      name: maps[i]['name'],
      day: maps[i]['day'],
      iseat: maps[i]['iseat'],
      time1: maps[i]['time1'],
      time2: maps[i]['time2'],
    );
  });
}

Future<void> updatepills(pillItemDB pill) async {
  // 데이터베이스 reference를 얻습니다.
  final db = await getPillsDatabase();

  // 주어진 Dog를 수정합니다.
  await db.update(
    'pills',
    pill.toMap(),
    // Dog의 id가 일치하는 지 확인합니다.
    where: "id = ?",
    // Dog의 id를 whereArg로 넘겨 SQL injection을 방지합니다.
    whereArgs: [pill.id],
  );
}

Future<void> deletepills(int id) async {
  // 데이터베이스 reference를 얻습니다.
  final db = await getPillsDatabase();

  // 데이터베이스에서 Dog를 삭제합니다.
  await db.delete(
    'pills',
    // 특정 dog를 제거하기 위해 `where` 절을 사용하세요
    where: "id = ?",
    // Dog의 id를 where의 인자로 넘겨 SQL injection을 방지합니다.
    whereArgs: [id],
  );
}

Future<void> deletepills2(int day) async {
  // 데이터베이스 reference를 얻습니다.
  final db = await getPillsDatabase();

  // 데이터베이스에서 Dog를 삭제합니다.
  await db.delete(
    'pills',
    // 특정 dog를 제거하기 위해 `where` 절을 사용하세요
    where: "day = ?",
    // Dog의 id를 where의 인자로 넘겨 SQL injection을 방지합니다.
    whereArgs: [day - 1],
  );
}
