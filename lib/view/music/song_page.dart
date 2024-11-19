import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/music_controller.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.sizeOf(context).height;
    double w = MediaQuery.sizeOf(context).width;
    MusicController musicController = Get.put(MusicController());
    musicController.musicOn.value = false;
    return Scaffold(
        body: Obx(
          () {
            return Column(
                children: [
          SizedBox(
            height: h * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    CupertinoIcons.back,
                    color: Colors.white,
                    size: 30,
                  )),
              Text(
                'Now Palying',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert_rounded,
                    color: Colors.white,
                    size: 30,
                  )),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.only(top: h * 0.1),
                height: h * 0.39,
                width: w * 0.89,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue,
                  image: DecorationImage(
                    image: NetworkImage(musicController
                        .saveList
                        .value
                        .data
                        .results[musicController.selectIndex.value]
                        .image[2]
                        .url!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: h * 0.1),
                  child: ListTile(
                    title: Text(
                      musicController.saveList.value.data
                          .results[musicController.selectIndex.value].name
                          .toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      musicController.saveList.value.data
                          .results[musicController.selectIndex.value].artists.primary[0].name
                          .toString(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          CupertinoIcons.add_circled,
                          color: Colors.white,
                          size: 30,
                        )),
                  )),
              Column(
                children: [
                  StreamBuilder(
                    stream: musicController.getCurrentPosition(),
                    builder: (context, snapshot) {
                      return Slider(
                        max: musicController.duration!.inSeconds.toDouble(),
                        activeColor: Colors.white,
                        thumbColor: Colors.white,
                        value: snapshot.data!.inSeconds.toDouble(),
                        onChanged: (value) {
                          musicController.jumpSong(Duration(seconds: value.toInt()));
                        },
                      );
                    },
                  ),
                  StreamBuilder(
                    stream: musicController.getCurrentPosition(),
                    builder: (context, snapshot) {
                      // Safely get the current position and total duration in seconds
                      final currentPosition = snapshot.data?.inSeconds ?? 0;
                      final totalDuration = musicController.duration?.inSeconds ?? 0;

                      // Function to format seconds into MM:SS format
                      String formatTime(int seconds) {
                        final minutes = (seconds ~/ 60).toString().padLeft(1, '0');
                        final secs = (seconds % 60).toString().padLeft(2, '0');
                        return "$minutes:$secs";
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Current position formatted as MM:SS
                            Text(formatTime(currentPosition)),
                            // Total duration formatted as MM:SS
                            Text(formatTime(totalDuration)),
                          ],
                        ),
                      );
                    },
                  ),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(CupertinoIcons.shuffle, color: Colors.white)),
                  IconButton(
                      onPressed: () async {
                        try {
                          if (0 != musicController.selectIndex.value) {
                            musicController.selectIndex.value--;
                            await musicController
                                .audioPlayPageToPageOnClick();
                          }
                          musicController.musicOn.value = false;
                        } catch (e) {
                          print("Error");
                        }
                      },
                      icon: Icon(CupertinoIcons.backward_end_fill,
                          color: Colors.white)),
                  Obx(
                    () => IconButton(
                        onPressed: () {
                          musicController.audioStopPageToPageOnClick();
                        },
                        icon: musicController.musicOn.value
                            ? Icon(CupertinoIcons.play_circle_fill,
                                size: 60, color: Colors.white)
                            : Icon(CupertinoIcons.pause_circle_fill,
                                size: 60, color: Colors.white)),
                  ),
                  IconButton(
              onPressed: () async {
            if (musicController
                        .saveList.value.data.results.length -
                    1 !=
                musicController.selectIndex.value) {
              try {
                musicController.selectIndex.value++;
                await musicController
                    .audioPlayPageToPageOnClick();
                musicController.musicOn.value = false;
              } catch (e) {
                print("Error");
              }
            }
          },
                      icon: Icon(CupertinoIcons.forward_end_fill,
                          color: Colors.white)),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(CupertinoIcons.loop, color: Colors.white)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(CupertinoIcons.share, color: Colors.white)),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(CupertinoIcons.collections_solid,
                          color: Colors.white)),
                ],
              )
            ],
          ),
                ],
              );
          },
        ));
  }
}

// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceAround,
//   children: [
//     IconButton(
//         onPressed: () async {
//           try {
//             if (0 != musicController.selectIndex.value) {
//               musicController.selectIndex.value--;
//               await musicController
//                   .audioPlayPageToPageOnClick();
//             }
//           } catch (e) {
//             print("Error");
//           }
//         },
//         icon: const Icon(
//           Icons.skip_previous,
//           color: Colors.white,
//           size: 40,
//         )),
//     IconButton(
//         onPressed: () async {
//           if (musicController
//                       .saveList.value.data.results.length -
//                   1 !=
//               musicController.selectIndex.value) {
//             try {
//               musicController.selectIndex.value++;
//               await musicController
//                   .audioPlayPageToPageOnClick();
//             } catch (e) {
//               print("Error");
//             }
//           }
//         },
//         icon: const Icon(
//           Icons.skip_next,
//           color: Colors.white,
//           size: 40,
//         )),
//   ],
// ),
