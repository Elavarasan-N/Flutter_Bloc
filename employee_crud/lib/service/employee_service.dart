import 'package:employee_crud/schemas/employee.dart';
import 'package:realm/realm.dart';

class EmployeeService {
  final User user;
  late final Realm realm;
  
  EmployeeService(this.user) {
    realm = openRealm();
  }

  Realm openRealm() {
    var realmConfig = Configuration.flexibleSync(user, [Employee.schema]);
    var realm = Realm(realmConfig);
    realm.subscriptions.update((mutableSubscriptions) { 
      mutableSubscriptions.add(realm.all<Employee>());
    });
    return realm;
  }

  RealmResults<Employee> getEmployees() {
    return realm.query<Employee>(
      "userId == '${user.id}' || sharedWith contains '${user.id}'"
    );
  }

  addEmployees(Employee employee) {
    realm.write(() => {realm.add<Employee>(employee)});
  }

  deleteEmployee(Employee employee) {
    var id = employee.id;
    RealmResults<Employee> existingEmployee = realm.query<Employee>(r"_id >= $0", [id]);
    employee = existingEmployee.first;
    realm.write(() => {realm.delete(employee)});
  }

  updateEmployee(Employee employee) {
    var id = employee.id;
    RealmResults<Employee> existingEmployees = realm.query<Employee>(r"_id >= $0", [id]);
    if(existingEmployees.isNotEmpty) {
      realm.write(()  {
        Employee existingEmployee = existingEmployees.first;
        existingEmployee.name = employee.name;
        existingEmployee.email = employee.email;
        existingEmployee.gender = employee.gender;
        existingEmployee.phone = employee.phone;
        existingEmployee.dob = employee.dob;
      });
    }
  }

}