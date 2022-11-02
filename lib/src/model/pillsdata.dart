// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PillsItem {
  String item_seq;
  String item_name;
  String entp_name;
  String etc_otc_code;
  String material_name;
  String storage_method;
  String valid_term;
  String caution;
  String effect;

  PillsItem({
    required this.item_seq,
    required this.item_name,
    required this.entp_name,
    required this.etc_otc_code,
    required this.material_name,
    required this.storage_method,
    required this.valid_term,
    required this.caution,
    required this.effect,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'item_seq': item_seq,
      'item_name': item_name,
      'entp_name': entp_name,
      'etc_otc_code': etc_otc_code,
      'material_name': material_name,
      'storage_method': storage_method,
      'valid_term': valid_term,
      'caution': caution,
      'effect': effect,
    };
  }

  factory PillsItem.fromMap(Map<String, dynamic> map) {
    return PillsItem(
      item_seq: map['item_seq'] as String,
      item_name: map['item_name'] as String,
      entp_name: map['entp_name'] as String,
      etc_otc_code: map['etc_otc_code'] as String,
      material_name: map['material_name'] as String,
      storage_method: map['storage_method'] as String,
      valid_term: map['valid_term'] as String,
      caution: map['caution'] as String,
      effect: map['effect'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PillsItem.fromJson(String source) =>
      PillsItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PillsItem(item_seq: $item_seq, item_name: $item_name, entp_name: $entp_name, etc_otc_code: $etc_otc_code, material_name: $material_name, storage_method: $storage_method, valid_term: $valid_term, caution: $caution, effect: $effect)';
  }
}
