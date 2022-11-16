// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MyPillsItem {
  String item_seq;
  String item_name;
  int eatingTime;
  bool iseat;
  int eatingNum;
  int eatingTime3;
  bool hasEndDay;
  String endDay;
  dynamic period;
  String image;
  int medicineID;
  MyPillsItem(
      {required this.item_seq,
      required this.item_name,
      required this.eatingTime,
      required this.eatingTime3,
      required this.iseat,
      required this.eatingNum,
      required this.endDay,
      required this.hasEndDay,
      required this.period,
      required this.image,
      required this.medicineID});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'item_seq': item_seq,
      'item_name': item_name,
      'eatingTime': eatingTime,
      'eatingTime3': eatingTime3,
      'eatingNum': eatingNum,
      'iseat': iseat,
    };
  }

  // factory MyPillsItem.fromMap(Map<String, dynamic> map) {
  //   return MyPillsItem(
  //     item_seq: map['item_seq'] as String,
  //     item_name: map['item_name'] as String,
  //     eatingTime: map['eatingTime'] as String,
  //     eatingNum: map['eatingNum'] as int,
  //     eatingTime2: map['eatingTime2'] as int,
  //     eatingTime3: map['eatingTime3'] as int,
  //     iseat: map['iseat'] as bool,
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory MyPillsItem.fromJson(String source) =>
  //     MyPillsItem.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() {
  //   return 'MyPillsItem(item_seq: $item_seq, item_name: $item_name, eatingTime: $eatingTime,eatingTime2: $eatingTime2,eatingTime3: $eatingTime3, eatingNum:$eatingNum,iseat:$iseat';
  // }
}
