/*
This is change language
this apps is used to change a whole application language
we used cubit state management to change the language because it is a very simple and lightweight
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/cubit/language/language_cubit.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/global_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeLanguagePage extends StatefulWidget {
  @override
  _ChangeLanguagePageState createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  // initialize global widget
  final _globalWidget = GlobalWidget();
  String defaultLang = 'en';

  List<String> _localeList = ['en', 'id', 'ar', 'zh', 'hi', 'th'];
  List<String> _countryList = ['US', 'ID', 'DZ', 'HK', 'IN', 'TH'];
  List<String> _languageList = [
    'English',
    'Indonesia',
    'Arabic',
    'Chinese',
    'Hindi',
    'Thai'
  ];

  LanguageCubit _languageCubit;

  @override
  void initState() {
    _languageCubit = BlocProvider.of<LanguageCubit>(context);

    _getLocale().then((val) {
      setState(() {
        defaultLang = val;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<String> _getLocale() async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    String lCode = _pref.getString('lCode');
    return lCode;
  }

  void changeLocale(Locale locale) async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.setString('lCode', locale.languageCode);
    await _pref.setString('cCode', locale.countryCode);
    _languageCubit.changeLanguage(locale);
    defaultLang = locale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0,
          title: Text(
            AppLocalizations.of(context).translate('change_language'),
            style: GlobalStyle.appBarTitle,
          ),
          backgroundColor: Colors.white,
          bottom: PreferredSize(
              child: Container(
                color: Colors.grey[100],
                height: 1.0,
              ),
              preferredSize: Size.fromHeight(1.0)),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: List.generate(_localeList.length, (index) {
            return Card(
              margin: EdgeInsets.only(top: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              elevation: 2,
              color: Colors.white,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  _showPopupChangeLanguage(index);
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 6,
                          child: Image.asset('assets/images/lang/' + _localeList[index] + '.png')),
                      Expanded(
                        child: Container(
                            padding: EdgeInsets.all(16),
                            child: Text(_languageList[index], style: TextStyle(fontSize: 14))),
                      ),
                      (defaultLang == _localeList[index])
                          ? Container(child: _globalWidget.createDefaultLabel(context))
                          : Wrap(),
                    ],
                  ),
                ),
              ),
            );
          }),
        ));
  }

  void _showPopupChangeLanguage(index) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(AppLocalizations.of(context).translate('no'), style: TextStyle(color: SOFT_BLUE)),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text(AppLocalizations.of(context).translate('yes'), style: TextStyle(color: SOFT_BLUE)),
      onPressed: () {
        Navigator.pop(context);
        changeLocale(Locale(_localeList[index], _countryList[index]));
        _showNotesDialog();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(AppLocalizations.of(context).translate('change_language'), style: TextStyle(fontSize: 18),),
      content: Text(AppLocalizations.of(context).translate('change_language_message'), style: TextStyle(fontSize: 13, color: BLACK_GREY)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future _showNotesDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {
              return null;
            },
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)), //this right here
              child: Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.fromLTRB(40, 20, 40, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).translate('change_language_notes'),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: BLACK_GREY),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(color: PRIMARY_COLOR)),
                        onPressed: () {
                          Navigator.pop(context);
                          FocusScope.of(context).unfocus(); // hide keyboard when press button
                        },
                        padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                        color: PRIMARY_COLOR,
                        textColor: Colors.white,
                        child: Text(
                          AppLocalizations.of(context).translate('ok').toUpperCase(),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
