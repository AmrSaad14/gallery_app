import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery/model/models/base_models/photos.dart';
import 'package:gallery/view_model/cubit/home_cubit/home_cubit.dart';
import 'package:gallery/view_model/navigator/navigator.dart';
import 'package:gallery/view_model/navigator/routes.dart';

import '../../widgets/photo_item.dart';

class PhotosScreen extends StatelessWidget {

  //this list will be used to store all the photos
  late List<Photo> photos;

  Future _refresh() async {
    homeCubit.getPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getPhotos(page: 2,perPage: 40),
      child: Scaffold(
          appBar: AppBar(leading: IconButton(onPressed: () async {
            await FirebaseAuth.instance.signOut();
            CustomNavigator.push(Routes.login, replace: true);
          },
              icon: const Icon(Icons.logout_outlined)),
            title: const Text('Home'),
            centerTitle: true,
            actions: [
              //this is the action button to go to the search screen
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  CustomNavigator.push(Routes.search);
                },
              ),
            ],
            elevation: 0,
          ),
          body: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              //check if state al already loaded and if it is then set the photos list to the state photos list
              if (state is HomeLoaded) {
                photos = state.photos;
              }
            },
            builder: (context, state) {
              return (state is HomeLoading)
                  ? const Center(child: CircularProgressIndicator())
                  :
              // we use gird view to display all the photos in the screen
              RefreshIndicator(
                onRefresh: _refresh,
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: photos.length,
                  padding: const EdgeInsets.all(15),
                  itemBuilder: (context, index) =>
                      PhotoItem(
                        url: photos[index].src!.portrait!,
                        author: photos[index].photographer!,
                        description: photos[index].alt!,
                      ),
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                ),
              );
            },
          )),
    );
  }
}
