class ApiResponse {
  bool status;
  String message;
  ApiResponseData info;

  ApiResponse({
    required this.status,
    required this.message,
    required this.info,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      info: ApiResponseData.fromJson(json['data'] ?? {}),
    );
  }
}

class ApiResponseData {
  List<LoanOffer> offers;

  ApiResponseData({
    required this.offers,
  });

  factory ApiResponseData.fromJson(Map<String, dynamic> json) {
    List<dynamic> offers = json['offer'] ?? [];
    List<LoanOffer> offerList = offers.map((item) => LoanOffer.fromJson(item)).toList();

    return ApiResponseData(
      offers: offerList,
    );
  }
}

class LoanOffer {
  LoanAmount loanAmount;
  CreditWorthiness creditWorthiness;
  String status;
  String id;
  String serviceTypeId;
  String merchantId;
  String serviceId;
  String name;
  double interest;
  String repaymentPlan;
  double duration;
  String closeDate;
  String image;
  String createdAt;
  String updatedAt;
  int v;

  LoanOffer({
    required this.loanAmount,
    required this.creditWorthiness,
    required this.status,
    required this.id,
    required this.serviceTypeId,
    required this.merchantId,
    required this.serviceId,
    required this.name,
    required this.interest,
    required this.repaymentPlan,
    required this.duration,
    required this.closeDate,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory LoanOffer.fromJson(Map<String, dynamic> json) {
    return LoanOffer(
      loanAmount: LoanAmount.fromJson(json['loanAmount'] ?? {}),
      creditWorthiness: CreditWorthiness.fromJson(json['creditWorthiness'] ?? {}),
      status: json['status'] as String? ?? '',
      id: json['_id'] as String? ?? '',
      serviceTypeId: json['serviceTypeId'] as String? ?? '',
      merchantId: json['merchantId'] as String? ?? '',
      serviceId: json['serviceId'] as String? ?? '',
      name: json['name'] as String? ?? '',
      interest: (json['interest'] as num?)?.toDouble() ?? 0.0,
      repaymentPlan: json['repaymentPlan'] as String? ?? '',
      duration: (json['duration'] as num?)?.toDouble() ?? 0.0,
      closeDate: json['closeDate'] as String? ?? '',
      image: json['image'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
      v: json['__v'] as int? ?? 0,
    );
  }
}



class LoanAmount {
  int minimum;
  int maximum;

  LoanAmount({
    required this.minimum,
    required this.maximum,
  });

  factory LoanAmount.fromJson(Map<String, dynamic> json) {
    return LoanAmount(
      minimum: json['minimum'] ?? 0,
      maximum: json['maximum'] ?? 0,
    );
  }
}

class CreditWorthiness {
  int minimum;
  int maximum;

  CreditWorthiness({
    required this.minimum,
    required this.maximum,
  });

  factory CreditWorthiness.fromJson(Map<String, dynamic> json) {
    return CreditWorthiness(
      minimum: json['minimum'] ?? 0,
      maximum: json['maximum'] ?? 0,
    );
  }
}
