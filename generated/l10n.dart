// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Name1`
  String get name1 {
    return Intl.message(
      'Name1',
      name: 'name1',
      desc: '',
      args: [],
    );
  }

  /// `Price/ unit`
  String get price {
    return Intl.message(
      'Price/ unit',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Income`
  String get income {
    return Intl.message(
      'Income',
      name: 'income',
      desc: '',
      args: [],
    );
  }

  /// `Expense`
  String get expense {
    return Intl.message(
      'Expense',
      name: 'expense',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get balance {
    return Intl.message(
      'Balance',
      name: 'balance',
      desc: '',
      args: [],
    );
  }

  /// `food`
  String get food {
    return Intl.message(
      'food',
      name: 'food',
      desc: '',
      args: [],
    );
  }

  /// `Housing expenses`
  String get housing {
    return Intl.message(
      'Housing expenses',
      name: 'housing',
      desc: '',
      args: [],
    );
  }

  /// `Education & development`
  String get education {
    return Intl.message(
      'Education & development',
      name: 'education',
      desc: '',
      args: [],
    );
  }

  /// `Entertainment & leisure`
  String get entertainment {
    return Intl.message(
      'Entertainment & leisure',
      name: 'entertainment',
      desc: '',
      args: [],
    );
  }

  /// `Transport expenses`
  String get transport {
    return Intl.message(
      'Transport expenses',
      name: 'transport',
      desc: '',
      args: [],
    );
  }

  /// `Insurance & protection`
  String get insurance {
    return Intl.message(
      'Insurance & protection',
      name: 'insurance',
      desc: '',
      args: [],
    );
  }

  /// `Insurance & protection`
  String get ins_insurance {
    return Intl.message(
      'Insurance & protection',
      name: 'ins_insurance',
      desc: '',
      args: [],
    );
  }

  /// `Miscellaneous expenses`
  String get miscellaneous {
    return Intl.message(
      'Miscellaneous expenses',
      name: 'miscellaneous',
      desc: '',
      args: [],
    );
  }

  /// `Debts & loans`
  String get debts_loans {
    return Intl.message(
      'Debts & loans',
      name: 'debts_loans',
      desc: '',
      args: [],
    );
  }

  /// `Debts & loans`
  String get debt {
    return Intl.message(
      'Debts & loans',
      name: 'debt',
      desc: '',
      args: [],
    );
  }

  /// `Charity`
  String get charity {
    return Intl.message(
      'Charity',
      name: 'charity',
      desc: '',
      args: [],
    );
  }

  /// `Charity`
  String get charity_donations {
    return Intl.message(
      'Charity',
      name: 'charity_donations',
      desc: '',
      args: [],
    );
  }

  /// `Add category`
  String get add_category {
    return Intl.message(
      'Add category',
      name: 'add_category',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get report {
    return Intl.message(
      'Report',
      name: 'report',
      desc: '',
      args: [],
    );
  }

  /// `Subscription`
  String get subscription {
    return Intl.message(
      'Subscription',
      name: 'subscription',
      desc: '',
      args: [],
    );
  }

  /// `Registration`
  String get Registration {
    return Intl.message(
      'Registration',
      name: 'Registration',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message(
      'Help',
      name: 'help',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get menu {
    return Intl.message(
      'Menu',
      name: 'menu',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Select Currency`
  String get selectCurrency {
    return Intl.message(
      'Select Currency',
      name: 'selectCurrency',
      desc: '',
      args: [],
    );
  }

  /// `Advance`
  String get advance {
    return Intl.message(
      'Advance',
      name: 'advance',
      desc: '',
      args: [],
    );
  }

  /// `Salary`
  String get salary {
    return Intl.message(
      'Salary',
      name: 'salary',
      desc: '',
      args: [],
    );
  }

  /// `Your income`
  String get your_income {
    return Intl.message(
      'Your income',
      name: 'your_income',
      desc: '',
      args: [],
    );
  }

  /// `New category`
  String get new_category {
    return Intl.message(
      'New category',
      name: 'new_category',
      desc: '',
      args: [],
    );
  }

  /// `Enter a new category name`
  String get enter_new_category_name {
    return Intl.message(
      'Enter a new category name',
      name: 'enter_new_category_name',
      desc: '',
      args: [],
    );
  }

  /// `Delete new category`
  String get delete_new_category {
    return Intl.message(
      'Delete new category',
      name: 'delete_new_category',
      desc: '',
      args: [],
    );
  }

  /// `New name`
  String get new_name {
    return Intl.message(
      'New name',
      name: 'new_name',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `enter subcategory`
  String get enter_subcategory {
    return Intl.message(
      'enter subcategory',
      name: 'enter_subcategory',
      desc: '',
      args: [],
    );
  }

  /// `name`
  String get name {
    return Intl.message(
      'name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Price/un`
  String get price_per_unit {
    return Intl.message(
      'Price/un',
      name: 'price_per_unit',
      desc: '',
      args: [],
    );
  }

  /// `Qty`
  String get quantity {
    return Intl.message(
      'Qty',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Add table`
  String get add_table {
    return Intl.message(
      'Add table',
      name: 'add_table',
      desc: '',
      args: [],
    );
  }

  /// `Remove table`
  String get remove_table {
    return Intl.message(
      'Remove table',
      name: 'remove_table',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Vegetables & Fruits`
  String get vegetables_fruits {
    return Intl.message(
      'Vegetables & Fruits',
      name: 'vegetables_fruits',
      desc: '',
      args: [],
    );
  }

  /// `Groceries`
  String get groceries {
    return Intl.message(
      'Groceries',
      name: 'groceries',
      desc: '',
      args: [],
    );
  }

  /// `Meat & Fish`
  String get meat_fish {
    return Intl.message(
      'Meat & Fish',
      name: 'meat_fish',
      desc: '',
      args: [],
    );
  }

  /// `Dairy Products`
  String get dairy_products {
    return Intl.message(
      'Dairy Products',
      name: 'dairy_products',
      desc: '',
      args: [],
    );
  }

  /// `Bakery Products`
  String get bakery_products {
    return Intl.message(
      'Bakery Products',
      name: 'bakery_products',
      desc: '',
      args: [],
    );
  }

  /// `Drinks`
  String get drinks {
    return Intl.message(
      'Drinks',
      name: 'drinks',
      desc: '',
      args: [],
    );
  }

  /// `Add subcategory`
  String get add_subcategory {
    return Intl.message(
      'Add subcategory',
      name: 'add_subcategory',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Rent`
  String get rent {
    return Intl.message(
      'Rent',
      name: 'rent',
      desc: '',
      args: [],
    );
  }

  /// `Utilities`
  String get utilities {
    return Intl.message(
      'Utilities',
      name: 'utilities',
      desc: '',
      args: [],
    );
  }

  /// `Maintenance & Repairs`
  String get maintenance {
    return Intl.message(
      'Maintenance & Repairs',
      name: 'maintenance',
      desc: '',
      args: [],
    );
  }

  /// `Management Fees`
  String get management_fees {
    return Intl.message(
      'Management Fees',
      name: 'management_fees',
      desc: '',
      args: [],
    );
  }

  /// `Internet and Communication`
  String get internet {
    return Intl.message(
      'Internet and Communication',
      name: 'internet',
      desc: '',
      args: [],
    );
  }

  /// `Other Expenses`
  String get other_expenses {
    return Intl.message(
      'Other Expenses',
      name: 'other_expenses',
      desc: '',
      args: [],
    );
  }

  /// `Fuel`
  String get transport_fuel {
    return Intl.message(
      'Fuel',
      name: 'transport_fuel',
      desc: '',
      args: [],
    );
  }

  /// `Maintenance`
  String get transport_maintenance {
    return Intl.message(
      'Maintenance',
      name: 'transport_maintenance',
      desc: '',
      args: [],
    );
  }

  /// `Parking Fees`
  String get transport_parking_fees {
    return Intl.message(
      'Parking Fees',
      name: 'transport_parking_fees',
      desc: '',
      args: [],
    );
  }

  /// `Toll Roads`
  String get transport_toll_roads {
    return Intl.message(
      'Toll Roads',
      name: 'transport_toll_roads',
      desc: '',
      args: [],
    );
  }

  /// `Public Transport`
  String get transport_public_transport {
    return Intl.message(
      'Public Transport',
      name: 'transport_public_transport',
      desc: '',
      args: [],
    );
  }

  /// `Taxi & Ridesharing`
  String get transport_taxi_ridesharing {
    return Intl.message(
      'Taxi & Ridesharing',
      name: 'transport_taxi_ridesharing',
      desc: '',
      args: [],
    );
  }

  /// `Car Rental`
  String get transport_car_rental {
    return Intl.message(
      'Car Rental',
      name: 'transport_car_rental',
      desc: '',
      args: [],
    );
  }

  /// `Repairs`
  String get transport_repairs {
    return Intl.message(
      'Repairs',
      name: 'transport_repairs',
      desc: '',
      args: [],
    );
  }

  /// `Miscellaneous`
  String get transport_miscellaneous {
    return Intl.message(
      'Miscellaneous',
      name: 'transport_miscellaneous',
      desc: '',
      args: [],
    );
  }

  /// `Medications, vitamins, pharmacy products`
  String get med_medications_pharmacy_products {
    return Intl.message(
      'Medications, vitamins, pharmacy products',
      name: 'med_medications_pharmacy_products',
      desc: '',
      args: [],
    );
  }

  /// `Doctor visits, medical examinations`
  String get med_doctor_visits_examinations {
    return Intl.message(
      'Doctor visits, medical examinations',
      name: 'med_doctor_visits_examinations',
      desc: '',
      args: [],
    );
  }

  /// `Treatments, chronic conditions`
  String get med_treatments_chronic_conditions {
    return Intl.message(
      'Treatments, chronic conditions',
      name: 'med_treatments_chronic_conditions',
      desc: '',
      args: [],
    );
  }

  /// `Dentistry, optometry`
  String get med_dentistry_optometry {
    return Intl.message(
      'Dentistry, optometry',
      name: 'med_dentistry_optometry',
      desc: '',
      args: [],
    );
  }

  /// `Physical therapy, orthopedic services`
  String get med_physical_therapy_orthopedic_services {
    return Intl.message(
      'Physical therapy, orthopedic services',
      name: 'med_physical_therapy_orthopedic_services',
      desc: '',
      args: [],
    );
  }

  /// `Psychological help, ...`
  String get med_psychological_cosmetic_services {
    return Intl.message(
      'Psychological help, ...',
      name: 'med_psychological_cosmetic_services',
      desc: '',
      args: [],
    );
  }

  /// `Emergency medical expenses`
  String get med_emergency_vaccination {
    return Intl.message(
      'Emergency medical expenses',
      name: 'med_emergency_vaccination',
      desc: '',
      args: [],
    );
  }

  /// `Clothing`
  String get cloth_clothing {
    return Intl.message(
      'Clothing',
      name: 'cloth_clothing',
      desc: '',
      args: [],
    );
  }

  /// `Footwear`
  String get cloth_footwear {
    return Intl.message(
      'Footwear',
      name: 'cloth_footwear',
      desc: '',
      args: [],
    );
  }

  /// `Hair salons and beauty salons`
  String get cloth_hair_salons {
    return Intl.message(
      'Hair salons and beauty salons',
      name: 'cloth_hair_salons',
      desc: '',
      args: [],
    );
  }

  /// `Cosmetics & skincare`
  String get cloth_cosmetics_skincare {
    return Intl.message(
      'Cosmetics & skincare',
      name: 'cloth_cosmetics_skincare',
      desc: '',
      args: [],
    );
  }

  /// `Personal hygiene products`
  String get cloth_personal_hygiene {
    return Intl.message(
      'Personal hygiene products',
      name: 'cloth_personal_hygiene',
      desc: '',
      args: [],
    );
  }

  /// `Paid apps & subscriptions`
  String get cloth_paid_apps_subscriptions {
    return Intl.message(
      'Paid apps & subscriptions',
      name: 'cloth_paid_apps_subscriptions',
      desc: '',
      args: [],
    );
  }

  /// `Body care & fitness`
  String get cloth_fitness_body_care {
    return Intl.message(
      'Body care & fitness',
      name: 'cloth_fitness_body_care',
      desc: '',
      args: [],
    );
  }

  /// `Mobile communication & internet`
  String get cloth_mobile_internet {
    return Intl.message(
      'Mobile communication & internet',
      name: 'cloth_mobile_internet',
      desc: '',
      args: [],
    );
  }

  /// `School education`
  String get edu_school_education {
    return Intl.message(
      'School education',
      name: 'edu_school_education',
      desc: '',
      args: [],
    );
  }

  /// `Preschool education`
  String get edu_preschool_education {
    return Intl.message(
      'Preschool education',
      name: 'edu_preschool_education',
      desc: '',
      args: [],
    );
  }

  /// `University & additional education`
  String get edu_university_education {
    return Intl.message(
      'University & additional education',
      name: 'edu_university_education',
      desc: '',
      args: [],
    );
  }

  /// `Clubs and sections`
  String get edu_clubs_sections {
    return Intl.message(
      'Clubs and sections',
      name: 'edu_clubs_sections',
      desc: '',
      args: [],
    );
  }

  /// `Tutors & private lessons`
  String get edu_tutors_private_lessons {
    return Intl.message(
      'Tutors & private lessons',
      name: 'edu_tutors_private_lessons',
      desc: '',
      args: [],
    );
  }

  /// `Educational apps & subscriptions`
  String get edu_educational_apps_subscriptions {
    return Intl.message(
      'Educational apps & subscriptions',
      name: 'edu_educational_apps_subscriptions',
      desc: '',
      args: [],
    );
  }

  /// `Books & study materials`
  String get edu_books_study_materials {
    return Intl.message(
      'Books & study materials',
      name: 'edu_books_study_materials',
      desc: '',
      args: [],
    );
  }

  /// `Workshops & training`
  String get edu_workshops_training {
    return Intl.message(
      'Workshops & training',
      name: 'edu_workshops_training',
      desc: '',
      args: [],
    );
  }

  /// `Educational trips`
  String get edu_educational_trips {
    return Intl.message(
      'Educational trips',
      name: 'edu_educational_trips',
      desc: '',
      args: [],
    );
  }

  /// `Additional development expenses`
  String get edu_additional_development_expenses {
    return Intl.message(
      'Additional development expenses',
      name: 'edu_additional_development_expenses',
      desc: '',
      args: [],
    );
  }

  /// `Movies and Theaters`
  String get leisure_movies_theaters {
    return Intl.message(
      'Movies and Theaters',
      name: 'leisure_movies_theaters',
      desc: '',
      args: [],
    );
  }

  /// `Museums and Exhibitions`
  String get leisure_museums_exhibitions {
    return Intl.message(
      'Museums and Exhibitions',
      name: 'leisure_museums_exhibitions',
      desc: '',
      args: [],
    );
  }

  /// `Sports & Music Events`
  String get leisure_sports_music_events {
    return Intl.message(
      'Sports & Music Events',
      name: 'leisure_sports_music_events',
      desc: '',
      args: [],
    );
  }

  /// `Summer Camps & Camping`
  String get leisure_summer_camps_camping {
    return Intl.message(
      'Summer Camps & Camping',
      name: 'leisure_summer_camps_camping',
      desc: '',
      args: [],
    );
  }

  /// `Hiking, Picnics, & Trips`
  String get leisure_hiking_trips {
    return Intl.message(
      'Hiking, Picnics, & Trips',
      name: 'leisure_hiking_trips',
      desc: '',
      args: [],
    );
  }

  /// `Home Parties & Celebrations`
  String get leisure_home_parties {
    return Intl.message(
      'Home Parties & Celebrations',
      name: 'leisure_home_parties',
      desc: '',
      args: [],
    );
  }

  /// `Hobbies & Crafts`
  String get leisure_hobbies_crafts {
    return Intl.message(
      'Hobbies & Crafts',
      name: 'leisure_hobbies_crafts',
      desc: '',
      args: [],
    );
  }

  /// `Cafes, Restaurants...`
  String get leisure_cafes_restaurants {
    return Intl.message(
      'Cafes, Restaurants...',
      name: 'leisure_cafes_restaurants',
      desc: '',
      args: [],
    );
  }

  /// `Miscellaneous expenses`
  String get misc_expenses {
    return Intl.message(
      'Miscellaneous expenses',
      name: 'misc_expenses',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Choose a date`
  String get chooseDate {
    return Intl.message(
      'Choose a date',
      name: 'chooseDate',
      desc: '',
      args: [],
    );
  }

  /// `Final Report`
  String get final_report {
    return Intl.message(
      'Final Report',
      name: 'final_report',
      desc: '',
      args: [],
    );
  }

  /// `Expense Category`
  String get expense_category {
    return Intl.message(
      'Expense Category',
      name: 'expense_category',
      desc: '',
      args: [],
    );
  }

  /// `Creditor`
  String get creditor {
    return Intl.message(
      'Creditor',
      name: 'creditor',
      desc: '',
      args: [],
    );
  }

  /// `Personal Category`
  String get personal_category {
    return Intl.message(
      'Personal Category',
      name: 'personal_category',
      desc: '',
      args: [],
    );
  }

  /// `Week`
  String get week {
    return Intl.message(
      'Week',
      name: 'week',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get month {
    return Intl.message(
      'Month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get year {
    return Intl.message(
      'Year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `Expense by Category`
  String get expense_by_category {
    return Intl.message(
      'Expense by Category',
      name: 'expense_by_category',
      desc: '',
      args: [],
    );
  }

  /// `Health & Medicine`
  String get health {
    return Intl.message(
      'Health & Medicine',
      name: 'health',
      desc: '',
      args: [],
    );
  }

  /// `Clothing & Miscellaneous`
  String get clothing {
    return Intl.message(
      'Clothing & Miscellaneous',
      name: 'clothing',
      desc: '',
      args: [],
    );
  }

  /// `Warning Threshold`
  String get threshold_warning {
    return Intl.message(
      'Warning Threshold',
      name: 'threshold_warning',
      desc: '',
      args: [],
    );
  }

  /// `Critical Threshold`
  String get threshold_critical {
    return Intl.message(
      'Critical Threshold',
      name: 'threshold_critical',
      desc: '',
      args: [],
    );
  }

  /// `Enter Warning Threshold`
  String get enter_threshold_warning {
    return Intl.message(
      'Enter Warning Threshold',
      name: 'enter_threshold_warning',
      desc: '',
      args: [],
    );
  }

  /// `Enter Critical Threshold`
  String get enter_threshold_critical {
    return Intl.message(
      'Enter Critical Threshold',
      name: 'enter_threshold_critical',
      desc: '',
      args: [],
    );
  }

  /// `No data available`
  String get no_data_available {
    return Intl.message(
      'No data available',
      name: 'no_data_available',
      desc: '',
      args: [],
    );
  }

  /// `{locale, select, en{English} ru{Russian} pl{Polish} fr{French} de{German} it{Italian} es{Spanish} pt{Portuguese} uk{Ukrainian} other{Unknown}}`
  String localeName(Object locale) {
    return Intl.select(
      locale,
      {
        'en': 'English',
        'ru': 'Russian',
        'pl': 'Polish',
        'fr': 'French',
        'de': 'German',
        'it': 'Italian',
        'es': 'Spanish',
        'pt': 'Portuguese',
        'uk': 'Ukrainian',
        'other': 'Unknown',
      },
      name: 'localeName',
      desc: '',
      args: [locale],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'pl'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'uk'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
