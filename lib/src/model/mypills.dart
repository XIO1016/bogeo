// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ffi';

class MyPillsItem {
  String item_seq;
  String item_name;
  String eatingTime;
  bool iseat;
  int eatingNum;
  int eatingTime2;
  int eatingTime3;

  MyPillsItem({
    required this.item_seq,
    required this.item_name,
    required this.eatingTime,
    required this.eatingTime2,
    required this.eatingTime3,
    required this.iseat,
    required this.eatingNum,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'item_seq': item_seq,
      'item_name': item_name,
      'eatingTime': eatingTime,
      'eatingTime2': eatingTime2, //아침저녁점심
      'eatingTime3': eatingTime3,
      'eatingNum': eatingNum,
      'iseat': iseat,
    };
  }

  factory MyPillsItem.fromMap(Map<String, dynamic> map) {
    return MyPillsItem(
      item_seq: map['item_seq'] as String,
      item_name: map['item_name'] as String,
      eatingTime: map['eatingTime'] as String,
      eatingNum: map['eatingNum'] as int,
      eatingTime2: map['eatingTime2'] as int,
      eatingTime3: map['eatingTime3'] as int,
      iseat: map['iseat'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyPillsItem.fromJson(String source) =>
      MyPillsItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MyPillsItem(item_seq: $item_seq, item_name: $item_name, eatingTime: $eatingTime,eatingTime2: $eatingTime2,eatingTime3: $eatingTime3, eatingNum:$eatingNum,iseat:$iseat';
  }
}
