import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataProvider with ChangeNotifier {
  AccountPrefsState _currentPrefs = AccountPrefsState(
    gender: null,
    name: null,
    email: null,
    imagePicked: null,
  );

  MandiPrefsState _mandiCurrentPrefs = MandiPrefsState(mandiData: null);

  DataProvider() {
    _loadData();
    _loadMandiData();
  }

  Future<void> _loadData() async {
    await SharedPreferences.getInstance().then((prefs) {
      final _name = prefs.getString('name');
      final _email = prefs.getString('email');
      final _gender = prefs.getString('gender');
      final _imagePicked = prefs.getString('imagePicked');
      _currentPrefs = AccountPrefsState(
          gender: _gender,
          name: _name,
          email: _email,
          imagePicked: _imagePicked,
          );
    });

    notifyListeners();
  }

  Future<void> _loadMandiData() async {
    await SharedPreferences.getInstance().then((prefs) {
      var mandiData;
      final data = prefs.getString('data');
      if (data != null) mandiData = json.decode(data);
      _mandiCurrentPrefs = MandiPrefsState(
          mandiData: mandiData);
    });

    notifyListeners();
  }

  Map<String, dynamic> get data => {
        'name': _currentPrefs.name,
        'email': _currentPrefs.email,
        'gender': _currentPrefs.gender,
        'imagePicked': _currentPrefs.imagePicked,
        
      };

  Map<String, dynamic> get mandiData => {
        'mandiData': _mandiCurrentPrefs.mandiData,
      };
}

class AccountPrefsState {
  var gender;
  var email;
  var name;
  var imagePicked;
  AccountPrefsState({this.gender, this.email, this.name, this.imagePicked});
}

class MandiPrefsState {
  var mandiData;
  MandiPrefsState({this.mandiData});
}
