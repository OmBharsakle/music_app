import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:music_app/view/home/home_page.dart';
import 'package:music_app/view/music/song_page.dart';
import 'controller/music_controller.dart';


void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  MusicController musicController = Get.put(MusicController());
    return GetMaterialApp(
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      title: "Resso - Akhil_sir",
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: "/", page:() =>  HomePage()),
        GetPage(name: "/song", page:() => const SongPage()),
      ],
    );
  }
}
