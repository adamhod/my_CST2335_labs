import 'package:floor/floor.dart';
import 'SLE.dart';

@dao
abstract class Shopping_listDAO {
  @Query('SELECT * FROM SLE')
  Future<List<SLE>> findAllItems();

  @Query('SELECT * FROM SLE WHERE id = :id')
  Stream<SLE?> findItemById(int id);

  @insert
  Future<void> insertPerson(SLE sle);
}