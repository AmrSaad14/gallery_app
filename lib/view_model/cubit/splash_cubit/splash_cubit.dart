import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:gallery/view_model/helpers/shared_helper.dart';
import 'package:gallery/view_model/navigator/navigator.dart';
import 'package:gallery/view_model/navigator/routes.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  static SplashCubit get(context) => BlocProvider.of<SplashCubit>(context);
  SharedHelper helper=SharedHelper();
// splash method to remove splash screen and navigate to home screen
  void splashLoaded() {
    FlutterNativeSplash.remove();

    Future.delayed(const Duration(seconds: 3), () {
      emit(SplashLoaded());

      String ? uId=helper.getUid('uId');
      if(uId!=null)
        {
          CustomNavigator.push(Routes.home,replace: true);
        }
      else
        {
          CustomNavigator.push(Routes.register);

        }


    });
  }
}
