import 'package:pm_tugas_03_4243250005/khs.dart';
import 'package:test/test.dart';

void main() {
  group('bobot', () {
    test('maps letter grades to grade points', () {
      expect(bobot('A'), 4);
      expect(bobot('b'), 3);
      expect(bobot('E'), 0);
    });

    test('rejects unknown letter grades', () {
      expect(() => bobot('F'), throwsFormatException);
    });
  });

  group('validasiMataKuliah', () {
    test('trims and normalizes valid course data', () {
      final mk = validasiMataKuliah(' Pemrograman ', '3', 'a');

      expect(mk.nama, 'Pemrograman');
      expect(mk.sks, 3);
      expect(mk.nilaiHuruf, 'A');
    });

    test('rejects credits outside 1 through 6 or non-numeric credits', () {
      expect(
        () => validasiMataKuliah('Statistika', 'tiga', 'B'),
        throwsFormatException,
      );
      expect(
        () => validasiMataKuliah('Statistika', '7', 'B'),
        throwsFormatException,
      );
    });

    test('rejects invalid grades', () {
      expect(
        () => validasiMataKuliah('Statistika', '2', 'F'),
        throwsFormatException,
      );
    });
  });

  group('hitungIp', () {
    test('calculates credit-weighted GPA and handles empty data', () {
      final data = [
        validasiMataKuliah('Pemrograman', '3', 'A'),
        validasiMataKuliah('Statistika', '2', 'B'),
      ];

      expect(hitungIp(data), 3.6);
      expect(hitungIp([]), 0);
    });
  });

  group('predikat', () {
    test('uses the rubric sample classification for IP 3.00', () {
      expect(predikat(3.0), 'Memuaskan');
    });
  });

  group('cetakKhs', () {
    test('sorts by grade descending and lists courses below two credits', () {
      final data = [
        validasiMataKuliah('Statistika', '2', 'B'),
        validasiMataKuliah('Etika Profesi', '1', 'A'),
        validasiMataKuliah('Pemrograman', '3', 'A'),
      ];

      final output = cetakKhs(data, urutkan: true);

      expect(
        output.indexOf('Etika Profesi'),
        lessThan(output.indexOf('Pemrograman')),
      );
      expect(
        output.indexOf('Pemrograman'),
        lessThan(output.indexOf('Statistika')),
      );
      expect(output, contains('Perlu diperbaiki (SKS < 2):'));
      expect(output, contains('- Etika Profesi'));
    });
  });
}
