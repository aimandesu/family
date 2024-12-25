import 'dart:io';

import 'package:family/screen/signup/photoRequest/request_album.dart';
import 'package:family/screen/signup/photoRequest/request_album_assets.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class PhotoSelector extends StatefulWidget {
  final Function setImage;
  final VoidCallback closeCamera;
  const PhotoSelector({
    super.key,
    required this.setImage,
    required this.closeCamera,
  });

  @override
  State<PhotoSelector> createState() => _PhotoSelectorState();
}

class _PhotoSelectorState extends State<PhotoSelector> {
  bool isLoading = false;
  List<AssetPathEntity> albums = [];
  AssetPathEntity? currentAlbum;

  List<AssetEntity> assets = [];

  @override
  void initState() {
    getPhoto(RequestType.image);
    super.initState();
  }

  void getPhoto(RequestType type) async {
    setState(() {
      isLoading = true;
    });
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth == false) {
      await PhotoManager.openSetting();
    } else {
      await requestAlbums(type).then((allAlbums) async {
        setState(() {
          albums = allAlbums;
          currentAlbum = allAlbums.first;
        });
        if (currentAlbum != null) {
          await requestAlbumAssets(currentAlbum!).then((allAssets) {
            setState(() {
              assets = allAssets;

              if (assets.isNotEmpty) {
                isLoading = false;
              }
            });
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButton<AssetPathEntity>(
          value: currentAlbum,
          items: albums.map((AssetPathEntity albums) {
            return DropdownMenuItem(
              value: albums,
              child: Text(albums.name == "" ? '0' : ''
                  // : "${albums.name}(${albums.assetCount})"),
                  ),
            );
          }).toList(),
          onChanged: (AssetPathEntity? newAlbum) async {
            setState(() {
              currentAlbum = newAlbum;
            });
            if (currentAlbum != null) {
              await requestAlbumAssets(currentAlbum!).then((value) {
                setState(() {
                  assets = value;
                  if (assets.isNotEmpty) {
                    isLoading = false;
                  }
                });
              });
            }
          },
        ),
        SizedBox(
          height: size.height * 0.28,
          width: size.width * 1,
          child: Column(
            children: [
              if (assets.isEmpty && isLoading == false)
                const Flexible(
                  child: Center(
                    child: Text("album is empty"),
                  ),
                ),
              if (isLoading == true)
                const Flexible(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              if (assets.isNotEmpty)
                Flexible(
                  child: GridView.custom(
                    padding: EdgeInsets.zero, // set padding to zero
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    childrenDelegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final entity = assets[index];
                        return GestureDetector(
                          onTap: () async {
                            File? imageFile = await entity.file;
                            widget.setImage(imageFile as File);
                            widget.closeCamera();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(1),
                            child: assetMediaWidget(entity),
                          ),
                        );
                      },
                      childCount: assets.length,
                    ),
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }

  Widget assetMediaWidget(entity) => Stack(
        children: [
          Positioned.fill(
            child: Text('da'),

            // AssetEntityImage(
            //   entity,
            //   isOriginal: false,
            //   thumbnailSize: const ThumbnailSize.square(250),
            //   fit: BoxFit.cover,
            //   errorBuilder: (context, error, stackTrace) {
            //     return const Center(
            //       child: Icon(Icons.error),
            //     );
            //   },
            // ),
          ),
        ],
      );
}
