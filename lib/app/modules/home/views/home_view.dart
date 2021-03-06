import 'package:alquran/app/constant/color.dart';
import 'package:alquran/app/data/models/surah.dart';
import 'package:alquran/app/data/models/detailSurah.dart' as detailJuz;
import 'package:alquran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    if (Get.isDarkMode) {
      controller.isDark.value = true;
    }
    return Scaffold(
      appBar: AppBar(
        // elevation: Get.isDarkMode ? 0 : 4,
        title: Text("Al-Qur'an Apps"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.SEARCH),
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Assalamualaikum",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      appPurpleLight1,
                      appPurpleDark,
                    ],
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () => Get.toNamed(Routes.LAST_READ),
                    child: Container(
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: -50,
                            right: 0,
                            child: Opacity(
                              opacity: 0.7,
                              child: Container(
                                width: 200,
                                height: 200,
                                child: Image.asset(
                                  'assets/images/quran.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.menu_book_rounded,
                                        color: appWhite),
                                    SizedBox(width: 10),
                                    Text(
                                      "Terakhir dibaca",
                                      style: TextStyle(color: appWhite),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "Al-Fatihah",
                                  style: TextStyle(
                                      color: appWhite,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Juz 1 | Ayat 5",
                                  style:
                                      TextStyle(color: appWhite, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              TabBar(
                // indicatorColor: appPurpleDark,
                // labelColor: Get.isDarkMode ? appWhite : appPurpleDark,
                unselectedLabelColor:
                    Get.isDarkMode ? appPurpleLight1 : Colors.grey,
                tabs: [
                  Tab(
                    text: "Surah",
                  ),
                  Tab(
                    text: "Juz",
                  ),
                  Tab(
                    text: "Bookmark",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // SUrah
                    FutureBuilder<List<Surah>>(
                      future: controller.getAllSurah(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text("Tidak ada data"),
                          );
                        }
                        // print(snapshot.data);
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            // ambil data per surah
                            Surah surah = snapshot.data![index];
                            return ListTile(
                              onTap: () {
                                // kirim data menggunakan arguments: surah => yang dikirim model Surah
                                Get.toNamed(Routes.DETAIL_SURAH,
                                    arguments: surah);
                              },
                              leading: Obx(
                                () => Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        controller.isDark.isTrue
                                            ? "assets/images/list_light.png"
                                            : "assets/images/list_dark.png",
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "${surah.number}",
                                    style: TextStyle(
                                        color: Get.isDarkMode
                                            ? appWhite
                                            : appPurpleDark),
                                  )),
                                ),
                              ),
                              title: Text(
                                  "${surah.name?.transliteration?.id ?? 'Error..'}"),
                              subtitle: Text(
                                "${surah.sequence} Ayat | ${surah.revelation?.id ?? 'Error..'}",
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                              trailing: Text(
                                "${surah.name?.short ?? 'Error..'}",
                              ),
                            );
                          },
                        );
                      },
                    ),
                    // Juz
                    FutureBuilder<List<Map<String, dynamic>>>(
                      future: controller.getAllJuz(),
                      builder: ((context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                                color: appPurpleLight2),
                          );
                        }
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text("Tidak ada data"),
                          );
                        }
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            // kirim data argument dataMapPerJuz untuk ditangkap ke page detail_juz
                            Map<String, dynamic> dataMapPerJuz =
                                snapshot.data![index];
                            return ListTile(
                              contentPadding:
                                  EdgeInsets.only(top: 7, bottom: 15),
                              onTap: () {
                                Get.toNamed(Routes.DETAIL_JUZ,
                                    arguments: dataMapPerJuz);
                              },
                              leading: Obx(
                                () => Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        controller.isDark.isTrue
                                            ? "assets/images/list_light.png"
                                            : "assets/images/list_dark.png",
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${index + 1}",
                                      style: TextStyle(
                                        color: Get.isDarkMode
                                            ? appWhite
                                            : appPurpleDark,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // isThreeLine: true,
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Mulai dari surah ",
                                        style:
                                            TextStyle(color: Colors.grey[500]),
                                      ),
                                      Text(
                                        "${(dataMapPerJuz['start']['surah'] as detailJuz.DetailSurah).name?.transliteration?.id} ayat ${(dataMapPerJuz['start']['ayat'] as detailJuz.Verse).number?.inSurah}",
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "hingga surah",
                                        style:
                                            TextStyle(color: Colors.grey[500]),
                                      ),
                                      Text(
                                        "${(dataMapPerJuz['end']['surah'] as detailJuz.DetailSurah).name?.transliteration?.id} ayat ${(dataMapPerJuz['end']['ayat'] as detailJuz.Verse).number?.inSurah}",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }),
                    ),
                    // Bookmark
                    Center(
                      child: Text("Data 3"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.changeThemeMode(),
        child: Obx(
          () => Icon(
            Icons.color_lens,
            color: controller.isDark.isTrue ? appPurpleDark : appWhite,
          ),
        ),
      ),
    );
  }
}
