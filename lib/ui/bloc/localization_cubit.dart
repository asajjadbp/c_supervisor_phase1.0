// import 'dart:ui' as ui;
//
// import 'package:app_assets/localization/localization_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_core/flutter_core.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:rafeeki/data/datasources/local/app_shared_prefs_client.dart';
//
// /// Saves and loads information regarding localization settings
// ///
// class LocalizationCubit extends Cubit<Locale> {
//   LocalizationCubit({
//     required this.sharedPrefsClient,
//   }) : super(initialLocale);
//
//   /// English Supported Locale
//   static const Locale localeEn = Locale('en');
//
//   /// Arabic Supported Locale
//   static const Locale localeAr = Locale('ar');
//
//   final AppSharedPrefsClient sharedPrefsClient;
//
//   /// Contains all our localizationDelegates
//   final List<LocalizationsDelegate> localizationDelegates = [
//     LocalizationHelper.delegate,
//     GlobalMaterialLocalizations.delegate,
//     GlobalWidgetsLocalizations.delegate,
//     GlobalCupertinoLocalizations.delegate
//   ];
//
//   /// Returns supported locales by the app.
//   List<Locale> get supportedLocales => LocalizationHelper.supportedLocales;
//
//   /// maps the [supportedLocales] to languageCodes for the language selection dropdown
//   List<String> get supportedLanguageCodes =>
//       supportedLocales.map((locale) => locale.languageCode).toList();
//
//   /// Gets default locale for the application i.e.: english
//   static Locale get _defaultLocale => LocalizationHelper.defaultLocale;
//
//   /// Returns the current locale if it's  [_isLocaleSupported]
//   /// otherwise it returns the apps default locale [_defaultLocale]
//   static Locale get initialLocale {
//     Locale locale = getCurrentLocale();
//     return _isLocaleSupported(locale) ? locale : _defaultLocale;
//   }
//
//   /// Returns current locale without the CountryCode
//   static Locale getCurrentLocale() {
//     String languageCode = ui.window.locale.languageCode;
//     return Locale(languageCode);
//   }
//
//   /// Checks if locale is supported using the [AppLocalizations.supportedLocales]
//   static bool _isLocaleSupported(Locale locale) =>
//       LocalizationHelper.supportedLocales.contains(locale);
//
//   /// Get locale of the system on initial launch
//   ///   Detect initial launch by checking the hydrated cubit state -> if it's null then it's the initial launch
//   /// Otherwise we get the saved locale from the hydrated cubit
//   ///
//   /// Returns current locale without the CountryCode
//   Locale currentLocale() => state;
//
//   /// Update locale used in the app to Locale if supported
//   void updateLocale(
//     Locale locale, {
//     bool shouldUpdateLanguageInServer = false,
//   }) {
//     if (supportedLocales.contains(locale)) {
//       // sharedPrefsClient.updateLanguage(locale.languageCode);
//       emit(locale);
//       final languageId = locale.getLanguageId();
//       // if (shouldUpdateLanguageInServer) {
//       //   Future.delayed(Duration.zero,
//       //           () => updateNotificationLanguage(languageId: languageId));
//       // }
//     }
//   }
//
//   /// Update locale used in the app to English
//   void updateLocaleToEnglish({bool shouldUpdateLanguageInServer = false}) =>
//       updateLocale(localeEn,
//           shouldUpdateLanguageInServer: shouldUpdateLanguageInServer);
//
//   /// Update locale used in the app to Arabic
//   void updateLocaleToArabic({bool shouldUpdateLanguageInServer = false}) =>
//       updateLocale(localeAr,
//           shouldUpdateLanguageInServer: shouldUpdateLanguageInServer);
//
// // /// Returns Locale from the saved json object [json]
// // @override
// // Locale? fromJson(Map<String, dynamic> json) {
// //   final locale = json['locale'];
// //   if (locale == Null) return null;
// //   return Locale(locale);
// // }
// //
// // /// Returns Json object of [state] to be saved later
// // @override
// // Map<String, dynamic>? toJson(Locale state) {
// //   final locale = {'locale': state.languageCode};
// //   return locale;
// // }
//
// // Future<void> updateNotificationLanguage({
// //   required int languageId,
// // }) async {
// //   await contactUsRepository.updateNotificationLanguage(languageId);
// // }
// }
