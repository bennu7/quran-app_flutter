import 'dart:convert';

import 'package:alquran/app/data/models/detailSurah.dart';
import 'package:http/http.dart' as http;

void main() async {
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
            "surah": dataSurah.name?.transliteration?.id ?? '',
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
          // print("${juz}");
          // print("----------");
          // print("${penampungAyat}");
          // print("==========");
          // agar melakukan looping untuk mendapatkan data di semua juz
          juz++;
          // penampungAyat.clear();
          penampungAyat = [];
          penampungAyat.add({
            "surah": dataSurah.name?.transliteration?.id ?? '',
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

  print(allJuz[28]['verses']);
}
