import 'dart:isolate';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
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
  int progress = 0;
  ReceivePort _receivePort = ReceivePort();

  static callBack(id, status, progress) {
    SendPort? sendPort = IsolateNameServer.lookupPortByName("downloading");
    if (sendPort != null) {
      sendPort.send([id, status, progress]);
    }
  }

  void details(){
    _receivePort.listen((message) {
      progress = message[2];
      print(progress);
    });
    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, "downloading");

    FlutterDownloader.registerCallback(callBack);
    emit(Details());
  }
}
