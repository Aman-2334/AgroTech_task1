import 'dart:convert';
import 'package:cultino/provider/dataProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Screen2 extends StatefulWidget {
  static const routeName = '/Screen2';
  const Screen2({Key? key}) : super(key: key);

  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  var data;
  var _mandiData;
  bool progress = false;

  Future<void> addData() async {
    print('addData called');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('data', json.encode(_mandiData));
  }

  void getMandiData() async {
    setState(() {
      progress = true;
    });
    final response = await http.get(Uri.parse(
        "https://thekrishi.com/test/mandi?lat=28.44108136&lon=77.0526054&ver=89&lang=hi&crop_id=10"));
    _mandiData =
        json.decode(utf8.decode(response.bodyBytes))['data']['other_mandi'];
    if (_mandiData != null) await addData();
    setState(() {
      progress = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataProvider>(context).mandiData;
    if(data['mandiData'] != null)_mandiData = data['mandiData'];
    print('_mandiData $_mandiData');
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 2'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: progress
                        ? Container(
                          width: double.infinity,
                          child: Center(
                            child: CircularProgressIndicator(
                                color: Colors.amber,
                              ),
                          ),
                        )
                        : Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: Colors.amber),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                            child: Text(
                              "Fetch",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            ),
                            onPressed: () {
                              getMandiData();
                            },
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              if (_mandiData != null)
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      for (var element in _mandiData)
                        Text(
                          '${element.toString()} \n',
                          style: TextStyle(color: Colors.amber),
                        )
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
