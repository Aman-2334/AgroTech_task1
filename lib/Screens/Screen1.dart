import 'dart:io';
import 'package:cultino/provider/dataProvider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Screen1 extends StatefulWidget {
  Screen1({Key? key}) : super(key: key);

  final List gender = [
    'Male',
    'Female',
  ];

  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  var gender;
  var email;
  var name;
  var imagePicked;
  var _gender;
  var _imagePicked;
  bool progress = false;
  bool loading = false;
  String imageUrl =
      "https://www.pngall.com/wp-content/uploads/5/Profile-Male-PNG.png";
  final _key = new GlobalKey<FormState>();

  Future<void> pickProfileImage() async {
    try {
      final XFile? selectedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (selectedImage != null) {
        setState(() {
          imagePicked = selectedImage.path;
          _imagePicked = selectedImage.path;
        });
      }
    } catch (e) {
      return;
    }
  }

  Future<void> addData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
    prefs.setString('email', email);
    prefs.setString('gender', gender);
    prefs.setString('imagePicked', imagePicked);
  }

  Future<void> removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    setState(() {});
  }

  void saveForm() async {
    final form = _key.currentState;
    if (form != null && form.validate()) {
      form.save();
      Navigator.of(context).pushNamed('/Screen2');
      await addData();
    } else {
      setState(() {
        progress = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataProvider>(context).data;
    if (data['name'] != null) name = data['name'];
    if (data['email'] != null) email = data['email'];
    if (data['gender'] != null) _gender = data['gender'];
    if (data['imagePicked'] != null) _imagePicked = data['imagePicked'];

    print(
        'name: $name email: $email gender: $gender _imagePicked: $_imagePicked');
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 1'),
       
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        //color: Colors.yellow,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(color: Colors.red.shade300),
                          child: imagePicked != null
                              ? Image.file(
                                  File(imagePicked),
                                  fit: BoxFit.scaleDown,
                                  errorBuilder: (context, object, stackTrace) =>
                                      Image.network(imageUrl),
                                )
                              : Image.network(imageUrl),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => showModalBottomSheet(
                          backgroundColor: Colors.black26,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(20.0),
                                topRight: const Radius.circular(20.0)),
                            //side: BorderSide(color: Colors.amber, width: 2),
                          ),
                          context: context,
                          builder: (context) {
                            final Size size = MediaQuery.of(context).size;
                            return Container(
                              height: size.height * size.width * 0.0003,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: size.height * 0.006,
                                    width: size.width * 0.1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.amber,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                            pickProfileImage();
                                          },
                                          icon: Icon(
                                            Icons.add_a_photo_outlined,
                                            size: size.height *
                                                size.width *
                                                0.0001,
                                            color: Colors.blue,
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            );
                          }),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: Material(
                            color: Colors.black,
                            elevation: 0.0,
                            child: TextFormField(
                              validator: (e) {
                                if (e != null && e.isEmpty) {
                                  Text txt = Text("Please Enter Full Name",
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.ltr);
                                  var fullname = txt.data;
                                  return fullname;
                                }
                              },
                              onSaved: (e) => name = e,
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.amber),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.amber),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.amber),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  prefixIcon: Padding(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 15),
                                    child:
                                        Icon(Icons.person, color: Colors.amber),
                                  ),
                                  //contentPadding: EdgeInsets.all(15),
                                  labelText: "Fullname",
                                  labelStyle: TextStyle(color: Colors.amber)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: Material(
                            color: Colors.black,
                            elevation: 0.0,
                            child: TextFormField(
                              validator: (e) {
                                if (e != null && e.isEmpty) {
                                  return "Please Enter Email";
                                }
                              },
                              onSaved: (e) => email = e,
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.amber),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.amber),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.amber),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  prefixIcon: Padding(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 15),
                                    child:
                                        Icon(Icons.email, color: Colors.amber),
                                  ),
                                  // contentPadding: EdgeInsets.all(18),
                                  labelText: "Email",
                                  labelStyle: TextStyle(color: Colors.amber)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: Material(
                            color: Colors.black,
                            elevation: 0.0,
                            child: DropdownButtonFormField(
                              validator: (e) {
                                if (e == null) {
                                  Text txt = Text("Please Choose a gender",
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.ltr);
                                  var fullname = txt.data;
                                  return fullname;
                                }
                              },
                              icon: Icon(Icons.arrow_drop_down,
                                  color: Colors.amber),
                              dropdownColor: Colors.black,
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                              value: gender,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.amber),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.amber),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.amber),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  prefixIcon: Padding(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 15),
                                    child: Icon(
                                        gender == 'Male'
                                            ? Icons.male_outlined
                                            : gender == 'Female'
                                                ? Icons.female_outlined
                                                : Icons.face_outlined,
                                        color: Colors.amber),
                                  ),
                                  // contentPadding: EdgeInsets.all(18),
                                  labelText: "Gender",
                                  labelStyle: TextStyle(color: Colors.amber)),
                              items: widget.gender
                                  .map(
                                    (label) => DropdownMenuItem(
                                      child: Text(label),
                                      value: label,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                gender = value;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        progress
                            ? Center(
                                child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.amber),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(horizontal: 32),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100)),
                                      color: Colors.amber),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: TextButton(
                                      child: Text(
                                        "Submit",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          progress = true;
                                        });
                                        saveForm();

                                        setState(() {
                                          progress = false;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                if (name != null || email != null || _gender != null)
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/Screen2');
                    },
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(color: Colors.red.shade300),
                        child: _imagePicked != null
                            ? Image.file(
                                File(_imagePicked),
                                fit: BoxFit.scaleDown,
                                errorBuilder: (context, object, stackTrace) =>
                                    Image.network(imageUrl),
                              )
                            : Image.network(imageUrl),
                      ),
                    ),
                    title: Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.amber),
                    ),
                    subtitle: Text(
                      email,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.amber),
                    ),
                    trailing: Text(
                      _gender == null ? gender : _gender,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.amber),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
