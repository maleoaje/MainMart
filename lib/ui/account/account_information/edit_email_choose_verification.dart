/*
This is edit email choose verification page
 */

import 'package:flutter/material.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/ui/account/account_information/edit_email_verification.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';

class EditEmailChooseVerificationPage extends StatefulWidget {
  final String email;

  const EditEmailChooseVerificationPage({Key key, this.email = ''}) : super(key: key);

  @override
  _EditEmailChooseVerificationPageState createState() => _EditEmailChooseVerificationPageState();
}

class _EditEmailChooseVerificationPageState extends State<EditEmailChooseVerificationPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          padding: EdgeInsets.fromLTRB(30, 120, 30, 30),
          children: <Widget>[
            Center(
                child: Text(
                  AppLocalizations.of(context).translate('choose_verification_method'),
                  style: GlobalStyle.chooseVerificationTitle,
                )
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Text(
                AppLocalizations.of(context).translate('choose_verification_method_message'),
                style: GlobalStyle.chooseVerificationMessage,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditEmailVerificationPage(email: widget.email)));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 1,
                color: Colors.white,
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  width: MediaQuery.of(context).size.width - 60,
                  child: Row(
                    children: [
                      Icon(Icons.email, color: PRIMARY_COLOR, size: 50),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context).translate('email_to'), style: GlobalStyle.methodTitle),
                            SizedBox(
                              height: 3,
                            ),
                            Text(widget.email, style: GlobalStyle.methodMessage)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GlobalStyle.iconBack,
                    Text(
                      ' '+AppLocalizations.of(context).translate('back'),
                      style: GlobalStyle.back,
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
