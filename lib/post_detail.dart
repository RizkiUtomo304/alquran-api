import 'package:flutter/material.dart';
import 'http_service.dart';
import 'surah_model.dart';
import 'package:html/parser.dart' as html_parser;

class DetailPage extends StatefulWidget {
  final Surah surah;

  const DetailPage({super.key, required this.surah});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<Surah> futureSurah;
  final HttpService httpService = HttpService();

  @override
  void initState() {
    super.initState();
    futureSurah = httpService.getAyatBySurah(widget.surah.nomor);
  }

  String _removeHtmlTags(String htmlString) {
    var document = html_parser.parse(htmlString);
    return document.body?.text ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.surah.namaLatin,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal[800], // Warna teal elegan
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.teal[800]!, // Warna teal gelap
              Colors.teal[100]!, // Warna teal pastel
            ],
          ),
        ),
        child: FutureBuilder<Surah>(
          future: futureSurah,
          builder: (BuildContext context, AsyncSnapshot<Surah> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else if (snapshot.hasData) {
              Surah surah = snapshot.data!;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Surah Info Card
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 10,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.teal[800]!.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.teal[800],
                                  ),
                                  child: Center(
                                    child: Text(
                                      surah.nomor.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        surah.nama,
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.teal[800],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        surah.arti,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.teal[800]!.withOpacity(0.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            _buildInfoRow(Icons.location_on, "Tempat Turun", surah.tempatTurun),
                            _buildInfoRow(Icons.format_list_numbered, "Jumlah Ayat", "${surah.jumlahAyat} ayat"),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Ayat List
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: surah.ayat.length,
                        itemBuilder: (context, index) {
                          final ayat = surah.ayat[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                ),
                              ],
                              border: Border.all(
                                color: Colors.teal[800]!.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.teal[800],
                                        ),
                                        child: Center(
                                          child: Text(
                                            ayat.nomor.toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Text(
                                          ayat.ar,
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                            fontSize: 24,
                                            height: 1.8,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(height: 30),
                                  Text(
                                    _removeHtmlTags(ayat.tr),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.teal[800]!.withOpacity(0.7),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    ayat.idn,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Error: ${snapshot.error}",
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.teal[800],
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            "$label: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.teal[800],
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Colors.teal[800]!.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}