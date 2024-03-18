// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:realm/realm.dart';

part 'user.g.dart';

@RealmModel()
@MapTo("Users")
class _User {
  @PrimaryKey()
  @MapTo("_id")
  late ObjectId id;
  late String email;
}
