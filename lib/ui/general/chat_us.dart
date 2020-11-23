/*
This is chat us page

include file in reuseable/cache_image_network.dart to use cache image network
include file in model/general/chat_model.dart

install plugin in pubspec.yaml
- intl => for function DateFormat (https://pub.dev/packages/intl)
- flutter_statusbarcolor => to change status bar color and navigation status bar color (at the very top of the screen) (https://pub.dev/packages/flutter_statusbarcolor)
 */

import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/config/static_variable.dart';
import 'package:ijshopflutter/model/general/chat_model.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/cache_image_network.dart';
import 'package:intl/intl.dart';

class ChatUsPage extends StatefulWidget {
  @override
  _ChatUsPageState createState() => _ChatUsPageState();
}

class _ChatUsPageState extends State<ChatUsPage> {
  bool _fromWhiteStatusBarForeground = false;

  TextEditingController _etChat = TextEditingController();

  String _lastDate = '13 Sep 2020';

  List<ChatModel> _chatList = List();
  List<ChatModel> _chatListReversed = List();

  @override
  void initState() {
    // detect last status bar color from previous page
    _fromWhiteStatusBarForeground = StaticVariable.useWhiteStatusBarForeground;

    // set status bar color to white and status navigation bar color to dark (At the very top of page)
    StaticVariable.useWhiteStatusBarForeground = false;
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _initForLang();
    });

    super.initState();
  }

  void _initForLang() {
    setState(() {
      // set chat dummy data

      // reverse the list
      _chatListReversed = _chatList.reversed.toList();
    });
  }

  @override
  void dispose() {
    _etChat.dispose();
    super.dispose();
  }

  void _addDate(String currentDate) {
    _chatListReversed.insert(
        0, new ChatModel(15, null, 'date', currentDate, null, null));
  }

  void _addMessage(String message) {
    DateTime now = DateTime.now();
    String _currentTime = DateFormat('kk:mm').format(now);
    _chatListReversed.insert(
        0, new ChatModel(16, 'buyer', 'text', message, _currentTime, false));
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
            AppLocalizations.of(context).translate('chat'),
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
        body: WillPopScope(
          onWillPop: () {
            Navigator.pop(context);
            // check the previous status bar color and when the user click back button, set status bar color like the the previous page
            if (_fromWhiteStatusBarForeground == true) {
              StaticVariable.useWhiteStatusBarForeground = true;
              FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
            } else {
              StaticVariable.useWhiteStatusBarForeground = false;
              FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
            }
            return Future.value(true);
          },
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  reverse: true,
                  itemCount: _chatListReversed.length,
                  padding: EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    if (_chatListReversed[index].getTextImageDate == 'date') {
                      return _buildDate(_chatListReversed[index].getMessage);
                    } else if (_chatListReversed[index].getTextImageDate ==
                        'image') {
                      return _buildImage(_chatListReversed[index].getMessage);
                    } else {
                      if (_chatListReversed[index].getType == 'buyer') {
                        return _buildChatBuyer(
                            _chatListReversed[index].getMessage,
                            _chatListReversed[index].getDate,
                            _chatListReversed[index].getRead);
                      } else {
                        return _buildChatSeller(
                            _chatListReversed[index].getMessage,
                            _chatListReversed[index].getDate);
                      }
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: _etChat,
                        minLines: 1,
                        maxLines: 4,
                        textAlignVertical: TextAlignVertical.bottom,
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        onChanged: (textValue) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          hintText: AppLocalizations.of(context)
                              .translate('write_message'),
                          focusedBorder: UnderlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.grey[200])),
                          enabledBorder: UnderlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color: Colors.grey[200]),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          if (_etChat.text != '') {
                            print('send message : ' + _etChat.text);
                            setState(() {
                              DateTime now = DateTime.now();
                              String currentDate =
                                  DateFormat('d MMM yyyy').format(now);
                              if (_lastDate != currentDate) {
                                _lastDate = currentDate;
                                _addDate(currentDate);
                              }
                              _addMessage(_etChat.text);
                              _etChat.text = '';
                            });
                          }
                        },
                        child: ClipOval(
                          child: Container(
                              color: SOFT_BLUE,
                              padding: EdgeInsets.all(10),
                              child: Icon(Icons.send, color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildDate(String date) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Center(
        child: Text(date, style: TextStyle(color: SOFT_GREY, fontSize: 11)),
      ),
    );
  }

  Widget _buildChatBuyer(String message, String time, bool read) {
    final double boxChatSize = MediaQuery.of(context).size.width / 1.3;
    return Container(
      margin: EdgeInsets.only(top: 4),
      child: Wrap(
        alignment: WrapAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: boxChatSize),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey[300]),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(12),
                ),
                color: Colors.grey[300]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(message, style: TextStyle(color: CHARCOAL)),
                ),
                Wrap(
                  children: [
                    SizedBox(width: 4),
                    Icon(Icons.done_all,
                        color: read == true ? PRIMARY_COLOR : SOFT_GREY,
                        size: 11),
                    SizedBox(width: 2),
                    Text(time, style: TextStyle(color: SOFT_GREY, fontSize: 9)),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatSeller(String message, String date) {
    final double boxChatSize = MediaQuery.of(context).size.width / 1.3;
    return Container(
      margin: EdgeInsets.only(top: 4),
      child: Wrap(
        children: [
          Container(
              constraints: BoxConstraints(maxWidth: boxChatSize),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey[300]),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(5),
                  )),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(message, style: TextStyle(color: CHARCOAL)),
                  ),
                  Wrap(
                    children: [
                      SizedBox(width: 2),
                      Text(date,
                          style: TextStyle(color: SOFT_GREY, fontSize: 9)),
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    final double boxChatSize = MediaQuery.of(context).size.width / 1.3;
    final double boxImageSize = (MediaQuery.of(context).size.width / 6);
    return Container(
      margin: EdgeInsets.only(top: 4),
      child: Wrap(
        alignment: WrapAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: boxChatSize),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey[300]),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(12),
                )),
            child: Container(
              width: boxImageSize,
              height: boxImageSize,
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: buildCacheNetworkImage(
                      width: boxImageSize,
                      height: boxImageSize,
                      url: imageUrl)),
            ),
          ),
        ],
      ),
    );
  }
}
