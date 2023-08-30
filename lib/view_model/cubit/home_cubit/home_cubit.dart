import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery/model/models/photos_model.dart';
import 'package:gallery/model/repository/photos_repo.dart';
import 'package:gallery/view/screens/favorites/favorites_screen.dart';
import 'package:gallery/view/screens/photos/photos_screen.dart';
import 'package:gallery/view_model/navigator/navigator.dart';
import 'package:meta/meta.dart';
import '../../../model/models/base_models/photos.dart';
import '../../helpers/shared_helper.dart';
part 'home_state.dart';

var homeCubit = HomeCubit.get(CustomNavigator.navigatorState.currentContext);

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);

// Get all photos cubit method to get all photos from the repository
  void getPhotos({    int? page,
    int? perPage,
  }) async {
    emit(HomeLoading());
    PhotosModel _res = await PhotosRepo.getAllPhotos(
      page: page,
      perPage: perPage,
    );
    if (_res.totalResults != null) {
      emit(HomeLoaded(photos: _res.photos!));
    } else {
      emit(HomeError());
    }
  }

  List<Widget> screens = [
    PhotosScreen(),
    FavoritesScreen(),
  ];
  int homeScreenCurrentIndex = 0;

  void changeCurrentIndex(int value){
    homeScreenCurrentIndex = value;
    emit(ChangeCurrentIndexSuccessState());
  }


}
