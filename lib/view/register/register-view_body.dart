import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery/view/register/widgets/customTextField.dart';
import 'package:gallery/view_model/cubit/login_register_cubit/login_register_cubit.dart';
import 'package:gallery/view_model/navigator/navigator.dart';

import '../../view_model/navigator/routes.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<LoginRegisterCubit, LoginRegisterState>(
            builder: (context, state) {
              var cubit=BlocProvider.of<LoginRegisterCubit>(context);
              return Form(
                key: cubit.formKey,
                child:ListView(
                  children: [
                    Image.asset('assets/images/register.png',height: MediaQuery.of(context).size.height*0.30),

                    const Text(
                      'Create New Account',
                      style: TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      controller: cubit.nameController,
                      hintText: 'Name',
                      prefix: Icons.person,
                      obscureText: false,
                      type: TextInputType.name,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
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
                      suffixIcon:IconButton(color: Colors.black,
                          onPressed: (){
                            cubit.changeVisibilityPassword();
                          },
                          icon: cubit.suffixPass ?const Icon(Icons.visibility_off):const Icon(Icons.visibility)) ,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(suffixIcon: IconButton(color: Colors.black,
                        onPressed: (){
                          cubit.changeVisibilityConfirmPassword();
                        },
                        icon: cubit.suffixConfirmPass ?const Icon(Icons.visibility_off):const Icon(Icons.visibility)),
                      validate: (value) {
                        if (value!.isEmpty ) {
                          return 'please enter your password';
                        }
                        if(value!=cubit.passController.text)
                        {
                          return 'please enter correct password';
                        }
                        return null;
                      },
                      controller: cubit.confirmPassController,
                      hintText: 'confirm password',
                      prefix: Icons.password,
                      type: TextInputType.visiblePassword,
                      obscureText: cubit.suffixConfirmPass,
                    ),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  16,
                                )))),
                        onPressed: () {
                          if(cubit.formKey.currentState!.validate())
                          {
                            cubit.registerUser(cubit.emailController.text, cubit.passController.text,context);
                            cubit.emailController.clear();
                            cubit.passController.clear();
                            cubit.nameController.clear();
                            cubit.confirmPassController.clear();

                          }



                        },
                        child:state is RegisterLoading? const Center(child: SizedBox(height: 24,width: 24,
                            child: CircularProgressIndicator(color: Colors.white,)),): const Text('Sign Up')),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account ,'),
                        TextButton(
                            onPressed: () {
                              CustomNavigator.push(Routes.login,clean: true);
                            },
                            child: const Text(
                              'Sign in',
                              style: TextStyle(color: Colors.black),
                            ))
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }

}





