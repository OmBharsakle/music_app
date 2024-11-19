import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/music_controller.dart';
import '../../model/api_music_model.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    MusicController musicController = Get.put(MusicController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            TextField(
              textInputAction: TextInputAction.search,
              onSubmitted: (value) async {
                musicController.apiSearchingNewSong(value);
              },
              style: TextStyle(color: Colors.white,),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                      borderSide:
                          BorderSide(color: Colors.green.withOpacity(0))
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      //
                      borderSide:
                          BorderSide(color: Colors.green.withOpacity(0))
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          BorderSide(color: Colors.green.withOpacity(0))
                  ),
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.white54),
                  icon: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back_outlined))
              ),
            ),
            Container(
              height: h,
              width: w,
              child: Obx(
                () => (musicController.searchApiModal.isNotEmpty)?FutureBuilder(
                  future: musicController.searchApiModal[0],
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                       Rx<ApiMusicModel>? apiMusicModel = snapshot.data as Rx<ApiMusicModel>?;
                      return SingleChildScrollView(
                        // scrollDirection:
                        // Axis.horizontal,
                        child: Column(
                          children: [
                            ...List.generate(
                              apiMusicModel!.value
                                  .data
                                  .results
                                  .length,
                                  (indexs) {
                                return ListTile(
                                  onTap: () async {
                                    //Todo select Music Index,And All Music List
                                    try{
                                      if(musicController.saveList.value.success==null || musicController.saveList.value.data.results[musicController.selectIndex.value].downloadUrl[musicController.saveList.value.data.results[indexs].downloadUrl.length-1].url!=apiMusicModel.value.data.results[indexs].downloadUrl[apiMusicModel.value.data.results[indexs].downloadUrl.length-1].url)
                                      {
                                        musicController.saveList = apiMusicModel;
                                        musicController.selectIndex = indexs.obs;
                                        await musicController.audioPlayPageToPageOnClick();
                                      }
                                    }catch(e)
                                    {
                                      musicController.saveList = apiMusicModel;
                                      musicController.selectIndex = indexs.obs;
                                      await musicController.audioPlayPageToPageOnClick();
                                    }
                                    Get.toNamed("/song");
                                  },
                                  leading: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(image: DecorationImage(image: NetworkImage((apiMusicModel.value.data.results[indexs].image[2].url != null)
                                        ? apiMusicModel.value.data.results[indexs].image[2].url!
                                        : "https://www.vanessa-hopkins.com/wp-content/uploads/2022/11/Untitled-4-01.png"),)),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.add_circle_outline_rounded),
                                      SizedBox(width: 30,),
                                      Icon(Icons.more_vert_sharp),
                                    ],
                                  ),
                                  title: Text(apiMusicModel.value.data.results[indexs].name.toString(),style: TextStyle(color: Colors.white.withOpacity(0.7),),overflow: TextOverflow.ellipsis,),
                                  subtitle: Text(apiMusicModel.value.data.results[indexs].artists.primary[0].name.toString(),style: TextStyle(color: Colors.white.withOpacity(0.3)),overflow: TextOverflow.ellipsis,),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else {
                      return Container();
                    }
                  },
                ):Container(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
