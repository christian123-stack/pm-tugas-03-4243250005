import 'dart:io';

import 'package:pm_tugas_03_4243250005/khs.dart';

void main() {
  final data = <MataKuliah>[];
  stdout.writeln('Masukkan data mata kuliah. Kosongkan nama untuk selesai.');

  while (true) {
    stdout.write('\nNama MK: ');
    final nama = stdin.readLineSync();
    if (nama == null || nama.trim().isEmpty) {
      break;
    }

    stdout.write('SKS: ');
    final sks = stdin.readLineSync();
    if (sks == null) {
      break;
    }

    stdout.write('Nilai huruf: ');
    final nilaiHuruf = stdin.readLineSync();
    if (nilaiHuruf == null) {
      break;
    }

    try {
      final mk = validasiMataKuliah(nama, sks, nilaiHuruf);
      data.add(mk);
      stdout.writeln('Data diterima.');
    } on FormatException catch (error) {
      stdout.writeln('Data diabaikan: ${error.message}');
    }
  }

  stdout.writeln();
  stdout.write(cetakKhs(data, urutkan: true));
}
