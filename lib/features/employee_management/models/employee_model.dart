import 'package:hrm_aqtech/utils/constants/enums.dart';

class Employee {
  int id;
  String tfsName;
  String fullName;
  String email;
  String phone;
  String avatar;
  DateTime birthDate;
  DateTime startDate;
  String nickName;
  EmployeeRole role; // Ensure you handle parsing the role properly
  bool isLeader;
  bool isLunchStatus;
  List<DetailLunch> detailLunch;
  int workingYear;
  DetailWFHQuota detailWFHQuota;
  DetailAbsenceQuota detailAbsenceQuota;
  bool isActive;
  String maSoCCCD;
  String address;
  DetailContract detailContract;

  Employee({
    this.id = 0,
    this.tfsName = "",
    this.fullName = "",
    this.email = "",
    this.phone = "",
    this.avatar = "",
    DateTime? birthDate,
    DateTime? startDate,
    this.nickName = "",
    this.role = EmployeeRole.Developer,
    this.isLeader = false,
    this.isLunchStatus = false,
    this.detailLunch = const [],
    this.workingYear = 0,
    DetailWFHQuota? detailWFHQuota,
    DetailAbsenceQuota? detailAbsenceQuota,
    this.isActive = true,
    this.maSoCCCD = "",
    this.address = "",
    DetailContract? detailContract,
  })  : birthDate = birthDate ?? DateTime.now(),
        startDate = startDate ?? DateTime.now(),
        detailWFHQuota = detailWFHQuota ?? DetailWFHQuota(),
        detailAbsenceQuota = detailAbsenceQuota ?? DetailAbsenceQuota(),
        detailContract = detailContract ?? DetailContract();

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      tfsName: json['tfsName'] ?? "",
      fullName: json['fullName'] ?? "",
      email: json['email'] ?? "",
      phone: json['phone'] ?? "",
      avatar: json['avatar'] ?? "",
      birthDate: DateTime.parse(json['birthDate']),
      startDate: DateTime.parse(json['startDate']),
      nickName: json['nickName'] ?? "",
      role: EmployeeRole.values[int.parse(json['role']) - 1],
      isLeader: json['isLeader'] ?? false,
      isLunchStatus: json['isLunchStatus'] ?? false,
      detailLunch: (json['detailLunch'] as List)
          .map((item) => DetailLunch.fromJson(item))
          .toList(),
      workingYear: json['workingYear'] ?? 0,
      detailWFHQuota: DetailWFHQuota.fromJson(json['detailWFHQuota']),
      detailAbsenceQuota:
          DetailAbsenceQuota.fromJson(json['detailAbsenceQuota']),
      isActive: json['isActive'] ?? true,
      maSoCCCD: json['maSoCCCD'] ?? "",
      address: json['address'] ?? "",
      detailContract: DetailContract.fromJson(json['detailContract']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tfsName': tfsName,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'birthDate': birthDate.toIso8601String(),
      'startDate': startDate.toIso8601String(),
      'nickName': nickName,
      'role': (role.index + 1).toString(),
      'isLeader': isLeader,
      'isLunchStatus': isLunchStatus,
      'detailLunch': detailLunch.map((item) => item.toJson()).toList(),
      'workingYear': workingYear,
      'detailWFHQuota': detailWFHQuota.toJson(),
      'detailAbsenceQuota': detailAbsenceQuota.toJson(),
      'isActive': isActive,
      'maSoCCCD': maSoCCCD,
      'address': address,
      'detailContract': detailContract.toJson(),
    };
  }
}

class DetailLunch {
  int year;
  List<LunchByMonth> lunchByMonth;

  DetailLunch({
    this.year = 0,
    this.lunchByMonth = const [],
  });

  factory DetailLunch.fromJson(Map<String, dynamic> json) {
    return DetailLunch(
      year: json['year'] ?? 0,
      lunchByMonth: (json['lunchByMonth'] as List)
          .map((item) => LunchByMonth.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'lunchByMonth': lunchByMonth.map((item) => item.toJson()).toList(),
    };
  }
}

class LunchByMonth {
  int month;
  bool isLunch;
  int lunchFee;
  String note;

