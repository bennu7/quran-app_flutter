import 'dart:ui';

import 'package:alquran/app/constant/color.dart';
import 'package:alquran/app/data/models/surah.dart';
import 'package:alquran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
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
                indicatorColor: appPurpleDark,
                labelColor: Get.isDarkMode ? appWhite : appPurpleDark,
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
                              leading: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(Get.isDarkMode
                                          ? "assets/images/list_light.png"
                                          : "assets/images/list_dark.png")),
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
                              title: Text(
                                  "${surah.name?.transliteration?.id ?? 'Error..'}"),
                              subtitle: Text(
                                  "${surah.sequence} Ayat | ${surah.revelation?.id ?? 'Error..'}"),
                              trailing: Text(
                                "${surah.name?.short ?? 'Error..'}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Get.isDarkMode
                                      ? appWhite
                                      : appPurpleLight1,
                                  fontSize: 18,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    // Juz
                    ListView.builder(
                      itemCount: 30,
                      itemBuilder: ((context, index) {
                        return ListTile(
                          onTap: () {
                            //
                          },
                          leading: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(Get.isDarkMode
                                      ? "assets/images/list_light.png"
                                      : "assets/images/list_dark.png")),
                            ),
                            child: Center(
                                child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                  color: Get.isDarkMode
                                      ? appWhite
                                      : appPurpleDark),
                            )),
                          ),
                          title: Text("Juz ${index + 1}"),
                        );
                      }),
                    ),
                    // Bookmark
                    Center(
                      child: Text("data 3"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.changeTheme(themeDark);
          print(" ${Get.isDarkMode}");
        },
        child: Icon(
          Icons.color_lens,
          color: Get.isDarkMode ? appPurpleDark : appWhite,
        ),
      ),
    );
  }
}
