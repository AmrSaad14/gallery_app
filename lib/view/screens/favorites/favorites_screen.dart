import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery/view_model/cubit/favourites_cubit/favourites_cubit.dart';
import '../../widgets/photo_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => FavouritesCubit()..favourites(),
        child: BlocConsumer<FavouritesCubit, FavouritesState>(
          listener: (context, state) {
          },
          builder: (context, state) {
            var cubit = FavouritesCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
              ),
              body: GridView.builder(
                shrinkWrap: true,
                itemCount: cubit.photos.length,
                padding: const EdgeInsets.all(15),
                itemBuilder: (context, index) => PhotoItem(
                  url: cubit.photos[index],
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
              ),
            );
          },
        ));
  }
}
