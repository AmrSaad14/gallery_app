import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:gallery/constants/colors.dart';
import 'package:gallery/view_model/cubit/download_cubit/download_cubit.dart';
import 'package:gallery/view_model/cubit/favourites_cubit/favourites_cubit.dart';
import 'package:gallery/view_model/cubit/home_cubit/home_cubit.dart';
import 'package:gallery/view_model/cubit/login_register_cubit/login_register_cubit.dart';
import 'package:gallery/view_model/cubit/photo_details_cubit/photodetails_cubit.dart';
import 'package:gallery/view_model/cubit/search_cubit/search_cubit.dart';
import 'package:gallery/view_model/cubit/splash_cubit/splash_cubit.dart';
import 'package:gallery/view_model/helpers/shared_helper.dart';
import 'package:gallery/view_model/navigator/navigator.dart';
import 'package:gallery/view_model/navigator/routes.dart';
import 'package:gallery/constants/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedHelper.init();
  await FlutterDownloader.initialize(
    debug: true, // set false to disable printing logs to console
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light, statusBarColor: black));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>LoginRegisterCubit()),
        BlocProvider<SplashCubit>(
          create: (context) => SplashCubit(),
        ),
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(),
        ),
        BlocProvider<PhotodetailsCubit>(
            create: (context) => PhotodetailsCubit()),
        BlocProvider<SearchCubit>(create: (context) => SearchCubit()),
        BlocProvider<DownloadCubit>(create: (context) => DownloadCubit()),
        BlocProvider<FavouritesCubit>(create: (context)=>FavouritesCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wallpapers Gallery',
        onGenerateRoute: CustomNavigator.onGenerateRoute,
        initialRoute: Routes.splash,
        navigatorKey: CustomNavigator.navigatorState,
        theme: AppTheme.theme,
      ),
    );
  }
}
