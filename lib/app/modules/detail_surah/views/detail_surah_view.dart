import 'package:alquran/app/constant/color.dart';
import 'package:alquran/app/data/models/detailSurah.dart' as detail;
import 'package:alquran/app/data/models/surah.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  @override
  Widget build(BuildContext context) {
    // nangkap data dengan menggunakan arguments yang sudah dikirim dari home view controller nya on Tap
    final Surah surah = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${surah.name?.transliteration?.id?.toUpperCase() ?? "Error.."}',
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          GestureDetector(
            onTap: () => Get.dialog(Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Get.isDarkMode
                      ? appPurpleLight1.withOpacity(0.3)
                      : appWhite,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "TAFSIR ${surah.name?.transliteration?.id}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "${surah.tafsir?.id ?? 'Tidak ada data pada tafsir ini'}",
                      style: TextStyle(),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            )),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient:
                    LinearGradient(colors: [appPurpleLight1, appPurpleDark]),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      '${surah.name?.transliteration?.id?.toUpperCase() ?? "Error.."}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: appWhite),
                    ),
                    Text(
                      '( ${surah.name?.translation?.id?.toUpperCase() ?? "Error.."} )',
                      style: TextStyle(fontSize: 16, color: appWhite),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${surah.numberOfVerses ?? "Error.."} Ayat | ${surah.revelation?.id}',
                      style: TextStyle(fontSize: 16, color: appWhite),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          FutureBuilder<detail.DetailSurah>(
              future: controller.getDetailSurah(surah.number.toString()),
              builder: (context, snapshot) {
                // print(snapshot.hasData);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData) {
                  // tidak ada data dari status code, bukan tidak ada surah/ayatnya
                  return Center(child: Text("Tidak ada data"));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  // ambil jumlah yang mau di for dalam itemCount
                  itemCount: snapshot.data?.verses?.length,
                  itemBuilder: (context, index) {
                    // memeriksa apakah ada ayat
                    if (snapshot.data?.verses?.length == 0) {
                      return SizedBox();
                    }
                    detail.Verse? ayat = snapshot.data?.verses?[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: appPurpleLight2.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // color: Colors.grey[100],
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(Get.isDarkMode
                                          ? "assets/images/list_light.png"
                                          : "assets/images/list_dark.png"),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text("${index + 1}"),
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon:
                                            Icon(Icons.bookmark_add_outlined)),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.play_arrow))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Text(
                            "${ayat!.text?.arab}",
                            style: TextStyle(fontSize: 25),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "${ayat.text?.transliteration?.en}",
                          style: TextStyle(
                              fontSize: 18, fontStyle: FontStyle.italic),
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "${ayat.translation?.id}",
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 30),
                      ],
                    );
                  },
                );
              })
        ],
      ),
    );
  }
}
