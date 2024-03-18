// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Employee extends _Employee
    with RealmEntity, RealmObjectBase, RealmObject {
  Employee(
    Uuid id,
    String name,
    String email,
    String phone,
    String gender,
    String dob,
    String date,
    String userId, {
    Iterable<String> sharedWith = const [],
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'email', email);
    RealmObjectBase.set(this, 'phone', phone);
    RealmObjectBase.set(this, 'gender', gender);
    RealmObjectBase.set(this, 'dob', dob);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'user_id', userId);
    RealmObjectBase.set<RealmList<String>>(
        this, 'sharedWith', RealmList<String>(sharedWith));
  }

  Employee._();

  @override
  Uuid get id => RealmObjectBase.get<Uuid>(this, '_id') as Uuid;
  @override
  set id(Uuid value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get email => RealmObjectBase.get<String>(this, 'email') as String;
  @override
  set email(String value) => RealmObjectBase.set(this, 'email', value);

  @override
  String get phone => RealmObjectBase.get<String>(this, 'phone') as String;
  @override
  set phone(String value) => RealmObjectBase.set(this, 'phone', value);

  @override
  String get gender => RealmObjectBase.get<String>(this, 'gender') as String;
  @override
  set gender(String value) => RealmObjectBase.set(this, 'gender', value);

  @override
  String get dob => RealmObjectBase.get<String>(this, 'dob') as String;
  @override
  set dob(String value) => RealmObjectBase.set(this, 'dob', value);

  @override
  String get date => RealmObjectBase.get<String>(this, 'date') as String;
  @override
  set date(String value) => RealmObjectBase.set(this, 'date', value);

  @override
  String get userId => RealmObjectBase.get<String>(this, 'user_id') as String;
  @override
  set userId(String value) => RealmObjectBase.set(this, 'user_id', value);

  @override
  RealmList<String> get sharedWith =>
      RealmObjectBase.get<String>(this, 'sharedWith') as RealmList<String>;
  @override
  set sharedWith(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Employee>> get changes =>
      RealmObjectBase.getChanges<Employee>(this);

  @override
  Employee freeze() => RealmObjectBase.freezeObject<Employee>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Employee._);
    return const SchemaObject(ObjectType.realmObject, Employee, 'Employees', [
      SchemaProperty('id', RealmPropertyType.uuid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('email', RealmPropertyType.string),
      SchemaProperty('phone', RealmPropertyType.string),
      SchemaProperty('gender', RealmPropertyType.string),
      SchemaProperty('dob', RealmPropertyType.string),
      SchemaProperty('date', RealmPropertyType.string),
      SchemaProperty('userId', RealmPropertyType.string, mapTo: 'user_id'),
      SchemaProperty('sharedWith', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
    ]);
  }
}
