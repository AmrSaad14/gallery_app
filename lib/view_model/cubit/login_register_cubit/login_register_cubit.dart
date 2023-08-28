import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery/view_model/helpers/shared_helper.dart';
import 'package:meta/meta.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../navigator/navigator.dart';
import '../../navigator/routes.dart';
part 'login_register_state.dart';

class LoginRegisterCubit extends Cubit<LoginRegisterState> {
  LoginRegisterCubit() : super(LoginRegisterInitial());
  bool suffixPass=false;
  bool suffixConfirmPass=false;
   TextEditingController emailController=TextEditingController();
   TextEditingController passController=TextEditingController();
   TextEditingController nameController=TextEditingController() ;
   TextEditingController confirmPassController=TextEditingController() ;
  var formKey = GlobalKey<FormState>();
  SharedHelper helper=SharedHelper();
  changeVisibilityConfirmPassword()
  {
    suffixConfirmPass=!suffixConfirmPass;
    emit(CheckVisibility());
  }
  changeVisibilityPassword()
  {
    suffixPass=!suffixPass;
    emit(CheckVisibility());
  }
  Future registerUser(String email,String password,context)async
  {
    emit(RegisterLoading());
    try {
   UserCredential user= await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
    await helper.saveUid('uId', user.user!.uid);
    CustomNavigator.push(Routes.home,replace: true,);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Registered Successfully')));

    emit(RegisterSuccess());
    } on FirebaseAuthException catch (e)
    {
      if (e.code == 'weak-password')
      {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          text: 'The password provided is too weak.',
          autoCloseDuration: const Duration(seconds: 2),
        );
      } else if (e.code == 'email-already-in-use')
      {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          text: 'The account already exists for that email.',
          autoCloseDuration: const Duration(seconds: 2),
        );

      }
      emit(RegisterFailure(e.toString()));
    } catch (e) {
      print(e);
      emit(RegisterFailure(e.toString()));
    }
  }
  signInUser(String email,String password,context)async
  {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      CustomNavigator.push(Routes.home,replace: true);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('login Successfully')));

      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          text: 'No user found for that email.',
          autoCloseDuration: const Duration(seconds: 2),
        );
      } else if (e.code == 'wrong-password') {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          text: 'Wrong password provided for that user.',
          autoCloseDuration: const Duration(seconds: 2),
        );
      }
      emit(LoginFailure(e.toString()));
    }
  }

}
