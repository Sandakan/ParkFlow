import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parkflow/utils/constants/enums/language.dart';
import 'package:parkflow/utils/constants/enums/app_status_code.dart';
import 'package:parkflow/l10n/app_localizations.dart';

class MockAppLocalizations extends Mock implements AppLocalizations {}

void main() {
  late MockAppLocalizations mockL10n;

  setUp(() {
    mockL10n = MockAppLocalizations();
    when(() => mockL10n.checkInternetConnection).thenReturn('Check Internet');
    when(() => mockL10n.somethingWrongDescription).thenReturn('Something went wrong');
    when(() => mockL10n.authTokenExpiredError).thenReturn('Auth token expired');
    when(() => mockL10n.sessionExpired).thenReturn('Session expired');
  });

  group('LanguageEnum', () {
    test('values should return correct strings', () {
      expect(LanguageEnum.en.value, 'en');
      expect(LanguageEnum.si.value, 'si');
      expect(LanguageEnum.ta.value, 'ta');
    });

    test('labels should return correct strings', () {
      expect(LanguageEnum.en.label, 'English');
      expect(LanguageEnum.si.label, 'Sinhala');
      expect(LanguageEnum.ta.label, 'Tamil');
    });

    test('fromValue should return correct enum or null', () {
      expect(LanguageEnum.fromValue('en'), LanguageEnum.en);
      expect(LanguageEnum.fromValue('si'), LanguageEnum.si);
      expect(LanguageEnum.fromValue('ta'), LanguageEnum.ta);
      expect(LanguageEnum.fromValue('invalid'), isNull);
    });
  });

  group('AppStatusCode', () {
    test('fromString should return correct enum for valid strings', () {
      expect(AppStatusCode.fromString('SUCCESS'), AppStatusCode.success);
      expect(AppStatusCode.fromString('NETWORK_ERROR'), AppStatusCode.networkError);
      expect(AppStatusCode.fromString('USER_ALREADY_EXISTS'), AppStatusCode.userAlreadyExists);
    });

    test('fromString should return unknownError for invalid strings', () {
      expect(AppStatusCode.fromString('NOT_A_REAL_CODE'), AppStatusCode.unknownError);
    });

    test('toLocalizedString should return correct strings', () {
      expect(AppStatusCode.success.toLocalizedString(mockL10n), 'Success');
      expect(AppStatusCode.noInternetConnection.toLocalizedString(mockL10n), 'Check Internet');
      expect(AppStatusCode.networkError.toLocalizedString(mockL10n), 'Check Internet');
      expect(AppStatusCode.serverError.toLocalizedString(mockL10n), 'Something went wrong');
      expect(AppStatusCode.authTokenExpired.toLocalizedString(mockL10n), 'Auth token expired');
      expect(AppStatusCode.sessionExpired.toLocalizedString(mockL10n), 'Session expired');
      expect(AppStatusCode.unknownError.toLocalizedString(mockL10n), 'Something went wrong');
    });
  });
}
