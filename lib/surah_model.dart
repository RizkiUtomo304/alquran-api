import 'post.dart';

class Surah {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;
  final String tempatTurun;
  final String arti;
  final List<Ayat> ayat; // List Ayat

  Surah({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.ayat,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      nomor: json['nomor'] ?? 0,
      nama: json['nama'] ?? '',
      namaLatin: json['nama_latin'] ?? '',
      jumlahAyat: json['jumlah_ayat'] ?? 0,
      tempatTurun: json['tempat_turun'] ?? '',
      arti: json['arti'] ?? '',
      ayat: json['ayat'] != null
          ? (json['ayat'] as List).map((e) => Ayat.fromJson(e)).toList()
          : [], 
    );
  }
}

class Ayat {
  final int id;
  final int surah;
  final int nomor;
  final String ar;
  final String tr;
  final String idn;

  Ayat({
    required this.id,
    required this.surah,
    required this.nomor,
    required this.ar,
    required this.tr,
    required this.idn,
  });

  factory Ayat.fromJson(Map<String, dynamic> json) {
    return Ayat(
      id: json['id'] ?? 0,
      surah: json['surah'] ?? 0,
      nomor: json['nomor'] ?? 0,
      ar: json['ar'] ?? '',
      tr: json['tr'] ?? '',
      idn: json['idn'] ?? '',
    );
  }
}