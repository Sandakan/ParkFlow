enum LanguageEnum {
  en('en', 'English'),
  si('si', 'Sinhala'),
  ta('ta', 'Tamil');

  final String value;
  final String label;

  const LanguageEnum(this.value, this.label);

  static LanguageEnum? fromValue(String value) {
    for (final language in LanguageEnum.values) {
      if (language.value == value) {
        return language;
      }
    }
    return null;
  }
}
