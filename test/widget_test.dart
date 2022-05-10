import 'dart:convert';
import 'package:alquran/app/data/models/ayat.dart';
import 'package:alquran/app/data/models/detailSurah.dart';
import 'package:alquran/app/data/models/surah.dart';
import 'package:http/http.dart' as http;

void main() async {
  // Uri url = Uri.parse("https://api.quran.sutanlab.id/surah/1/2");
  var res =
      await http.get(Uri.parse("https://api.quran.sutanlab.id/surah/1/2"));

  // print(res.body);

  Map<String, dynamic> data =
      (json.decode(res.body) as Map<String, dynamic>)["data"];

  Ayat ayat = Ayat.fromJson(data);
  print(ayat.translation?.en);

// // ambil data berdasarkan data yang diinginkan, bukan seluruhnya. -> Mengecualikan objek surah
//   Map<String, dynamic> dataToModel = {
//     "number": data["number"],
//     "meta": data["meta"],
//     "text": data["text"],
//     "translation": data["translation"],
//     "audio": data["audio"],
//     "tafsir": data["tafsir"]
//   };
//   // print(dataToModel);
//   // Convert Map -> Model Ayat
//   Ayat ayat = Ayat.fromJson(dataToModel);
//   print(ayat.tafsir?.id?.short);

  // Ayat detailAyat = Ayat.fromJson(data);
  // print(detailAyat.translation?.id);

// // // perlu convert ke objet json
//   // print(res.body);

// // karena hasilnya akan ber tipe dynamic, perlu Mapping
  // List data = (json.decode(res.body) as Map<String, dynamic>)["data"];

// // terdapat 114 surah dan di mulai dari index ke 0
//   // print(data[113]["name"]["translation"]["id"]);

//   // // data dari API (raw data) -> Model (yang sudah disiapkan)
//   Surah surahAnnas = Surah.fromJson(data[113]);
//   // print(surahAnnas.name);
//   // print(surahAnnas.tafsir);
//   // print(surahAnnas.number);

//   // nested model
//   // print(surahAnnas.tafsir?.id);

//   Uri urlAnnass =
//       Uri.parse("https://api.quran.sutanlab.id/surah/${surahAnnas.number}");
//   var resAnnas = await http.get(urlAnnass);
//   // print(resAnnas.body);

//   Map<String, dynamic> dataAnnas =
//       (json.decode(resAnnas.body) as Map<String, dynamic>)["data"];
//   // print(dataAnnas["tafsir"]);

//   // data dari API (raw data) -> Model (yang sudah disiapkan)
//   DetailSurah detailSurahAnnas = DetailSurah.fromJson(dataAnnas);
//   print(detailSurahAnnas.verses![0].text!.arab);

//   // List detailAyatAnnas =
//   // (json.decode(detailSurahAnnas) as Map<String, dynamic>)["verses"];

  // Future<DetailSurah> getDetailSurah(String id) async {
  //   Uri url = Uri.parse("https://api.quran.sutanlab.id/surah/${id}");
  //   var res = await http.get(url);

  //   Map<String, dynamic> data =
  //       (json.decode(res.body) as Map<String, dynamic>)["data"];

  //   DetailSurah result = DetailSurah.fromJson(data);
  //   print(result.preBismillah);

  //   return DetailSurah.fromJson(data);
  // }

  // await getDetailSurah("1");
}
