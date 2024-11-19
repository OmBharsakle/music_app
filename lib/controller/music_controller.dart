import 'dart:math';
import 'package:just_audio/just_audio.dart';
import 'package:get/get.dart';
import '../model/api_music_model.dart';
import '../utils/globle_list.dart';
import 'api_helper.dart';


class MusicController extends GetxController {
  Rx<ApiMusicModel>? apiMusicModel;
  RxList searchApiModal = [].obs;
  late Rx<ApiMusicModel> saveList;
  RxInt selectIndex = 0.obs;
  var controllerAppBar;
  RxList apiAllCategoryAdd = [].obs;
  var musicOn=false.obs;
  void apiSearchingNewSong(String value)
  {
    searchApiModal.clear();
    searchApiModal.add(apiGetMethod(value));
  }

  MusicController() {
    Random random =Random();
    for (int i = 0; i < playlistCategories.length; i++) {
      apiAllCategoryAdd.add(apiGetMethod(playlistCategories[i]+letterMusicList[random.nextInt(letterMusicList.length)]));
      // apiAllCategoryAdd.add(apiGetMethod(playlistCategories[i]+letterMusicList[random.nextInt(letterMusicList.length)]));
    }
  }

  Future<Rx<ApiMusicModel>?> apiGetMethod(String musicTypes) async {
    final jsonMap = await ApiHelper.apiHelper.apiGetMethod(musicTypes);
    apiMusicModel = ApiMusicModel.fromJson(jsonMap).obs;
    return apiMusicModel;
  }

  //Music All Work
  AudioPlayer player =AudioPlayer();
  Duration? duration;
  Future<void> audioPlayPageToPageOnClick()
  async {
    duration = (await player.setUrl(saveList.value.data.results[selectIndex.value].downloadUrl[saveList.value.data.results[selectIndex.value].downloadUrl.length-1].url!))!;
    player.play();
  }

  Future<void> audioStopPageToPageOnClick()
  async {

    if(musicOn.value)
      {
        musicOn.value=false;
        player.play();
      }
    else
      {
        musicOn.value=true;
        player.pause();
      }
  }

  Stream<Duration> getCurrentPosition()
  {
    return player.positionStream;
  }

  void jumpSong(Duration position)
  {
    player.seek(position);
  }
}
