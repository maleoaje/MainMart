/*
this is the first pages of the apps
you can use logic to direct the pages to bottom_navigation_bar.dart or signin.dart
this demo is direct to login.dart
We use CupertinoPageTransitionsBuilder in this demo
If you want to use default transition, then remove ThemeData Widget below and delete theme attribute
If you want to show debug label, then change debugShowCheckedModeBanner to true

To use multiple language, wrap BlocBuilder with InitialWrapper
Initial wrapper is to get the language from shared preferences when first time you open the apps
in MaterialApp attribute : add supportedLocales, localizationsDelegates and locale

To use multi language in other page, this is the step :
open assets/lang/en.json and other language and add new 'word' language in the json field
add import 'package:ijshopflutter/ui/reuseable/app_localizations.dart'; in the page
and then use AppLocalizations.of(context).translate('word')
for simple example, you could see lib/ui/default.dart => AppLocalizations.of(context).translate('default')
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ijshopflutter/bloc/account/address/address_bloc.dart';
import 'package:ijshopflutter/bloc/account/last_seen_product/bloc.dart';
import 'package:ijshopflutter/bloc/account/order_list/bloc.dart';
import 'package:ijshopflutter/bloc/general/related_product/bloc.dart';
import 'package:ijshopflutter/bloc/general/review/bloc.dart';
import 'package:ijshopflutter/bloc/home/category/category/bloc.dart';
import 'package:ijshopflutter/bloc/home/category/category_all_product/bloc.dart';
import 'package:ijshopflutter/bloc/home/category/category_banner/bloc.dart';
import 'package:ijshopflutter/bloc/home/category/category_by_id/category_all_product_bloc.dart';
import 'package:ijshopflutter/bloc/home/category/category_for_you/bloc.dart';
import 'package:ijshopflutter/bloc/home/category/category_new_product/bloc.dart';
import 'package:ijshopflutter/bloc/home/category/category_trending_product/bloc.dart';
import 'package:ijshopflutter/bloc/home/coupon/bloc.dart';
import 'package:ijshopflutter/bloc/home/flashsale/bloc.dart';
import 'package:ijshopflutter/bloc/home/home_banner/bloc.dart';
import 'package:ijshopflutter/bloc/home/home_trending/bloc.dart';
import 'package:ijshopflutter/bloc/home/last_search/bloc.dart';
import 'package:ijshopflutter/bloc/home/recomended_product/bloc.dart';
import 'package:ijshopflutter/bloc/home/search/search/search_bloc.dart';
import 'package:ijshopflutter/bloc/home/search/search_product/bloc.dart';
import 'package:ijshopflutter/bloc/shopping_cart/bloc.dart';
import 'package:ijshopflutter/bloc/wishlist/bloc.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/cubit/language/language_cubit.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/reuseable/initial_wrapper.dart';
import 'package:ijshopflutter/ui/splash_screen.dart';

import 'bloc/home/category_page/bloc.dart';

void main() {
  // this function makes application always run in portrait mode
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // initialize bloc here
    return MultiBlocProvider(
      providers: [
        BlocProvider<WishlistBloc>(
          create: (BuildContext context) => WishlistBloc(),
        ),
        BlocProvider<LastSeenProductBloc>(
          create: (BuildContext context) => LastSeenProductBloc(),
        ),
        BlocProvider<AddressBloc>(
          create: (BuildContext context) => AddressBloc(),
        ),
        BlocProvider<OrderListBloc>(
          create: (BuildContext context) => OrderListBloc(),
        ),
        BlocProvider<RelatedProductBloc>(
          create: (BuildContext context) => RelatedProductBloc(),
        ),
        BlocProvider<ReviewBloc>(
          create: (BuildContext context) => ReviewBloc(),
        ),
        BlocProvider<CouponBloc>(
          create: (BuildContext context) => CouponBloc(),
        ),
        BlocProvider<HomeBannerBloc>(
          create: (BuildContext context) => HomeBannerBloc(),
        ),
        BlocProvider<LastSearchBloc>(
          create: (BuildContext context) => LastSearchBloc(),
        ),
        BlocProvider<HomeTrendingBloc>(
          create: (BuildContext context) => HomeTrendingBloc(),
        ),
        BlocProvider<FlashsaleBloc>(
          create: (BuildContext context) => FlashsaleBloc(),
        ),
        BlocProvider<CategoryForYouBloc>(
          create: (BuildContext context) => CategoryForYouBloc(),
        ),
        BlocProvider<RecomendedProductBloc>(
          create: (BuildContext context) => RecomendedProductBloc(),
        ),
        BlocProvider<SearchBloc>(
          create: (BuildContext context) => SearchBloc(),
        ),
        BlocProvider<SearchProductBloc>(
          create: (BuildContext context) => SearchProductBloc(),
        ),
        BlocProvider<CategoryBannerBloc>(
          create: (BuildContext context) => CategoryBannerBloc(),
        ),
        BlocProvider<CategoryTrendingProductBloc>(
          create: (BuildContext context) => CategoryTrendingProductBloc(),
        ),
        BlocProvider<CategoryNewProductBloc>(
          create: (BuildContext context) => CategoryNewProductBloc(),
        ),
        BlocProvider<CategoryAllProductBloc>(
          create: (BuildContext context) => CategoryAllProductBloc(),
        ),
        BlocProvider<CategoryByIdBloc>(
          create: (BuildContext context) => CategoryByIdBloc(),
        ),
        BlocProvider<CategoryBloc>(
          create: (BuildContext context) => CategoryBloc(),
        ),
        BlocProvider<CategoryPageBloc>(
          create: (BuildContext context) => CategoryPageBloc(),
        ),
        BlocProvider<LanguageCubit>(
          create: (BuildContext context) => LanguageCubit(),
        ),
      ],
      // if you want to change default language, go to lib/ui/reuseable/initial_wrapper.dart and change en US to your default language
      child: InitialWrapper(
        child: BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, state) {
          print(state.toString());
          return MaterialApp(
            theme: ThemeData(
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              }),
            ),
            supportedLocales: [
              Locale('en', 'US'),
              Locale('id', 'ID'),
              Locale('ar', 'DZ'),
              Locale('zh', 'HK'),
              Locale('hi', 'IN'),
              Locale('th', 'TH'),
            ],
            // These delegates make sure that the localization data for the proper language is loaded
            localizationsDelegates: [
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            // Returns a locale which will be used by the app
            locale: (state is ChangeLanguageSuccess)
                ? state.locale
                : Locale('en', 'US'),
            title: APP_NAME,
            debugShowCheckedModeBanner: false,
            home: SplashScreenPage(),
          );
        }),
      ),
    );
  }
}
