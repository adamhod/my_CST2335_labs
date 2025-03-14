import 'package:floor/floor.dart';
import 'SLE.dart';

@dao
abstract class Shopping_listDAO {
  @Query('SELECT * FROM SLE')
  Future<List<SLE>> getAllItems();

  @insert
  Future<void> insertItem(SLE item);

  @delete
  Future<void> removeItem(SLE item);
}