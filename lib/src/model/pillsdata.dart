// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PillsItem {
  String item_seq;
  String item_name;
  String medicineCode;
  String image;
  String class_name;

  PillsItem({
    required this.item_seq,
    required this.item_name,
    required this.medicineCode,
    required this.image,
    required this.class_name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'itemSeq': item_seq,
      'itemName': item_name,
      'medicineCode': medicineCode,
      'image': image,
      'className': class_name
    };
  }

  factory PillsItem.fromMap(Map<String, dynamic> map) {
    return PillsItem(
      item_seq: map['itemSeq'] as String,
      item_name: map['itemName'] as String,
      medicineCode: map['medicineCode'] as String,
      image: map['image'] as String,
      class_name: map['className'] as String,
    );
  }

  // String toJson() => json.encode(toMap());

  factory PillsItem.fromJson(String source) =>
      PillsItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PillsItem(item_seq: $item_seq, item_name: $item_name,medicineCode:$medicineCode,image:$image,class_name:$class_name)';
  }
}
