import 'package:floor/floor.dart';
import 'SLE.dart';

@dao
abstract class Shopping_listDAO {
  @Query('SELECT * FROM SLE')
  Future<List<SLE>> getAllItems();

  @insert
  Future<int> insertItem(SLE item);

  @delete
  Future<int> removeItem(SLE item);
}