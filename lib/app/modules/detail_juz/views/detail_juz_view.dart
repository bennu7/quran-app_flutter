import 'package:alquran/app/constant/color.dart';
import 'package:alquran/app/data/models/detailSurah.dart' as detail;
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  final Map<String, dynamic> dataMapPerJuz = Get.arguments;
  @override
  Widget build(BuildContext context) {
    print(dataMapPerJuz);
    return Scaffold(
      appBar: AppBar(
        title: Text('Juz ${dataMapPerJuz["juz"]}'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: (dataMapPerJuz["verses"] as List).length,
        itemBuilder: (context, index) {
          if ((dataMapPerJuz["verses"] as List).length == 0) {
            return Center(
              child: Text("Tidak ada data"),
            );
          }

          Map<String, dynamic> ayat = dataMapPerJuz["verses"][index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if ((ayat["ayat"] as detail.Verse).number?.inSurah == 1)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      // onTap: () => Get.dialog(
                      //   Dialog(
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(20)),
                      //     child: Container(
                      //       padding: EdgeInsets.all(25),
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(20),
                      //         color: Get.isDarkMode
                      //             ? appPurpleLight1.withOpacity(0.3)
                      //             : appWhite,
                      //       ),
                      //       child: Column(
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: [
                      //           Text(
                      //             "TAFSIR ${surah.name?.transliteration?.id}",
                      //             style: TextStyle(
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 20),
                      //           ),
                      //           SizedBox(height: 20),
                      //           Text(
                      //             "${surah.tafsir?.id ?? 'Tidak ada data pada tafsir ini'}",
                      //             style: TextStyle(),
                      //             textAlign: TextAlign.justify,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              colors: [appPurpleLight1, appPurpleDark]),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            '${ayat["surah"]}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: appWhite,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              Container(
                decoration: BoxDecoration(
                  color: appPurpleLight1.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                // color: Colors.grey[100],
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
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
                              child: Text(
                                  "${(ayat['ayat'] as detail.Verse).number?.inSurah}"),
                            ),
                          ),
                          Text(
                            "${ayat['surah']}",
                            style: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 15),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.bookmark_add_outlined)),
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.play_arrow))
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
                  "${(ayat['ayat'] as detail.Verse).text?.arab}",
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "${(ayat['ayat'] as detail.Verse).text?.transliteration?.en}",
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                textAlign: TextAlign.right,
              ),
              SizedBox(height: 20),
              Text(
                "${(ayat['ayat'] as detail.Verse).translation?.id}",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 30),
            ],
          );
        },
      ),
    );
  }
}
