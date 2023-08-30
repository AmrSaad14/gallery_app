import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:gallery/constants/colors.dart';
import 'package:gallery/view_model/cubit/download_cubit/download_cubit.dart';
import 'package:gallery/view_model/cubit/photo_details_cubit/photodetails_cubit.dart';
import 'package:permission_handler/permission_handler.dart';

class PhotoDetails extends StatelessWidget {
  final String url;
  final String author;
  final String description;
  const PhotoDetails(
      {Key? key,
      required this.url,
      required this.author,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => PhotodetailsCubit()..details(),
  child: Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Stack(
        children: [
          Image.network(
            url,
            fit: BoxFit.fill,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Card(
              color: white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              elevation: 4,
              child: Container(
                padding: const EdgeInsets.all(7),
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Photo By: $author',
                      style: TextStyle(
                        fontSize: 20,
                        color: black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        color: black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          BlocBuilder<DownloadCubit, DownloadState>(
                            builder: (context, state) {
                              return Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: black),
                                child: IconButton(
                                  icon: const Icon(Icons.download),
                                  color: white,
                                  onPressed: () {
                                    DownloadCubit.get(context)
                                        .download(url);
                                  },
                                ),
                              );
                            },
                          ),
                          BlocBuilder<PhotodetailsCubit, PhotodetailsState>(
                            builder: (context, state) {
                              return Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: black),
                                child: IconButton(
                                  icon: const Icon(Icons.favorite),
                                  color: white,
                                  onPressed: () {
                                    PhotodetailsCubit.get(context)
                                        .addFavorite(url: url);
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
);
  }
}