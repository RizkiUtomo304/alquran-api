import 'dart:convert';
import 'package:http/http.dart';
import 'surah_model.dart';

class HttpService {
  final String baseUrl = "https://quran-api.santrikoding.com/api";

  Future<List<Surah>> getSurahs() async {
    Response res = await get(Uri.parse("$baseUrl/surah"));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body.map((e) => Surah.fromJson(e)).toList();
    } else {
      throw Exception("Gagal mengambil data Surah.");
    }
  }

  Future<Surah> getAyatBySurah(int nomorSurah) async {
    Response res = await get(Uri.parse("$baseUrl/surah/$nomorSurah"));

    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      return Surah.fromJson(body);
    } else {
      throw Exception("Gagal mengambil data Ayat untuk Surah $nomorSurah.");
    }
  }
}