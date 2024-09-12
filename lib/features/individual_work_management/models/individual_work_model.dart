class IndividualWork {
  List<double> soGioLamViecTrongTuan;
  List<int> soLuongCaseThucHienTrongTuan;
  List<int> soLuotCaseBiMoLai;
  List<double> soGioUocLuongCase;
  List<double> soGioThucTeLamCase; // Changed to double to handle float values
  List<double> soGioThamGiaMeeting;
  List<double> phanTramTiLeMoCase;
  List<double> phanTramTiLeChenhLechUocLuongVaThucTe;
  List<double> soGioLamThieu;

  IndividualWork({
    required this.soGioLamViecTrongTuan,
    required this.soLuongCaseThucHienTrongTuan,
    required this.soLuotCaseBiMoLai,
    required this.soGioUocLuongCase,
    required this.soGioThucTeLamCase,
    required this.soGioThamGiaMeeting,
    required this.phanTramTiLeMoCase,
    required this.phanTramTiLeChenhLechUocLuongVaThucTe,
    required this.soGioLamThieu,
  });

  factory IndividualWork.fromJson(Map<String, dynamic> json) {
    try {
      return IndividualWork(
        soGioLamViecTrongTuan: List<double>.from(
            json['soGioLamViecTrongNgay'].map((x) => x.toDouble())),
        soLuongCaseThucHienTrongTuan:
            List<int>.from(json['soLuongCaseThucHienTrongTuan']),
        soLuotCaseBiMoLai: List<int>.from(json['soLuotCaseBiMoLai']),
        soGioUocLuongCase: List<double>.from(
            json['soGioUocLuongCase'].map((x) => x.toDouble())),
        soGioThucTeLamCase: List<double>.from(json['soGioThucTeLamCase']
            .map((x) => x.toDouble())), // Explicit conversion to double
        soGioThamGiaMeeting: List<double>.from(
            json['soGioThamGiaMeeting'].map((x) => x.toDouble())),
        phanTramTiLeMoCase: List<double>.from(json['phanTramTiLeMoCase']
            .map((x) => x.toDouble())), // Explicit conversion to double
        phanTramTiLeChenhLechUocLuongVaThucTe: List<double>.from(
            json['phanTramTiLeChenhLechUocLuongVaThucTe']
                .map((x) => x.toDouble())), // Explicit conversion to double
        soGioLamThieu:
            List<double>.from(json['soGioLamThieu'].map((x) => x.toDouble())),
      );
    } catch (e) {
      throw Exception('Failed to parse IndividualWork: $e');
    }
  }
}
