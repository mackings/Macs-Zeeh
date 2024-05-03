class WalletResponse {
  final WalletData data;
  final bool success;
  final String message;

  WalletResponse({
    required this.data,
    required this.success,
    required this.message,
  });

  factory WalletResponse.fromJson(Map<String, dynamic> json) {
    return WalletResponse(
      data: WalletData.fromJson(json['data']),
      success: json['success'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
      'success': success,
      'message': message,
    };
  }
}

class WalletData {
  final int id;
  final int ownerId;
  final String usezeeh_user_id;
  final String ownerType;
  final String availableBalance;
  final String ledgerBalance;
  final bool active;
  final String currency;
  final String createdAt;
  final String updatedAt;
  final VirtualAccount virtualAccount;

  WalletData({
    required this.id,
    required this.ownerId,
    required this.usezeeh_user_id,
    required this.ownerType,
    required this.availableBalance,
    required this.ledgerBalance,
    required this.active,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
    required this.virtualAccount,
  });

  factory WalletData.fromJson(Map<String, dynamic> json) {
    return WalletData(
      id: json['id'],
      ownerId: json['owner_id'],
      ownerType: json['owner_type'],
      usezeeh_user_id:json['usezeeh_user_id'],
      availableBalance: json['available_balance'],
      ledgerBalance: json['ledger_balance'],
      active: json['active'],
      currency: json['currency'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      virtualAccount: VirtualAccount.fromJson(json['virtualAccount']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'usezeeh_user_id':usezeeh_user_id,
      'owner_id': ownerId,
      'owner_type': ownerType,
      'available_balance': availableBalance,
      'ledger_balance': ledgerBalance,
      'active': active,
      'currency': currency,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'virtualAccount': virtualAccount.toJson(),
    };
  }
}

class VirtualAccount {
  final int id;
  final String bankName;
  final String bankCode;
  final String accountName;
  final String accountNumber;
  final int walletId;
  final String ref;
  final String accountType;
  final int ownerId;
  final String currency;
  final String ownerType;
  final bool active;

  VirtualAccount({
    required this.id,
    required this.bankName,
    required this.bankCode,
    required this.accountName,
    required this.accountNumber,
    required this.walletId,
    required this.ref,
    required this.accountType,
    required this.ownerId,
    required this.currency,
    required this.ownerType,
    required this.active,
  });

  factory VirtualAccount.fromJson(Map<String, dynamic> json) {
    return VirtualAccount(
      id: json['id'],
      bankName: json['bank_name'],
      bankCode: json['bank_code'],
      accountName: json['account_name'],
      accountNumber: json['account_number'],
      walletId: json['wallet_id'],
      ref: json['ref'],
      accountType: json['account_type'],
      ownerId: json['owner_id'],
      currency: json['currency'],
      ownerType: json['owner_type'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bank_name': bankName,
      'bank_code': bankCode,
      'account_name': accountName,
      'account_number': accountNumber,
      'wallet_id': walletId,
      'ref': ref,
      'account_type': accountType,
      'owner_id': ownerId,
      'currency': currency,
      'owner_type': ownerType,
      'active': active,
    };
  }
}
