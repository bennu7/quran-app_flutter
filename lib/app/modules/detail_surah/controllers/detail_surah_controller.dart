import 'package:alquran/app/data/models/detailSurah.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

class DetailSurahController extends GetxController {
  // untuk audio player lebih baik diletakkan di luar function playAudio() kareana jika dimasukkan akan menyenabkan audio  menumpuk ketika double click
  final player = AudioPlayer();

  Future<DetailSurah> getDetailSurah(String id) async {
    Uri url = Uri.parse("https://api.quran.sutanlab.id/surah/${id}");
    var res = await http.get(url);

    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];

    return DetailSurah.fromJson(data);
  }

  void playAudio(String url) async {
    if (url != null) {
      print(url);
      // proses
      try {
        await player.setUrl(url);
        await player.play();
      } on PlayerException catch (e) {
        Get.defaultDialog(
          title: "Terjadi kesalahan",
          middleText: "Error message: ${e.message}",
        );
      } on PlayerInterruptedException catch (e) {
        Get.defaultDialog(
          title: "Terjadi kesalahan",
          middleText: "Connection aborted: ${e.message}",
        );
      } catch (e) {
        print(e);
        Get.defaultDialog(
          title: "Terjadi kesalahan",
          textCustom: 'Tidak dapat memutar Audio',
          middleText: e.toString(),
        );
      }
    } else {
      Get.defaultDialog(
        title: "Terjadi kesalahan",
        middleText: "URL Audio tidak ada/tidak dapat diakses",
      );
    }
  }

// perlu onClose untuk stop audio ketika keluar dari page surah
  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }
}
