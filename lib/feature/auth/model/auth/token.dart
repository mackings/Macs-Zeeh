import 'package:hive/hive.dart';
import '../../../../constants/hive_constants.dart';

part 'token.g.dart';

@HiveType(typeId: HiveConstants.tokenHiveId)
class Token {
  @HiveField(1)
  final String? token;

  Token({
    this.token,
  });
}
