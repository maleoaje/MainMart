/*
This is account information page

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/cache_image_network.dart to use cache image network
 */

import 'package:flutter/material.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/ui/account/account_information/edit_email.dart';
import 'package:ijshopflutter/ui/account/account_information/edit_name.dart';
import 'package:ijshopflutter/ui/account/account_information/edit_phone_number.dart';
import 'package:ijshopflutter/ui/account/account_information/edit_profile_picture.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/cache_image_network.dart';

class AccountInformationPage extends StatefulWidget {
  @override
  _AccountInformationPageState createState() => _AccountInformationPageState();
}

class _AccountInformationPageState extends State<AccountInformationPage> {
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
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0,
          title: Text(
            AppLocalizations.of(context).translate('account_information'),
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
        body: Container(
          margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _createProfilePicture(),
              SizedBox(height: 40),
              Text(
                AppLocalizations.of(context).translate('name'),
                style: GlobalStyle.accountInformationLabel,
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Omale',
                      style: GlobalStyle.accountInformationValue,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditNamePage()));
                    },
                    child: Text(AppLocalizations.of(context).translate('edit'),
                        style: GlobalStyle.accountInformationEdit),
                  )
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context).translate('email'),
                    style: GlobalStyle.accountInformationLabel,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  _verifiedLabel()
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'omale@test.com',
                      style: GlobalStyle.accountInformationValue,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditEmailPage()));
                    },
                    child: Text(AppLocalizations.of(context).translate('edit'),
                        style: GlobalStyle.accountInformationEdit),
                  )
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context).translate('phone_number'),
                    style: GlobalStyle.accountInformationLabel,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  _verifiedLabel()
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '08118889991',
                      style: GlobalStyle.accountInformationValue,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditPhoneNumberPage()));
                    },
                    child: Text(AppLocalizations.of(context).translate('edit'),
                        style: GlobalStyle.accountInformationEdit),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  Widget _createProfilePicture() {
    final double profilePictureSize = MediaQuery.of(context).size.width / 3;
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.only(top: 40),
        width: profilePictureSize,
        height: profilePictureSize,
        child: GestureDetector(
          onTap: () {
            _showPopupUpdatePicture();
          },
          child: Stack(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: (profilePictureSize),
                child: Hero(
                  tag: 'profilePicture',
                  child: ClipOval(
                      child: buildCacheNetworkImage(
                          width: profilePictureSize,
                          height: profilePictureSize,
                          url: GLOBAL_URL + '/assets/images/user/avatar.png')),
                ),
              ),
              // create edit icon in the picture
              Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.only(
                    top: 0, left: MediaQuery.of(context).size.width / 4),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 1,
                  child: Icon(Icons.edit, size: 12, color: CHARCOAL),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _verifiedLabel() {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
      decoration: BoxDecoration(
          color: SOFT_BLUE, borderRadius: BorderRadius.circular(2)),
      child: Row(
        children: [
          Text(AppLocalizations.of(context).translate('verified'),
              style: TextStyle(color: Colors.white, fontSize: 11)),
          SizedBox(
            width: 4,
          ),
          Icon(Icons.done, color: Colors.white, size: 11)
        ],
      ),
    );
  }

  void _showPopupUpdatePicture() {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(AppLocalizations.of(context).translate('no'),
          style: TextStyle(color: SOFT_BLUE)),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text(AppLocalizations.of(context).translate('yes'),
          style: TextStyle(color: SOFT_BLUE)),
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EditProfilePicturePage()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        AppLocalizations.of(context).translate('edit_profile_picture'),
        style: TextStyle(fontSize: 18),
      ),
      content: Text(
          AppLocalizations.of(context)
              .translate('edit_profile_picture_message'),
          style: TextStyle(fontSize: 13, color: BLACK_GREY)),
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
}
