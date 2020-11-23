/*
This is account page

we used AutomaticKeepAliveClientMixin to keep the state when moving from 1 navbar to another navbar, so the page is not refresh overtime

include file in reuseable/global_widget.dart to call function from GlobalWidget
 */

import 'package:flutter/material.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/ui/account/about.dart';
import 'package:ijshopflutter/ui/account/account_information/account_information.dart';
import 'package:ijshopflutter/ui/account/change_language.dart';
import 'package:ijshopflutter/ui/account/change_password.dart';
import 'package:ijshopflutter/ui/account/last_seen_product.dart';
import 'package:ijshopflutter/ui/account/notification_setting.dart';
import 'package:ijshopflutter/ui/account/payment_method/payment_method.dart';
import 'package:ijshopflutter/ui/account/privacy_policy.dart';
import 'package:ijshopflutter/ui/account/set_address/set_address.dart';
import 'package:ijshopflutter/ui/account/order/order_list.dart';
import 'package:ijshopflutter/ui/authentication/signin/signin.dart';
import 'package:ijshopflutter/ui/general/chat_us.dart';
import 'package:ijshopflutter/ui/general/notification.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/cache_image_network.dart';
import 'package:ijshopflutter/ui/account/review_product/list_invoices.dart';
import 'package:ijshopflutter/ui/account/terms_conditions.dart';
import 'package:ijshopflutter/ui/reuseable/global_widget.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with AutomaticKeepAliveClientMixin {
  // initialize global widget
  final _globalWidget = GlobalWidget();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if we used AutomaticKeepAliveClientMixin, we must call super.build(context);
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            AppLocalizations.of(context).translate('account'),
            style: GlobalStyle.appBarTitle,
          ),
          backgroundColor: Colors.white,
          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatUsPage()));
                },
                child: Icon(Icons.email, color: BLACK_GREY)),
            IconButton(
                icon: _globalWidget.customNotifIcon(8, BLACK_GREY),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationPage()));
                }),
          ],
          bottom: PreferredSize(
              child: Container(
                color: Colors.grey[100],
                height: 1.0,
              ),
              preferredSize: Size.fromHeight(1.0)),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            _createAccountInformation(),
            _createListMenu(
                AppLocalizations.of(context).translate('change_password'),
                ChangePasswordPage()),
            Divider(height: 0, color: Colors.grey[400]),
            _createListMenu(
                AppLocalizations.of(context)
                    .translate('set_address_for_delivery'),
                SetAddressPage()),
            Divider(height: 0, color: Colors.grey[400]),
            _createListMenu(
                AppLocalizations.of(context).translate('order_list'),
                OrderPage()),
            Divider(height: 0, color: Colors.grey[400]),
            _createListMenu(
                AppLocalizations.of(context).translate('review_product'),
                ListInvoicesPage()),
            Divider(height: 0, color: Colors.grey[400]),
            _createListMenu(
                AppLocalizations.of(context).translate('payment_method'),
                PaymentMethodPage()),
            Divider(height: 0, color: Colors.grey[400]),
            _createListMenu(
                AppLocalizations.of(context).translate('last_seen_product'),
                LastSeenProductPage()),
            Divider(height: 0, color: Colors.grey[400]),
            _createListMenu(
                AppLocalizations.of(context).translate('change_language'),
                ChangeLanguagePage()),
            Divider(height: 0, color: Colors.grey[400]),
            _createListMenu(
                AppLocalizations.of(context).translate('notification_setting'),
                NotificationSettingPage()),
            Divider(height: 0, color: Colors.grey[400]),
            _createListMenu(
                AppLocalizations.of(context).translate('about'), AboutPage()),
            Divider(height: 0, color: Colors.grey[400]),
            _createListMenu(
                AppLocalizations.of(context).translate('terms_conditions'),
                TermsConditionsPage()),
            Divider(height: 0, color: Colors.grey[400]),
            _createListMenu(
                AppLocalizations.of(context).translate('privacy_policy'),
                PrivacyPolicyPage()),
            Divider(height: 0, color: Colors.grey[400]),
            Container(
              margin: EdgeInsets.fromLTRB(0, 18, 0, 0),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SigninPage()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.power_settings_new,
                        size: 20, color: ASSENT_COLOR),
                    SizedBox(width: 8),
                    Text(AppLocalizations.of(context).translate('sign_out'),
                        style: TextStyle(fontSize: 15, color: ASSENT_COLOR)),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget _createAccountInformation() {
    final double profilePictureSize = MediaQuery.of(context).size.width / 4;
    return Container(
      margin: EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: profilePictureSize,
            height: profilePictureSize,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AccountInformationPage()));
              },
              child: CircleAvatar(
                backgroundColor: Colors.grey[200],
                radius: profilePictureSize,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: profilePictureSize - 4,
                  child: Hero(
                    tag: 'profilePicture',
                    child: ClipOval(
                        child: buildCacheNetworkImage(
                            width: profilePictureSize - 4,
                            height: profilePictureSize - 4,
                            url:
                                GLOBAL_URL + '/assets/images/user/avatar.png')),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Omale',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AccountInformationPage()));
                  },
                  child: Row(
                    children: [
                      Text(
                          AppLocalizations.of(context)
                              .translate('account_information'),
                          style: TextStyle(fontSize: 14, color: BLACK_GREY)),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(Icons.chevron_right, size: 20, color: SOFT_GREY)
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _createListMenu(String menuTitle, StatefulWidget page) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 18, 0, 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(menuTitle, style: TextStyle(fontSize: 15, color: CHARCOAL)),
            Icon(Icons.chevron_right, size: 20, color: SOFT_GREY),
          ],
        ),
      ),
    );
  }
}
