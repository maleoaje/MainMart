import 'package:flutter/material.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';

class GlobalWidget{
  Widget customNotifIcon(int count, Color color) {
    return Stack(
      children: <Widget>[
        Icon(Icons.notifications, color: color),
        Positioned(
          right: 0,
          child: Container(
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: ASSENT_COLOR,
              borderRadius: BorderRadius.circular(10),
            ),
            constraints: BoxConstraints(
              minWidth: 14,
              minHeight: 14,
            ),
            child: Center(
              child: Text(
                count.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget createRatingBar(double rating){
    return Row(
      children: [
        for(int i=1;i<=rating;i++) Icon(Icons.star, color: Colors.yellow[700], size: 12),
        for(int i=1;i<=(5-rating);i++) Icon(Icons.star_border, color: Colors.yellow[700], size: 12),
      ],
    );
  }

  Widget buildProgressIndicator(lastData) {
    if(lastData==false){
      return new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Center(
          child: new Opacity(
            opacity: 1,
            child: new Container(
              height: 20,
              width: 20,
              margin: EdgeInsets.all(5),
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(PRIMARY_COLOR),
                strokeWidth: 2.0,
              ),
            ),
          ),
        ),
      );
    } return null;
  }

  Widget createDefaultLabel(context){
    return Container(
      padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
      decoration: BoxDecoration(
          color: SOFT_BLUE,
          borderRadius: BorderRadius.circular(2)
      ),
      child: Row(
        children: [
          Text(AppLocalizations.of(context).translate('default'), style: TextStyle(
              color: Colors.white, fontSize: 13
          )),
          SizedBox(
            width: 4,
          ),
          Icon(Icons.done, color: Colors.white, size: 11)
        ],
      ),
    );
  }
}