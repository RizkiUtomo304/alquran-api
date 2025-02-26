import 'package:flutter/material.dart';
import 'post_detail.dart';
import 'http_service.dart';
import 'surah_model.dart';

class PostsPage extends StatelessWidget {
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Al-Qur'an",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal[800], // Warna teal yang elegan
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
        child: FutureBuilder<List<Surah>>(
          future: httpService.getSurahs(),
          builder: (BuildContext context, AsyncSnapshot<List<Surah>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else if (snapshot.hasData) {
              final List<Surah> surahs = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: surahs.length,
                itemBuilder: (BuildContext context, int index) {
                  final Surah surah = surahs[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(20),
                      shadowColor: Colors.teal[800]!.withOpacity(0.3),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(surah: surah),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(0.9), // Warna putih transparan
                            border: Border.all(
                              color: Colors.teal[800]!.withOpacity(0.2), // Border elegan
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.teal[800]!.withOpacity(0.1), // Warna teal transparan
                                  border: Border.all(
                                    color: Colors.teal[800]!.withOpacity(0.3), // Border elegan
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    surah.nomor.toString(),
                                    style: TextStyle(
                                      color: Colors.teal[800], // Warna teal gelap
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          surah.namaLatin,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.teal[800], // Warna teal gelap
                                          ),
                                        ),
                                        Text(
                                          surah.nama,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.teal[800]!.withOpacity(0.8), // Warna teal transparan
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${surah.jumlahAyat} Ayat',
                                      style: TextStyle(
                                        color: Colors.teal[800]!.withOpacity(0.6), // Warna teal transparan
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.teal[800]!.withOpacity(0.8), // Warna teal transparan
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
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
                      'Error: ${snapshot.error}',
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
            return const Center(
              child: Text(
                "No data available",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}