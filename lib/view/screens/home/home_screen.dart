import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery/constants/colors.dart';
import 'package:gallery/view_model/cubit/home_cubit/home_cubit.dart';




class HomeScreen extends StatelessWidget {

  const HomeScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return homeCubit.screens.elementAt(homeCubit.homeScreenCurrentIndex);
        },
      ),
      bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return BottomNavigationBar(
            backgroundColor: white,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.grey[500],
            selectedItemColor: black,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorites'),
            ],
            currentIndex: homeCubit.homeScreenCurrentIndex,
            onTap: (index) {
              homeCubit.changeCurrentIndex(index);
            },
          );
        },
      ),
    );
  }
}
