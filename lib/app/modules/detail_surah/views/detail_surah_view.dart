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
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    '${surah.name?.transliteration?.id?.toUpperCase() ?? "Error.."}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '( ${surah.name?.translation?.id?.toUpperCase() ?? "Error.."} )',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${surah.numberOfVerses ?? "Error.."} Ayat | ${surah.revelation?.id}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
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
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  child: Text('${index + 1}'),
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
                        Text(
                          "${ayat!.text?.arab}",
                          style: TextStyle(fontSize: 25),
                          textAlign: TextAlign.right,
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
