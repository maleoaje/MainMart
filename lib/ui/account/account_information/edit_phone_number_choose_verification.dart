/*
This is edit phone number choose verification page

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'package:flutter/material.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/ui/account/account_information/edit_phone_number_verification.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';

class EditPhoneNumberChooseVerificationPage extends StatefulWidget {
  final String phoneNumber;

  const EditPhoneNumberChooseVerificationPage({Key key, this.phoneNumber = ''}) : super(key: key);

  @override
  _EditPhoneNumberChooseVerificationPageState createState() => _EditPhoneNumberChooseVerificationPageState();
}

class _EditPhoneNumberChooseVerificationPageState extends State<EditPhoneNumberChooseVerificationPage> {
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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditPhoneNumberVerificationPage(verificationType: 'sms', phoneNumber: widget.phoneNumber)));
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
                      Icon(Icons.phone_android, color: PRIMARY_COLOR, size: 50),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context).translate('sms_to'), style: GlobalStyle.methodTitle),
                            SizedBox(
                              height: 3,
                            ),
                            Text(widget.phoneNumber, style: GlobalStyle.methodMessage)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditPhoneNumberVerificationPage(verificationType: 'wa', phoneNumber: widget.phoneNumber)));
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
                      Image(image: AssetImage("assets/images/whatsapp.png"), width: 50, height: 50),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context).translate('whatsapp_to'), style: GlobalStyle.methodTitle),
                            SizedBox(
                              height: 3,
                            ),
                            Text(widget.phoneNumber, style: GlobalStyle.methodMessage)
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
