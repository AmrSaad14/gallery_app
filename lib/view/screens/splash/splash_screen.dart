import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery/view_model/cubit/splash_cubit/splash_cubit.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..splashLoaded(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<SplashCubit, SplashState>(
          builder: (context, state) {
            return const Center(
              child: Image(image: AssetImage('assets/images/logo.jpg')),
            );
          },
        ),
      ),
    );
  }
}
