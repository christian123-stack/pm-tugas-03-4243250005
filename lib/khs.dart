class MataKuliah {
  const MataKuliah({
    required this.nama,
    required this.sks,
    required this.nilaiHuruf,
  });

  final String nama;
  final int sks;
  final String nilaiHuruf;
}

double bobot(String nilaiHuruf) {
  return switch (nilaiHuruf.trim().toUpperCase()) {
    'A' => 4,
    'B' => 3,
    'C' => 2,
    'D' => 1,
    'E' => 0,
    _ => throw FormatException(
        'Nilai huruf harus salah satu dari A, B, C, D, atau E.',
      ),
  };
}

MataKuliah validasiMataKuliah(
  String nama,
  String inputSks,
  String inputNilai,
) {
  final namaBersih = nama.trim();
  if (namaBersih.isEmpty) {
    throw const FormatException('Nama mata kuliah tidak boleh kosong.');
  }

  final sks = int.tryParse(inputSks.trim());
  if (sks == null || sks < 1 || sks > 6) {
    throw const FormatException('SKS harus berupa angka 1 sampai 6.');
  }

  final nilaiHuruf = inputNilai.trim().toUpperCase();
  bobot(nilaiHuruf);

  return MataKuliah(
    nama: namaBersih,
    sks: sks,
    nilaiHuruf: nilaiHuruf,
  );
}

double hitungIp(List<MataKuliah> data) {
  final totalSks = data.fold<int>(0, (total, mk) => total + mk.sks);
  if (totalSks == 0) {
    return 0;
  }

  final totalBobot = data.fold<double>(
    0,
    (total, mk) => total + mk.sks * bobot(mk.nilaiHuruf),
  );
  return totalBobot / totalSks;
}

String predikat(double ip) {
  if (!ip.isFinite || ip < 0 || ip > 4) {
    throw ArgumentError.value(ip, 'ip', 'IP harus berada pada rentang 0–4.');
  }

  if (ip >= 3.51) {
    return 'Dengan Pujian';
  }
  if (ip >= 3.01) {
    return 'Sangat Memuaskan';
  }
  if (ip >= 2.76) {
    return 'Memuaskan';
  }
  if (ip >= 2) {
    return 'Cukup';
  }
  return 'Perlu Perbaikan';
}

String cetakKhs(List<MataKuliah> data, {bool urutkan = false}) {
  final daftar = List<MataKuliah>.of(data);
  if (urutkan) {
    daftar.sort((a, b) {
      final perbandinganNilai = bobot(b.nilaiHuruf).compareTo(
        bobot(a.nilaiHuruf),
      );
      return perbandinganNilai != 0
          ? perbandinganNilai
          : a.nama.compareTo(b.nama);
    });
  }

  final buffer = StringBuffer()
    ..writeln('KARTU HASIL STUDI')
    ..writeln(
      '${'Mata Kuliah'.padRight(30)}${'SKS'.padLeft(5)}'
      '${'Nilai'.padLeft(8)}${'Bobot'.padLeft(8)}',
    )
    ..writeln('-' * 51);

  for (final mk in daftar) {
    buffer.writeln(
      '${mk.nama.padRight(30)}${mk.sks.toString().padLeft(5)}'
      '${mk.nilaiHuruf.padLeft(8)}${bobot(mk.nilaiHuruf).toStringAsFixed(0).padLeft(8)}',
    );
  }

  final totalSks = data.fold<int>(0, (total, mk) => total + mk.sks);
  final ip = hitungIp(data);
  final perluDiperbaiki = data.where((mk) => mk.sks < 2).toList();

  buffer
    ..writeln('-' * 51)
    ..writeln('Total SKS : $totalSks')
    ..writeln('IP        : ${ip.toStringAsFixed(2)} (${predikat(ip)})')
    ..writeln('Perlu diperbaiki (SKS < 2):');

  if (perluDiperbaiki.isEmpty) {
    buffer.writeln('- Tidak ada');
  } else {
    for (final mk in perluDiperbaiki) {
      buffer.writeln('- ${mk.nama}');
    }
  }

  return buffer.toString();
}
