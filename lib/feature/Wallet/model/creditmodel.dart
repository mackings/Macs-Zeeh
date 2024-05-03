class Score {
  final int totalNoOfDelinquentFacilities;
  final String lastReportedDate;
  final int totalNoOfLoans;
  final int totalNoOfInstitutions;
  final int totalNoOfActiveLoans;
  final String totalBorrowed;
  final String totalOutstanding;
  final String totalOverdue;
  final int maxNoOfDays;
  final int totalNoOfClosedLoans;
  final String crcReportOrderNumber;

  Score({
    required this.totalNoOfDelinquentFacilities,
    required this.lastReportedDate,
    required this.totalNoOfLoans,
    required this.totalNoOfInstitutions,
    required this.totalNoOfActiveLoans,
    required this.totalBorrowed,
    required this.totalOutstanding,
    required this.totalOverdue,
    required this.maxNoOfDays,
    required this.totalNoOfClosedLoans,
    required this.crcReportOrderNumber,
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      totalNoOfDelinquentFacilities: int.parse(json['totalNoOfDelinquentFacilities']),
      lastReportedDate: json['lastReportedDate'],
      totalNoOfLoans: int.parse(json['totalNoOfLoans']),
      totalNoOfInstitutions: int.parse(json['totalNoOfInstitutions']),
      totalNoOfActiveLoans: int.parse(json['totalNoOfActiveLoans']),
      totalBorrowed: json['totalBorrowed'],
      totalOutstanding: json['totalOutstanding'],
      totalOverdue: json['totalOverdue'],
      maxNoOfDays: int.parse(json['maxNoOfDays']),
      totalNoOfClosedLoans: json['totalNoOfClosedLoans'],
      crcReportOrderNumber: json['crcReportOrderNumber'],
    );
  }
}

class CreditReport {
  final String bvn;
  final String customerId;
  final String businessId;
  final String name;
  final String gender;
  final String dateOfBirth;
  final String phone;
  final String address;
  final String searchedDate;
  final Score score;

  CreditReport({
    required this.bvn,
    required this.customerId,
    required this.businessId,
    required this.name,
    required this.gender,
    required this.dateOfBirth,
    required this.phone,
    required this.address,
    required this.searchedDate,
    required this.score,
  });

  factory CreditReport.fromJson(Map<String, dynamic> json) {
    return CreditReport(
      bvn: json['bvn'],
      customerId: json['customerId'],
      businessId: json['businessId'],
      name: json['name'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
      phone: json['phone'],
      address: json['address'],
      searchedDate: json['searchedDate'],
      score: Score.fromJson(json['score']),
    );
  }
}



