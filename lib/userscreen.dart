import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const inactivecolor = Color(0xFFFFFFFF);
const activecolor = Color(0xFF606BA1);

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final fieldText1 = TextEditingController();
  final fieldText2 = TextEditingController();
  final fieldText3 = TextEditingController();
  final fieldText4 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _userName = '';
  String _address = '';
  DateTime _selectedDate = DateTime.now();
  String _gender = '';
  late double _weight;
  late double _height;
  Color malebgcolor = inactivecolor;
  Color femalebgcolor = inactivecolor;
  int fcolor() {
    String com = _getWeightComment(0);
    if (com == 'UnderWeight') {
      return 0xFFD50000;
    } else if (com == 'Normal Weight') {
      return 0xFF64DD17;
    } else if (com == 'OverWeight') {
      return 0xFFFFEA00;
    } else if (com == 'Obese') {
      return 0xFFD50000;
    }
    return 0;
  }

  late String face = 'images/bmi.png';

  void updateBgcolor(int gen) {
    //male = 1 | female = 0
    if (gen == 1) {
      if (malebgcolor == inactivecolor) {
        malebgcolor = activecolor;
        femalebgcolor = inactivecolor;
      } else {
        malebgcolor = inactivecolor;
      }
    }
    if (gen == 0) {
      if (femalebgcolor == inactivecolor) {
        femalebgcolor = activecolor;
        malebgcolor = inactivecolor;
      } else {
        femalebgcolor = inactivecolor;
      }
    }
    if (gen == 2) {
      femalebgcolor = inactivecolor;
      malebgcolor = inactivecolor;
    }
  }

  double _calculateBMI() {
    double heightInMeters = _height / 100;
    return _weight / (heightInMeters * heightInMeters);
  }

  String _getWeightComment(int val) {
    double bmi = _calculateBMI();
    if (bmi < 18.5) {
      if (val == 1) {
        face = 'images/sad.png';
        return face;
      } else {
        return "UnderWeight";
      }
    }
    if (bmi >= 18.5 && bmi < 25) {
      if (val == 1) {
        face = 'images/smileyface.png';
        return face;
      } else {
        return "Normal Weight";
      }
    }
    if (bmi >= 25 && bmi < 30) {
      if (val == 1) {
        face = 'images/sad.png';
        return face;
      } else {
        return "OverWeight";
      }
    } else {
      if (val == 1) {
        face = 'images/sad.png';
        return face;
      } else {
        return "Obese";
      }
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),

              //title:  Text('Hi $_userName!',
              //style: const TextStyle(color: Color(0xFF606BA1), fontSize: 25, fontWeight: FontWeight.bold),),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Center(child: Image.asset(_getWeightComment(1), height: 96, width: 96,)),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Your Address: $_address',
                    style: const TextStyle(
                      color: Color(0xFF606BA1),
                    ),
                  ),
                  Text(
                    'Your Gender: $_gender',
                    style: const TextStyle(
                      color: Color(0xFF606BA1),
                    ),
                  ),
                  Text(
                    'Date of Birth: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}',
                    style: const TextStyle(
                      color: Color(0xFF606BA1),
                    ),
                  ),
                  Text(
                    'Weight: $_weight kg',
                    style: const TextStyle(
                      color: Color(0xFF606BA1),
                    ),
                  ),
                  Text(
                    'Height: $_height cm',
                    style: const TextStyle(
                      color: Color(0xFF606BA1),
                    ),
                  ),
                  Text(
                    'Age: ${DateTime.now().year - _selectedDate.year}',
                    style: const TextStyle(
                      color: Color(0xFF606BA1),
                    ),
                  ),
                  Text(
                    'BMI: ${_calculateBMI().toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Color(0xFF606BA1),
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    _getWeightComment(0),
                    style: TextStyle(
                      color: Color(fcolor()),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF606BA1),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    fieldText1.clear();
                    fieldText2.clear();
                    fieldText3.clear();
                    fieldText4.clear();
                    setState(() {
                      updateBgcolor(2);
                    });
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.dehaze_sharp)),
        title: const Text('BMI Calculator'),
        centerTitle: true,
        //backgroundColor: const Color(0xFF606BA1),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'User Name',
                      icon: const Icon(Icons.people_alt_sharp),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !(value.contains(RegExp(r'^[a-zA-Z]+$')))) {
                        return 'Please enter a valid user name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userName = value!;
                    },
                    controller: fieldText1,
                    //style: TextStyle(color: Colors.white),
                  ),
                ),

                //Address
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Address',
                      icon: const Icon(Icons.home_sharp),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !(value.contains(RegExp(r'^[a-zA-Z0-9/]+$')))) {
                        return 'Please enter a valid address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _address = value!;
                    },
                    controller: fieldText2,
                    //style: TextStyle(color: Colors.white),
                  ),
                ),

                //Gender
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(
                                    () {
                                      _gender = 'male';
                                      updateBgcolor(1);
                                    },
                                  );
                                },
                                child: Container(
                                  color: malebgcolor,
                                  child: const Column(
                                    children: [
                                      Card(
                                        child: Icon(
                                          Icons.male_rounded,
                                          size: 100,
                                          color: Color(0xFF606BA1),
                                        ),
                                      ),
                                      Text('Male'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(
                                    () {
                                      _gender = 'female';
                                      updateBgcolor(0);
                                    },
                                  );
                                },
                                child: Container(
                                  color: femalebgcolor,
                                  child: const Column(
                                    children: [
                                      Card(
                                        child: Icon(
                                          Icons.female_rounded,
                                          size: 100,
                                          color: Color(0xFF606BA1),
                                        ),
                                      ),
                                      Text(
                                        'Female',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                //DOB
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListTile(
                        title: const Text('Enter Your Date of Birth'),
                        // ignore: unnecessary_null_comparison
                        subtitle: Text(_selectedDate == null
                            ? 'Please select a date'
                            : DateFormat('yyyy-MM-dd').format(_selectedDate)),
                        leading: const Icon(Icons.calendar_today),
                        onTap: () async {
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (selectedDate != null) {
                            setState(() {
                              _selectedDate = selectedDate;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),

                //Weight
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Weight (in Kg)',
                      icon: const Icon(Icons.balance_sharp),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty || double.parse(value) <= 0) {
                        return 'Please enter a valid weight';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _weight = double.parse(value!);
                    },
                    controller: fieldText3,
                  ),
                ),
                //Height
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Height (in CM)',
                      icon: const Icon(Icons.analytics_sharp),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty || double.parse(value) <= 0) {
                        return 'Please enter a valid height';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _height = double.parse(value!);
                    },
                    controller: fieldText4,
                  ),
                ),

                const SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF606BA1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: _submitForm,
                  child: const Text(
                    'Calculate',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