  LunchByMonth({
    this.month = 0,
    this.isLunch = false,
    this.lunchFee = 0,
    this.note = "",
  });

  factory LunchByMonth.fromJson(Map<String, dynamic> json) {
    return LunchByMonth(
      month: json['month'] ?? 0,
      isLunch: json['isLunch'] ?? false,
      lunchFee: json['lunchFee'] ?? 0,
      note: json['note'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'isLunch': isLunch,
      'lunchFee': lunchFee,
      'note': note,
    };
  }
}

class DetailWFHQuota {
  int minWFHQuota;
  List<ActualWFHQuota> actualWFHQuotaByYear;

  DetailWFHQuota({
    this.minWFHQuota = 0,
    this.actualWFHQuotaByYear = const [],
  });

  factory DetailWFHQuota.fromJson(Map<String, dynamic> json) {
    return DetailWFHQuota(
      minWFHQuota: json['minWFHQuota'] ?? 0,
      actualWFHQuotaByYear: (json['actualWFHQuotaByYear'] as List)
          .map((item) => ActualWFHQuota.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'minWFHQuota': minWFHQuota,
      'actualWFHQuotaByYear':
          actualWFHQuotaByYear.map((item) => item.toJson()).toList(),
    };
  }
}

class ActualWFHQuota {
  int year;
  int wfhQuota;

  ActualWFHQuota({
    this.year = 0,
    this.wfhQuota = 0,
  });

  factory ActualWFHQuota.fromJson(Map<String, dynamic> json) {
    return ActualWFHQuota(
      year: json['year'] ?? 0,
      wfhQuota: json['wfhQuota'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'wfhQuota': wfhQuota,
    };
  }
}

class DetailAbsenceQuota {
  int minAbsenceQuota;
  List<ActualAbsenceQuota> actualAbsenceQuotaByYear;

  DetailAbsenceQuota({
    this.minAbsenceQuota = 0,
    this.actualAbsenceQuotaByYear = const [],
  });

  factory DetailAbsenceQuota.fromJson(Map<String, dynamic> json) {
    return DetailAbsenceQuota(
      minAbsenceQuota: json['minAbsenceQuota'] ?? 0,
      actualAbsenceQuotaByYear: (json['actualAbsenceQuotaByYear'] as List)
          .map((item) => ActualAbsenceQuota.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'minAbsenceQuota': minAbsenceQuota,
      'actualAbsenceQuotaByYear':
          actualAbsenceQuotaByYear.map((item) => item.toJson()).toList(),
    };
  }
}

class ActualAbsenceQuota {
  int year;
  int absenceQuota;

  ActualAbsenceQuota({
    this.year = 0,
    this.absenceQuota = 0,
  });

  factory ActualAbsenceQuota.fromJson(Map<String, dynamic> json) {
    return ActualAbsenceQuota(
      year: json['year'] ?? 0,
      absenceQuota: json['absenceQuota'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'absenceQuota': absenceQuota,
    };
  }
}

class DetailContract {
  DateTime contractStartDate;
  DateTime contractExpireDate;
  int contractDuration;
  String contractType;

  DetailContract({
    DateTime? contractStartDate,
    DateTime? contractExpireDate,
    this.contractDuration = 0,
    this.contractType = "",
  })  : contractStartDate = contractStartDate ?? DateTime.now(),
        contractExpireDate = contractExpireDate ?? DateTime.now();

  factory DetailContract.fromJson(Map<String, dynamic> json) {
    return DetailContract(
      contractStartDate: DateTime.parse(json['contractStartDate']),
      contractExpireDate: DateTime.parse(json['contractExpireDate']),
      contractDuration: json['contractDuration'] ?? 0,
      contractType: json['contractType'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contractStartDate': contractStartDate.toIso8601String(),
      'contractExpireDate': contractExpireDate.toIso8601String(),
      'contractDuration': contractDuration,
      'contractType': contractType,
    };
  }
}
