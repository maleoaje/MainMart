import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ijshopflutter/cubit/language/language_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialWrapper extends StatefulWidget {
  final Widget child;

  const InitialWrapper({@required this.child});

  @override
  _InitialWrapperState createState() => _InitialWrapperState();
}

class _InitialWrapperState extends State<InitialWrapper> {
  LanguageCubit _languageCubit;

  @override
  void initState() {
    _languageCubit = BlocProvider.of<LanguageCubit>(context);
    _getLocale().then((val) {
      _languageCubit.changeLanguage(val);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  Future<Locale> _getLocale() async{
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    String lCode = _pref.getString('lCode');
    String cCode = _pref.getString('cCode');
    if (lCode == null || cCode == null) {
      await _pref.setString('lCode', 'en');
      await _pref.setString('cCode', 'US');
      return Locale('en', 'US');
    } else {
      return Locale(lCode, cCode);
    }
  }
}
