import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:alquran/app/data/models/detailSurah.dart';

import '../../../data/models/surah.dart';

class HomeController extends GetxController {
  List<Surah> allSurah = [];

  RxBool isDark = false.obs;
  Future<List<Surah>> getAllSurah() async {
    Uri url = Uri.parse("https://api.quran.sutanlab.id/surah");
    var res = await http.get(url);

    List? data = (json.decode(res.body) as Map<String, dynamic>)["data"];

    if (data == null || data.isEmpty) {
      return [];
    } else {
      allSurah = data.map((e) => Surah.fromJson(e)).toList();
      return allSurah;
    }
  }

  // custom List<Map<String, dynamic>>
  Future<List<Map<String, dynamic>>> getAllJuz() async {
    int juz = 1;
    // sebagai penampung array kosong untuk tiap ayat
    List<Map<String, dynamic>> penampungAyat = [];
    // sebagai penampung List dari tiap object Verses
    List<Map<String, dynamic>> allJuz = [];

    for (var i = 1; i <= 114; i++) {
      var res =
          await http.get(Uri.parse("https://api.quran.sutanlab.id/surah/${i}"));

      Map<String, dynamic> rawData = json.decode(res.body)["data"];

      //dataSurah ini akan bertipe List, jadi mapping lagi menggunakan forEach
      DetailSurah dataSurah = DetailSurah.fromJson(rawData);

      // karena ada kemungkinan null data
      if (dataSurah.verses != null) {
        dataSurah.verses!.forEach((ayat) {
          if (ayat.meta!.juz == juz) {
            penampungAyat.add({
              "surah": dataSurah,
              "ayat": ayat,
            });
          } else {
            // juz nya bertambah
            allJuz.add({
              "juz": juz,
              // "surah": dataSurah.name?.transliteration?.id ?? '',
              "start": penampungAyat[0],
              "end": penampungAyat[penampungAyat.length - 1],
              "verses": penampungAyat,
            });
            // agar melakukan looping untuk mendapatkan data di semua juz
            juz++;
            penampungAyat = [];
            penampungAyat.add({
              "surah": dataSurah,
              "ayat": ayat,
            });
          }
        });
      }
    }

// untuk mendapatkan juz terakhir/juz 3
    allJuz.add({
      "juz": juz,
      // "surah": dataSurah.name?.transliteration?.id ?? '',
      "start": penampungAyat[0],
      "end": penampungAyat[penampungAyat.length - 1],
      "verses": penampungAyat,
    });

    return allJuz;

    //tidak jadi dipakai karena kesalahan pada tiap juz di database
    // Future<List<Juz>> getAllJuz() async {
    //   // sebagai wadah untuk tiap juz
    //   List<Juz> allJuz = [];

    //   for (int i = 1; i <= 30; i++) {
    //     Uri url = Uri.parse("https://api.quran.sutanlab.id/juz/$i");
    //     var res = await http.get(url);

    //     Map<String, dynamic> data =
    //         (json.decode(res.body) as Map<String, dynamic>)["data"];

    //     Juz juz = Juz.fromJson(data);
    //     allJuz.add(juz);
    //   }

    //   return allJuz;
  }
}
