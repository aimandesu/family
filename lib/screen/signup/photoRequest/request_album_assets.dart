import 'package:photo_manager/photo_manager.dart';

Future requestAlbumAssets(AssetPathEntity album) async {
  final List<AssetEntity> assets =
      await album.getAssetListRange(start: 0, end: 80);

  //getAssetListPaged(page: 0, size: 80)
  //getAssetListRange(start: 0, end: 80)

  return assets;
}
