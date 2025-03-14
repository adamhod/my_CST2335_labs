import 'package:floor/floor.dart';

@entity
class SLE {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String item;
  final String quantity;

  SLE({this.id, required this.item, required this.quantity});
}