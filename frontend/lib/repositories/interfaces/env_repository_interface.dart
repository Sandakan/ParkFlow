import 'package:parkflow/utils/constants/enums/app_level.dart';

abstract class EnvRepositoryInterface {
  AppLevelEnum get level;
  String getBaseUrl();
}
