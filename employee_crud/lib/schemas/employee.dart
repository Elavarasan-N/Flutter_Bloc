import 'package:realm/realm.dart';

part 'employee.g.dart';

@RealmModel()
@MapTo('Employees')
class _Employee {
  @PrimaryKey()
  @MapTo('_id')
  late Uuid id;
  late String name;
  late String email;
  late String phone;
  late String gender;
  late String dob;
  late String date;
  @MapTo('user_id')
  late String userId;
  late List<String> sharedWith;
}