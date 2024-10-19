class AbsenceQuota {
  int memberId;
  int year;
  int absenceQuota;
  int totalDayOff;
  int totalDayOffWithPermission;
  int totalDayOffWithoutPermission;
  int absenceQuotaAvailable;

  AbsenceQuota({
    this.memberId = 0,
    this.year = 0,
    this.absenceQuota = 0,
    this.totalDayOff = 0,
    this.totalDayOffWithPermission = 0,
    this.totalDayOffWithoutPermission = 0,
    this.absenceQuotaAvailable = 0,
  });

  // Factory method to create an AbsenceQuota object from JSON data
  factory AbsenceQuota.fromJson(Map<String, dynamic> json) {
    return AbsenceQuota(
      memberId: json['memberId'],
      year: json['year'],
      absenceQuota: json['absenceQuota'],
      totalDayOff: json['totalDayOff'],
      totalDayOffWithPermission: json['totalDayOff_with_permission'],
      totalDayOffWithoutPermission: json['totalDayOff_without_permission'],
      absenceQuotaAvailable: json['absenceQuota_available'],
    );
  }

  // Method to convert an AbsenceQuota object to JSON
  Map<String, dynamic> toJson() {
    return {
      'memberId': memberId,
      'year': year,
      'absenceQuota': absenceQuota,
      'totalDayOff': totalDayOff,
      'totalDayOff_with_permission': totalDayOffWithPermission,
      'totalDayOff_without_permission': totalDayOffWithoutPermission,
      'absenceQuota_available': absenceQuotaAvailable,
    };
  }
}
