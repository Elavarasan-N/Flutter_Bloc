import 'package:employee_crud/appColor.dart';
import 'package:employee_crud/schemas/employee.dart';
import 'package:employee_crud/service/employee_service.dart';
import 'package:employee_crud/service/user_service.dart';
import 'package:employee_crud/splash_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

List<String> gender = ['Select Gender','Male', 'Female', 'Others'];

class WelcomeScreen extends StatefulWidget {
  final EmployeeService employeeService;
  final UserService userService;
  final User user;

  const WelcomeScreen({
    Key? key, required this.user, required this.employeeService, required this.userService
  }): super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _formKey = GlobalKey<FormState>();
  late RealmResults<Employee> allEmployees;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String selectedGender = gender.first;
  String initialValue = 'Select DOB';
  late String dob;
  DateTime birthDate = DateTime.now();
  bool isDateSelected = false;
  List<Employee> employees = [];

  @override
  void initState() {
    super.initState();
    allEmployees = widget.employeeService.getEmployees();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employees'),
        actions: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context, 
                    builder: (context) {
                      return addEmployee(context);
                    }
                    );
                }, 
                child: const Text(
                  'Add Employee'
                ),
                ),
              IconButton(
                onPressed: () async {
                  try {
                    final navigator = Navigator.of(context);
                    await widget.userService.logoutUser();
                    navigator.pushReplacement(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return SplashScreen(
                          userService: widget.userService,
                          );
                      })
                    );
                  } on RealmException catch (e) {
                    if (kDebugMode) {
                      print('Error during logout ${e.message}');
                    }
                  }
                }, 
                icon: const Icon(
                  Icons.logout,
                  size: 30,
                )),
            ],
          )
        ],
      ),
      body: 
      Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Row(
              children: [
                Expanded(child: Text('Name',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                Expanded(child: Text('DOB',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                Expanded(child: Text('Gender',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                Expanded(child: Text('Phone',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                Expanded(child: Text('Email',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                Expanded(child: Text('Date',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                Expanded(child: Text('Action',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
              ],
            ),
            StreamBuilder(
              stream: allEmployees.changes,
              builder: (BuildContext context,
              AsyncSnapshot<RealmResultsChanges<Employee>> snapshot) {
                if(snapshot.hasData) {
                  employees = snapshot.data!.results.toList();
                } 
                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) { 
                    return employeeItemBuilder(employees[index], index);
                  }, 
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                        height: 0, thickness: 1, color: Colors.grey.shade400);
                  }, 
                  itemCount: employees.length);
              }
            )
          ],
        ),
      )
    );
  }

  Widget employeeItemBuilder(Employee employee,int index) {
  return InkWell(
    child: Column(
      children: [
        Row(
          children: [
            Expanded(child: Text(employee.name)),
            Expanded(child: Text(employee.dob)),
            Expanded(child: Text(employee.gender)),
            Expanded(child: Text(employee.phone)),
            Expanded(child: Text(employee.email)),
            Expanded(child: Text(employee.date)),
            Expanded(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context, 
                        builder: (context) {
                          return updateEmployee(context, employee);
                        }
                        );
                    }, 
                    icon: const Icon(
                      Icons.edit_outlined
                    ),
                    ),
                    IconButton(
                    onPressed: () {
                      widget.employeeService.deleteEmployee(employees[index]);
                    }, 
                    icon: const Icon(
                      Icons.delete_outline
                    ),
                    ),
                ],
              ),
                
            ),
          ],
        ),
      ],
    ),
  );
}

  Widget addEmployee(BuildContext context) {
    String today = DateTime.now().toString();
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 400,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(10),
        child: Wrap(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: textColor),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: 
                        BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          color: textColor,
                        )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: appColor),
                      )
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: 80,
                          height: 50,
                          padding: const EdgeInsets.only(left: 10, right: 5),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            border: Border.all(
                              color: textColor,
                              width: 1.0,
                            )
                          ),
                          child: StatefulBuilder(
                            builder: (BuildContext context, StateSetter setState) {
                              return DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: selectedGender,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  isExpanded: true,
                                  iconSize: 24,
                                  elevation: 16,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedGender = newValue!;
                                    });
                                  },
                                  items: gender.map((option) {
                                    return DropdownMenuItem<String>(
                                      value: option,
                                      child: Text(
                                        option,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          fontStyle: FontStyle.normal,
                                          color: textColor,
                                        ),
                                        ),
                                      );
                                  }).toList(),
                                  ),
                                );
                            }
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            border: Border.all(
                              color: textColor,
                              width: 1.0,
                              ),
                          ),
                          child: StatefulBuilder(
                            builder: (BuildContext context, StateSetter setState) {
                              return Row(
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      final datePick = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(), 
                                        firstDate: DateTime(1900), 
                                        lastDate: DateTime(2100),
                                        );
                                        if (datePick!=null && datePick!=birthDate){
                                          setState(() {
                                            birthDate = datePick;
                                            isDateSelected = true;
                                            dob = "${birthDate.month}/${birthDate.day}/${birthDate.year}";
                                          });
                                        }
                                    }, 
                                    icon: const Icon(Icons.calendar_today,color: textColor,)
                                    ),
                                    Text(isDateSelected? dob: 'Select DOB',
                                    style: const TextStyle(
                                      color: textColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    ),
                                ],
                              );
                            }
                          ),
                        ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 15,),
                  TextField(
                    controller: phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(color: textColor),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: 
                        BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          color: textColor,
                        )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: appColor),
                      )
                    ),
                  ),
                  const SizedBox(height: 15,),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: textColor),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: 
                        BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          color: textColor,
                        )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: appColor),
                      )
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(10),
                        backgroundColor: Colors.green
                      ),
                      onPressed: () {
                        if(_formKey.currentState!.validate()) {
                          final employee = Employee(
                            Uuid.v4(),
                            nameController.text, 
                            emailController.text, 
                            phoneNumberController.text, 
                            selectedGender, 
                            dob,
                            today,
                            widget.user.id,
                            );
                            _formKey.currentState!.save();
                            widget.employeeService.addEmployees(employee);
                            clearEmployee();
                            Navigator.pop(context);
                        }
                      }, 
                      child: const Text('Save',
                        style: TextStyle(fontSize: 20,color: Colors.white),)
                      ),
                  ),
                ],
              ),
              ),
          ],
        ),
      ),
    );
}

 Widget updateEmployee(BuildContext context, Employee? employee) {
  nameController.text = employee?.name ?? '';
  selectedGender = employee?.gender ?? '';
  phoneNumberController.text = employee?.phone ?? '';
  emailController.text = employee?.email ?? '';
  dob = employee?.dob ?? '';
  isDateSelected = true;
  var id = employee!.id;

  String today = DateTime.now().toString();

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 400,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(10),
        child: Wrap(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: textColor),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: 
                        BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          color: textColor,
                        )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: appColor),
                      )
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: 80,
                          height: 50,
                          padding: const EdgeInsets.only(left: 10, right: 5),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            border: Border.all(
                              color: textColor,
                              width: 1.0,
                            )
                          ),
                          child: StatefulBuilder(
                            builder: (BuildContext context, StateSetter setState) {
                              return DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: selectedGender,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  isExpanded: true,
                                  iconSize: 24,
                                  elevation: 16,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedGender = newValue!;
                                    });
                                  },
                                  items: gender.map((option) {
                                    return DropdownMenuItem<String>(
                                      value: option,
                                      child: Text(
                                        option,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          fontStyle: FontStyle.normal,
                                          color: textColor,
                                        ),
                                        ),
                                      );
                                  }).toList(),
                                  ),
                                );
                            }
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            border: Border.all(
                              color: textColor,
                              width: 1.0,
                              ),
                          ),
                          child: StatefulBuilder(
                            builder: (BuildContext context, StateSetter setState) {
                              return Row(
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      final datePick = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(), 
                                        firstDate: DateTime(1900), 
                                        lastDate: DateTime(2100),
                                        );
                                        if (datePick!=null && datePick!=birthDate){
                                          setState(() {
                                            birthDate = datePick;
                                            isDateSelected = true;
                                            dob = "${birthDate.month}/${birthDate.day}/${birthDate.year}";
                                          });
                                        }
                                    }, 
                                    icon: const Icon(Icons.calendar_today,color: textColor,)
                                    ),
                                    Text(isDateSelected? dob: 'Select DOB',
                                    style: const TextStyle(
                                      color: textColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    ),
                                ],
                              );
                            }
                          ),
                        ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 15,),
                  TextField(
                    controller: phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(color: textColor),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: 
                        BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          color: textColor,
                        )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: appColor),
                      )
                    ),
                  ),
                  const SizedBox(height: 15,),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: textColor),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: 
                        BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          color: textColor,
                        )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: appColor),
                      )
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(10),
                        backgroundColor: Colors.green
                      ),
                      onPressed: () {
                        if(_formKey.currentState!.validate()) {
                          final employee = Employee(
                            id, 
                            nameController.text, 
                            emailController.text, 
                            phoneNumberController.text, 
                            selectedGender, 
                            dob,
                            today,
                            widget.user.id,
                            );
                          widget.employeeService.updateEmployee(employee);
                          clearEmployee();
                          Navigator.pop(context);
                        }
                      }, 
                      child: const Text('Update',
                        style: TextStyle(fontSize: 20,color: Colors.white),)
                      ),
                  ),
                ],
              ),
              ),
          ],
        ),
      ),
    );
}

void clearEmployee() {
  nameController.clear();
  emailController.clear();
  phoneNumberController.clear();
  selectedGender = gender.first;
  isDateSelected = false;
}
}






