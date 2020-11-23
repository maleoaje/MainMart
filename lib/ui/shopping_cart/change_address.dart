/*
This is change address page

include file in reuseable/shimmer_loading.dart to use shimmer loading
include file in reuseable/global_function.dart to call function from GlobalFunction
include file in model/account/address_model.dart to get addressData
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ijshopflutter/bloc/account/address/bloc.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/config/global_style.dart';
import 'package:ijshopflutter/model/account/address_model.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/global_function.dart';
import 'package:ijshopflutter/ui/reuseable/shimmer_loading.dart';

class ChangeAddressPage extends StatefulWidget {
  @override
  _ChangeAddressPageState createState() => _ChangeAddressPageState();
}

class _ChangeAddressPageState extends State<ChangeAddressPage> {
  // initialize global function and shimmer loading
  final _globalFunction = GlobalFunction();
  final _shimmerLoading = ShimmerLoading();

  List<AddressModel> addressData = List();

  AddressBloc _addressBloc;
  bool _lastData = false;

  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

  @override
  void initState() {
    // get data when initState
    _addressBloc = BlocProvider.of<AddressBloc>(context);
    _addressBloc.add(GetAddress(sessionId: SESSION_ID, apiToken: apiToken));

    super.initState();
  }

  @override
  void dispose() {
    apiToken.cancel("cancelled"); // cancel fetch data from API
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
            AppLocalizations.of(context).translate('change_address'),
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
        body: BlocListener<AddressBloc, AddressState>(
          listener: (context, state) {
            if (state is AddressError) {
              _globalFunction.showToast(
                  type: 'error', message: state.errorMessage);
            }
            if (state is GetAddressSuccess) {
              if (state.addressData.length == 0) {
                _lastData = true;
              } else {
                addressData.addAll(state.addressData);
              }
            }
          },
          child: BlocBuilder<AddressBloc, AddressState>(
            builder: (context, state) {
              if (state is AddressError) {
                return Container(
                    child: Center(
                        child: Text(ERROR_OCCURED,
                            style:
                                TextStyle(fontSize: 14, color: BLACK_GREY))));
              } else {
                if (_lastData) {
                  return Container(
                      child: Center(
                          child: Text(
                              AppLocalizations.of(context)
                                  .translate('no_address_data'),
                              style:
                                  TextStyle(fontSize: 14, color: BLACK_GREY))));
                } else {
                  if (addressData.length == 0) {
                    return _shimmerLoading.buildShimmerContent();
                  } else {
                    return ListView.builder(
                      itemCount: addressData.length,
                      // Add one more item for progress indicator
                      padding: EdgeInsets.symmetric(vertical: 0),
                      itemBuilder: (BuildContext context, int index) {
                        return _buildAddressCard(index);
                      },
                    );
                  }
                }
              }
            },
          ),
        ));
  }

  Widget _buildAddressCard(int index) {
    return Container(
      margin: EdgeInsets.fromLTRB(12, 6, 12, 0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addressData[index].defaultAddress == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(addressData[index].title,
                            style: GlobalStyle.addressTitle),
                        Container(
                          margin: EdgeInsets.only(right: 8),
                          padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                          decoration: BoxDecoration(
                              color: SOFT_BLUE,
                              borderRadius: BorderRadius.circular(2)),
                          child: Row(
                            children: [
                              Text(
                                  AppLocalizations.of(context)
                                      .translate('default'),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13)),
                              SizedBox(
                                width: 4,
                              ),
                              Icon(Icons.done, color: Colors.white, size: 11)
                            ],
                          ),
                        )
                      ],
                    )
                  : Text(addressData[index].title,
                      style: GlobalStyle.addressTitle),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(addressData[index].recipientName,
                    style: GlobalStyle.addressContent),
              ),
              Container(
                margin: EdgeInsets.only(top: 4),
                child: Text(addressData[index].phoneNumber,
                    style: GlobalStyle.addressContent),
              ),
              Container(
                margin: EdgeInsets.only(top: 4),
                child: Text(addressData[index].addressLine1,
                    style: GlobalStyle.addressContent),
              ),
              Container(
                margin: EdgeInsets.only(top: 4),
                child: Text(
                    addressData[index].addressLine2 +
                        ' ' +
                        addressData[index].postalCode,
                    style: GlobalStyle.addressContent),
              ),
              Container(
                margin: EdgeInsets.only(top: 4),
                child: Text(addressData[index].state,
                    style: GlobalStyle.addressContent),
              ),
              Container(
                  margin: EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      addressData[index].defaultAddress == false
                          ? GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                  AppLocalizations.of(context)
                                      .translate('use_this'),
                                  style: GlobalStyle.addressAction),
                            )
                          : Wrap(),
                      index != 0
                          ? SizedBox(
                              width: 12,
                            )
                          : Wrap(),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
