import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery/model/models/base_models/photos.dart';
import 'package:gallery/view_model/cubit/favourites_cubit/favourites_cubit.dart';
import 'package:gallery/view_model/cubit/home_cubit/home_cubit.dart';
import '../../widgets/photo_item.dart';

class FavoritesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    FavouritesCubit cubit = FavouritesCubit();
    return BlocProvider(
      create: (context) => FavouritesCubit(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {

              },
              builder: (context, state) {
                return BlocConsumer<FavouritesCubit, FavouritesState>(
                  listener: (context, state) {
                    if(state is FavouritesCubit){
                      print('FavouritesCubit');
                    }else {
                      print('error');
                    }
                  },
                  builder: (context, state) {
                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: cubit.photos.length,
                      padding: const EdgeInsets.all(15),
                      itemBuilder: (context, index) =>
                          PhotoItem(
                            url: cubit.photos[index],
                          ),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

}


