import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/view/home/search_page.dart';
import '../../controller/music_controller.dart';
import '../../model/api_music_model.dart';
import '../../utils/globle_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    MusicController musicController = Get.put(MusicController());
    double h = MediaQuery.sizeOf(context).height;
    double w = MediaQuery.sizeOf(context).width;
    int xIndex = random.nextInt(playlistCategories.length);
    int yIndex = random.nextInt(playlistCategories.length);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              // color: Colors.blue.withOpacity(0.0),
              height: h,
              width: w,
              child: StreamBuilder(
                  stream: Connectivity().onConnectivityChanged,
                  builder: (context, snapshots) {
                    try {
                      if (!snapshots.data!
                              .contains(ConnectivityResult.mobile) &&
                          !snapshots.data!.contains(ConnectivityResult.wifi)) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshots.hasError) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return SingleChildScrollView(
                        controller: musicController.controllerAppBar,
                        child: Column(
                          children: [
                            SizedBox(
                              height: h * 0.05,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.more_vert_rounded,
                                      color: Colors.white,
                                      size: 25,
                                    )),
                                Container(
                                  width: 200,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'https://upload.wikimedia.org/wikipedia/commons/thumb/2/26/Spotify_logo_with_text.svg/2560px-Spotify_logo_with_text.svg.png'))),
                                ),
                                IconButton(
                                    onPressed: () {

                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchPage(),));
                                    },
                                    icon: Icon(
                                      CupertinoIcons.search,
                                      color: Colors.white,
                                      size: 25,
                                    )),
                              ],
                            ),
                            ...List.generate(
                              playlistCategories.length,
                              (index) {
                                var musicShareSave =
                                    musicController.apiAllCategoryAdd[index];
                                try {
                                  return FutureBuilder(
                                    future: musicShareSave,
                                    builder: (context, snapshot) {
                                      Rx<ApiMusicModel>? apiMusicModel =
                                          snapshot.data as Rx<ApiMusicModel>?;
                                      if (snapshot.hasError) {
                                        return Center(
                                          child:
                                              Text(snapshot.error.toString()),
                                        );
                                      }
                                      if (snapshot.hasData) {
                                        return (apiMusicModel!
                                                .value.data.results.isNotEmpty)
                                            ? Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        playlistCategories[
                                                            index],
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ).paddingSymmetric(
                                                          vertical: 15,
                                                          horizontal: 5),
                                                      // IconButton(onPressed: () {
                                                      //
                                                      // }, icon: Icon(Icons.arrow_drop_down)),
                                                    ],
                                                  ),
                                                  (apiMusicModel.value.data
                                                              .results.length >
                                                          4)?(index==0 || index==7 || index==4 || index==11)? SingleChildScrollView(
                                                    // scrollDirection:
                                                    // Axis.horizontal,
                                                    child: Column(
                                                      children: [
                                                        ...List.generate(
                                                          apiMusicModel
                                                              .value
                                                              .data
                                                              .results
                                                              .length,
                                                              (indexs) {
                                                            return (indexs>5)?ListTile(
                                                              onTap:
                                                                  () async {
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
                                                              leading:
                                                              Container(
                                                                height:
                                                                40,
                                                                width: 40,
                                                                decoration:
                                                                BoxDecoration(
                                                                    image: DecorationImage(
                                                                      image: NetworkImage((apiMusicModel.value.data.results[indexs].image[2].url !=
                                                                          null)
                                                                          ? apiMusicModel.value.data.results[indexs].image[2].url!
                                                                          : "https://www.vanessa-hopkins.com/wp-content/uploads/2022/11/Untitled-4-01.png"),
                                                                    )),
                                                              ),
                                                              trailing:
                                                              Icon(Icons
                                                                  .navigate_next_outlined),
                                                              title: Text(
                                                                apiMusicModel
                                                                    .value
                                                                    .data
                                                                    .results[
                                                                indexs]
                                                                    .name
                                                                    .toString(),
                                                                style:
                                                                TextStyle(
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(0.7),
                                                                ),
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                              ),
                                                              subtitle:
                                                              Text(
                                                                apiMusicModel
                                                                    .value
                                                                    .data
                                                                    .results[
                                                                indexs]
                                                                    .artists
                                                                    .primary[
                                                                0]
                                                                    .name
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(0.3)),
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                              ),
                                                            ):Container();
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ):
                                                      SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            children: [
                                                              ...List.generate(
                                                                apiMusicModel
                                                                    .value
                                                                    .data
                                                                    .results
                                                                    .length,
                                                                (indexs) {
                                                                  return GestureDetector(
                                                                    onTap:
                                                                        () async {

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
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              120,
                                                                          width:
                                                                              120,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(20),
                                                                              color: Colors.blue,
                                                                              image: DecorationImage(image: NetworkImage((apiMusicModel.value.data.results[indexs].image[2].url != null) ? apiMusicModel.value.data.results[indexs].image[2].url! : "https://www.vanessa-hopkins.com/wp-content/uploads/2022/11/Untitled-4-01.png"), fit: BoxFit.cover)),
                                                                        ).paddingSymmetric(
                                                                            horizontal:
                                                                                10),
                                                                        Container(
                                                                            width:
                                                                                115,
                                                                            child:
                                                                                Text(
                                                                              apiMusicModel.value.data.results[indexs].name!,
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(color: Colors.white.withOpacity(0.6)),
                                                                              overflow: TextOverflow.ellipsis,
                                                                            )).paddingSymmetric(vertical: 5)
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ) :SingleChildScrollView(
                                                          // scrollDirection:
                                                          // Axis.horizontal,
                                                          child: Column(
                                                            children: [
                                                              ...List.generate(
                                                                apiMusicModel
                                                                    .value
                                                                    .data
                                                                    .results
                                                                    .length,
                                                                (indexs) {
                                                                  return ListTile(
                                                                    onTap:
                                                                        () async {
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
                                                                    leading:
                                                                        Container(
                                                                      height:
                                                                          40,
                                                                      width: 40,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              image: DecorationImage(
                                                                        image: NetworkImage((apiMusicModel.value.data.results[indexs].image[2].url !=
                                                                                null)
                                                                            ? apiMusicModel.value.data.results[indexs].image[2].url!
                                                                            : "https://www.vanessa-hopkins.com/wp-content/uploads/2022/11/Untitled-4-01.png"),
                                                                      )),
                                                                    ),
                                                                    trailing:
                                                                        Icon(Icons
                                                                            .navigate_next_outlined),
                                                                    title: Text(
                                                                      apiMusicModel
                                                                          .value
                                                                          .data
                                                                          .results[
                                                                              indexs]
                                                                          .name
                                                                          .toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white
                                                                            .withOpacity(0.7),
                                                                      ),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                    subtitle:
                                                                        Text(
                                                                      apiMusicModel
                                                                          .value
                                                                          .data
                                                                          .results[
                                                                              indexs]
                                                                          .artists
                                                                          .primary[
                                                                              0]
                                                                          .name
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white
                                                                              .withOpacity(0.3)),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                ],
                                              ).paddingAll(5)
                                            : Container();
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  );
                                } catch (e) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                            // (index==)?
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                    } catch (e) {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
