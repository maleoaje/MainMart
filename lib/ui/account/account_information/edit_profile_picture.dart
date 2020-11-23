/*
This is edit profile picture page

install plugin in pubspec.yaml
- fluttertoast => to show toast (https://pub.dev/packages/fluttertoast)
- image_picker => to pick image from storage or camera (https://pub.dev/packages/image_picker)
  add this to ios Info.plist
  <key>NSPhotoLibraryUsageDescription</key>
  <string>I need this permission to test upload photo</string>
  <key>NSCameraUsageDescription</key>
  <string>I need this permission to test upload photo</string>
  <key>NSMicrophoneUsageDescription</key>
  <string>I need this permission to test upload photo</string>

- image_cropper => to crop the image after get from storage or camera (https://pub.dev/packages/image_cropper)
  add this to android manifest :
  <activity
    android:name="com.yalantis.ucrop.UCropActivity"
    android:screenOrientation="portrait"
    android:theme="@style/Theme.AppCompat.Light.NoActionBar"/>

- permission_handler => to handle permission such as storage, camera (https://pub.dev/packages/permission_handler)

we add some logic function so if the user press back or done with this pages, cache images will be deleted and not makes the storage full

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ijshopflutter/config/constants.dart';

class EditProfilePicturePage extends StatefulWidget {
  @override
  _EditProfilePicturePageState createState() => _EditProfilePicturePageState();
}

class _EditProfilePicturePageState extends State<EditProfilePicturePage> {
  // initialize global function
  final _globalFunction = GlobalFunction();

  File _image;
  final _picker = ImagePicker();

  File _selectedFile;
  bool _inProcess = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (_selectedFile != null && _selectedFile.existsSync()) {
      _selectedFile.deleteSync();
    }
    _selectedFile = null;
    super.dispose();
  }

  void _askPermissionCamera() {
    PermissionHandler().requestPermissions([PermissionGroup.camera]).then(
        _onStatusRequestedCamera);
  }

  void _askPermissionStorage() {
    PermissionHandler()
        .requestPermissions([PermissionGroup.storage]).then(_onStatusRequested);
  }

  void _askPermissionPhotos() {
    PermissionHandler()
        .requestPermissions([PermissionGroup.photos]).then(_onStatusRequested);
  }

  void _onStatusRequested(Map<PermissionGroup, PermissionStatus> status) {
    PermissionGroup perm;
    if (Platform.isIOS) {
      perm = PermissionGroup.photos;
    } else {
      perm = PermissionGroup.storage;
    }
    if (status[perm] != PermissionStatus.granted) {
      if (Platform.isIOS) {
        PermissionHandler().openAppSettings();
      }
    } else {
      _getImage(ImageSource.gallery);
    }
  }

  void _onStatusRequestedCamera(Map<PermissionGroup, PermissionStatus> status) {
    if (status[PermissionGroup.camera] != PermissionStatus.granted) {
      PermissionHandler().openAppSettings();
    } else {
      _getImage(ImageSource.camera);
    }
  }

  void _getImage(ImageSource source) async {
    this.setState((){
      _inProcess = true;
    });

    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });

    if(_image != null){
      File cropped = await ImageCropper.cropImage(
          sourcePath: _image.path,
          aspectRatio: CropAspectRatio(
              ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          cropStyle:CropStyle.circle,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            initAspectRatio: CropAspectRatioPreset.original,
            toolbarColor: Colors.white,
            toolbarTitle: AppLocalizations.of(context).translate('edit_images'),
            statusBarColor: PRIMARY_COLOR,
            activeControlsWidgetColor: CHARCOAL,
            cropFrameColor: Colors.white,
            cropGridColor: Colors.white,
            toolbarWidgetColor: CHARCOAL,
            backgroundColor: Colors.white,
          )
      );

      this.setState((){
        if(cropped!=null){
          if(_selectedFile!=null && _selectedFile.existsSync()){
            _selectedFile.deleteSync();
          }
          _selectedFile = cropped;
        }

        // delete image camera
        if(source.toString()=='ImageSource.camera' && _image.existsSync()){
          _image.deleteSync();
        }

        _inProcess = false;
      });
    } else {
      this.setState((){
        _inProcess = false;
      });
    }
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
            AppLocalizations.of(context).translate('edit_profile_picture'),
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
        body: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 8),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  _getImageWidget(),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.camera_alt,
                              color: BLACK_GREY,
                              size: 40,
                            ),
                            SizedBox(width: 10),
                            Text(AppLocalizations.of(context).translate('camera')),
                          ],
                        ),
                        onTap: () {
                          if (Platform.isIOS) {
                            _askPermissionCamera();
                          } else {
                            _getImage(ImageSource.camera);
                          }
                        },
                      ),
                      Container(
                        width: 20,
                      ),
                      GestureDetector(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.photo,
                              color: BLACK_GREY,
                              size: 40,
                            ),
                            SizedBox(width: 10),
                            Text(AppLocalizations.of(context).translate('gallery')),
                          ],
                        ),
                        onTap: () {
                          if (Platform.isIOS) {
                            _askPermissionPhotos();
                          } else {
                            _askPermissionStorage();
                          }
                        },
                      ),
                    ],
                  ),
                  _buttonSave()
                ],
              ),
            ),
            (_inProcess)?Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ):Center()
          ],
        ));
  }

  Widget _getImageWidget() {
    if (_selectedFile != null) {
      return ClipOval(
        child: Image.file(
          _selectedFile,
          width: 250,
          height: 250,
          fit: BoxFit.fill,
        ),
      );
    } else {
      return ClipOval(
        child: Image.asset(
          'assets/images/placeholder.jpg',
          width: 250,
          height: 250,
          fit: BoxFit.fill,
        ),
      );
    }
  }

  Widget _buttonSave() {
    if (_selectedFile != null) {
      return Container(
        margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: SizedBox(
          child: RaisedButton(
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(color: PRIMARY_COLOR)),
            onPressed: () {
              if (_selectedFile != null && _selectedFile.existsSync()) {
                _globalFunction.startLoading(context, AppLocalizations.of(context).translate('upload_profile_picture_success'), 1);
              } else {
                Fluttertoast.showToast(
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    msg: AppLocalizations.of(context).translate('file_not_found'),
                    fontSize: 13,
                    toastLength: Toast.LENGTH_LONG);
              }
            },
            padding: EdgeInsets.fromLTRB(40, 12, 40, 12),
            color: PRIMARY_COLOR,
            textColor: Colors.white,
            child: Text(
              AppLocalizations.of(context).translate('save'),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
