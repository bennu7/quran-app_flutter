import 'package:alquran/app/constant/color.dart';
import 'package:alquran/app/data/models/juz.dart';
import 'package:alquran/app/data/models/surah.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  final Juz detailJuz = Get.arguments["juz"];
  final List<Surah> allSurahInThisJuz = Get.arguments["surah"];
  @override
  Widget build(BuildContext context) {
    allSurahInThisJuz.forEach((element) {
      print(element.name!.transliteration!.id);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Juz ${detailJuz.juz}'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: detailJuz.verses?.length ?? 0,
        itemBuilder: (context, index) {
          if (detailJuz.verses == null || detailJuz.verses?.length == 0) {
            return Center(
              child: Text("Tidak ada data"),
            );
          }
          Verses ayat = detailJuz.verses![index];
          // untuk mengkondisikan masuk ke surah apa
          print(index);
          if (index != 0) {
            // jika tidak bertemu surah dengan index ke 0, maka pindah nama surah
            if (ayat.number?.inSurah == 1) {
              controller.index++;
            }
          }
          print('after if cek : ${index}');

          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
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
                              child: Text("${ayat.number?.inSurah}"),
                            ),
                          ),
                          Text(
                            "${allSurahInThisJuz[controller.index].name?.transliteration?.id ?? ''}",
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
                  "${ayat.text?.arab}",
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "${ayat.text?.transliteration?.en}",
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
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
      ),
    );
  }
}
