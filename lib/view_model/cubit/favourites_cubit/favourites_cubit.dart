import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery/view_model/helpers/shared_helper.dart';
part 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState>{
  FavouritesCubit() : super(FavouritesInitial());
  static FavouritesCubit get(context) => BlocProvider.of<FavouritesCubit>(context);
  List<String> photos = [];
  favourites (){
    SharedHelper().readFavorites(CachingKey.favorite).then((value) {
      photos.addAll(value);
      emit(AddFavourite());
    });
  }
}