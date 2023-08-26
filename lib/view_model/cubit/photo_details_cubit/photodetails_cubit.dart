import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery/view_model/helpers/shared_helper.dart';
import 'package:meta/meta.dart';
part 'photodetails_state.dart';

class PhotodetailsCubit extends Cubit<PhotodetailsState> {
  PhotodetailsCubit() : super(PhotodetailsInitial());
  static PhotodetailsCubit get(context) =>
      BlocProvider.of<PhotodetailsCubit>(context);

  void addFavorite({
    required String url,
  }) {
    emit(PhotodetailsLoaded());
    SharedHelper().writeFavorites(CachingKey.favorite, url);
  }
}
