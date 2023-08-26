import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery/view_model/cubit/login_register_cubit/login_register_cubit.dart';

import '../../../view_model/navigator/navigator.dart';
import '../../../view_model/navigator/routes.dart';
import '../../register/widgets/customTextField.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginRegisterCubit, LoginRegisterState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<LoginRegisterCubit>(context);

        return Form(
          key: cubit.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              children: [
                Image.asset('assets/images/login.png'),
                const Text(
                  'Login to your account',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  controller: cubit.emailController,
                  hintText: 'Email',
                  prefix: Icons.email_outlined,
                  obscureText: false,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'please enter your email';
                    }
                    return null;
                  },
                  type: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  suffixIcon: IconButton(
                      color: Colors.black,
                      onPressed: () {
                        cubit.changeVisibilityPassword();
                      },
                      icon: cubit.suffixPass
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility)),
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'please enter your password';
                    }
                    return null;
                  },
                  controller: cubit.passController,
                  hintText: 'password',
                  prefix: Icons.password,
                  type: TextInputType.visiblePassword,
                  obscureText: cubit.suffixPass,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                          16,
                        )))),
                    onPressed: () {
                      if (cubit.formKey.currentState!.validate())
                      {
                    cubit.signInUser(cubit.emailController.text,
                            cubit.passController.text,context);
                       cubit.emailController.clear();
                       cubit.passController.clear();

                      }
                    },
                    child: state is LoginLoading
                        ? const Center(
                            child: SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                )),
                          )
                        : const Text('Sign in')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account ,'),
                    TextButton(
                        onPressed: () {
                          CustomNavigator.push(Routes.register, clean: true);
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
