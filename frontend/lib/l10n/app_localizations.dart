import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_si.dart';
import 'app_localizations_ta.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('si'),
    Locale('ta'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'ParkFlow'**
  String get appTitle;

  /// The title for the parking lots management screen
  ///
  /// In en, this message translates to:
  /// **'Parking Lots'**
  String get parkingLotsTitle;

  /// The title displayed on the login screen
  ///
  /// In en, this message translates to:
  /// **'ParkFlow'**
  String get loginTitle;

  /// The subtitle displayed on the login screen
  ///
  /// In en, this message translates to:
  /// **'Welcome back! Sign in to your account.'**
  String get welcomeBackSubtitle;

  /// The subtitle displayed on the login screen
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get signInToContinue;

  /// The label for the email input field
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// The label for the password input field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// The hint for the email input field
  ///
  /// In en, this message translates to:
  /// **'you@example.com'**
  String get emailHint;

  /// The hint for the password input field
  ///
  /// In en, this message translates to:
  /// **'••••••••'**
  String get passwordHint;

  /// Forgot password button text
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// The text for the login button
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// The text for the sign in button
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInButton;

  /// Text asking if the user doesn't have an account
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAccount;

  /// Sign up link text
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// Title for the registration screen
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccountTitle;

  /// Subtitle for the registration screen
  ///
  /// In en, this message translates to:
  /// **'Sign up to get started!'**
  String get signUpSubtitle;

  /// Label for the full name input field
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullNameLabel;

  /// Hint text for the full name input field
  ///
  /// In en, this message translates to:
  /// **'John Doe'**
  String get fullNameHint;

  /// Validation message when name is empty
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameRequired;

  /// Label for the confirm password input field
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordLabel;

  /// Validation message when confirm password is empty
  ///
  /// In en, this message translates to:
  /// **'Confirm Password is required'**
  String get confirmPasswordRequired;

  /// Validation message when passwords do not match
  ///
  /// In en, this message translates to:
  /// **'Passwords must match'**
  String get passwordsMustMatch;

  /// Text for the sign up button
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpButton;

  /// Text asking if the user already has an account
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAccount;

  /// Sign in link text
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// The title for the live dashboard page
  ///
  /// In en, this message translates to:
  /// **'ParkFlow Live Dashboard'**
  String get liveDashboard;

  /// The title for the live video feed section
  ///
  /// In en, this message translates to:
  /// **'Live Feed'**
  String get liveFeed;

  /// Label indicating a parking slot is occupied
  ///
  /// In en, this message translates to:
  /// **'Occupied'**
  String get occupied;

  /// Label indicating a parking slot is available
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// Tooltip for the logout button
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutTooltip;

  /// Error message when there is no internet connection
  ///
  /// In en, this message translates to:
  /// **'Please check your internet connection and try again.'**
  String get checkInternetConnection;

  /// Generic error message for unknown errors
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again later.'**
  String get somethingWrongDescription;

  /// Error message when the authentication token has expired
  ///
  /// In en, this message translates to:
  /// **'Your session has expired. Please log in again.'**
  String get authTokenExpiredError;

  /// Title or short description for session expired error
  ///
  /// In en, this message translates to:
  /// **'Session expired'**
  String get sessionExpired;

  /// Error message for invalid page number
  ///
  /// In en, this message translates to:
  /// **'Invalid page number'**
  String get invalidPageNumber;

  /// Error message for invalid current password
  ///
  /// In en, this message translates to:
  /// **'Current password is not valid'**
  String get currentPasswordInvalid;

  /// Error message when changing password fails
  ///
  /// In en, this message translates to:
  /// **'Failed to change password'**
  String get changePasswordFailed;

  /// Validation message when email is empty
  ///
  /// In en, this message translates to:
  /// **'The email must not be empty'**
  String get emailRequired;

  /// Validation message when email format is invalid
  ///
  /// In en, this message translates to:
  /// **'The email value must be a valid email'**
  String get emailInvalid;

  /// Validation message when password is empty
  ///
  /// In en, this message translates to:
  /// **'The password must not be empty'**
  String get passwordRequired;

  /// Validation message when password is too short
  ///
  /// In en, this message translates to:
  /// **'The password must be at least 6 characters long'**
  String get passwordMinLength;

  /// Error message for invalid login credentials
  ///
  /// In en, this message translates to:
  /// **'The email or password you entered is incorrect'**
  String get invalidCredentials;

  /// Title for the admin dashboard screen
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get adminDashboard;

  /// Welcome message for admin users
  ///
  /// In en, this message translates to:
  /// **'Welcome, Administrator'**
  String get adminWelcome;

  /// Label for the home/dashboard navigation
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Label for the profile navigation/screen
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Placeholder for unknown user name
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get guest;

  /// Text for the logout button/label
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Subtitle for the admin dashboard
  ///
  /// In en, this message translates to:
  /// **'ParkFlow Administration Console'**
  String get adminConsoleSubtitle;

  /// Button text for managing parking slots
  ///
  /// In en, this message translates to:
  /// **'Manage Parking Slots'**
  String get manageSlots;

  /// Flash message for unimplemented features
  ///
  /// In en, this message translates to:
  /// **'Manage Slots feature coming soon!'**
  String get featureComingSoon;

  /// Label for the parking lots navigation
  ///
  /// In en, this message translates to:
  /// **'Lots'**
  String get parkingLots;

  /// Label for the cameras navigation
  ///
  /// In en, this message translates to:
  /// **'Cameras'**
  String get cameras;

  /// Label for the analytics navigation
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analytics;

  /// Label for the settings navigation
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// The hint for the search parking lots input field
  ///
  /// In en, this message translates to:
  /// **'Search parking lots...'**
  String get searchLotHint;

  /// Text for the create parking lot button
  ///
  /// In en, this message translates to:
  /// **'Create Parking Lot'**
  String get createNewLot;

  /// Label indicating a parking lot is open
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get statusOpen;

  /// Label indicating a parking lot is closed
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get statusClosed;

  /// Label for the total slots count
  ///
  /// In en, this message translates to:
  /// **'Total Slots'**
  String get totalSlotsLabel;

  /// Label for today's revenue
  ///
  /// In en, this message translates to:
  /// **'Revenue Today'**
  String get revenueToday;

  /// Message displayed when no parking lots are found in search
  ///
  /// In en, this message translates to:
  /// **'No parking lots found'**
  String get noLotsFound;

  /// Message displayed when there is an error fetching parking lots
  ///
  /// In en, this message translates to:
  /// **'Error loading lots'**
  String get errorLoadingLots;

  /// The title displayed on the create new parking lot screen
  ///
  /// In en, this message translates to:
  /// **'Create New Parking Lot'**
  String get createLotTitle;

  /// The label for the lot name input field
  ///
  /// In en, this message translates to:
  /// **'Lot Name'**
  String get lotNameLabel;

  /// The hint for the lot name input field
  ///
  /// In en, this message translates to:
  /// **'Downtown Parking'**
  String get lotNameHint;

  /// The label for the lot address input field
  ///
  /// In en, this message translates to:
  /// **'Lot Address'**
  String get lotAddressLabel;

  /// The hint for the lot address input field
  ///
  /// In en, this message translates to:
  /// **'123 Main St'**
  String get lotAddressHint;

  /// The label for the latitude input field
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get latitudeLabel;

  /// The hint for the latitude input field
  ///
  /// In en, this message translates to:
  /// **'0.000'**
  String get latitudeHint;

  /// The label for the longitude input field
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get longitudeLabel;

  /// The hint for the longitude input field
  ///
  /// In en, this message translates to:
  /// **'0.000'**
  String get longitudeHint;

  /// The hint for the total slots input field
  ///
  /// In en, this message translates to:
  /// **'Number of slots'**
  String get totalSlotsHint;

  /// The label for the RTSP URL input field
  ///
  /// In en, this message translates to:
  /// **'RTSP URL'**
  String get rtspUrlLabel;

  /// The hint for the RTSP URL input field
  ///
  /// In en, this message translates to:
  /// **'rtsp://...'**
  String get rtspUrlHint;

  /// The text for the create button
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get createButton;

  /// Success message when a lot is created
  ///
  /// In en, this message translates to:
  /// **'Parking lot created successfully'**
  String get lotCreatedSuccess;

  /// Validation message when a field is required
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// Error message when a number field has an invalid value
  ///
  /// In en, this message translates to:
  /// **'Invalid number'**
  String get invalidNumber;

  /// The title for the edit parking lot screen
  ///
  /// In en, this message translates to:
  /// **'Edit Parking Lot'**
  String get editLotTitle;

  /// Button text to save changes to an existing item
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get updateButton;

  /// Success message shown after updating a parking lot
  ///
  /// In en, this message translates to:
  /// **'Parking lot updated successfully'**
  String get lotUpdatedSuccess;

  /// Label for the delete lot action
  ///
  /// In en, this message translates to:
  /// **'Delete Lot'**
  String get deleteLot;

  /// Title for the delete parking lot confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Delete Parking Lot?'**
  String get deleteLotConfirmTitle;

  /// Message for the delete parking lot confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this parking lot? This action cannot be undone.'**
  String get deleteLotConfirmMessage;

  /// Button text to confirm deletion
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// Button text to cancel an action
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// Success message shown after deleting a parking lot
  ///
  /// In en, this message translates to:
  /// **'Parking lot deleted successfully'**
  String get lotDeletedSuccess;

  /// Label for the cameras tab in the navigation
  ///
  /// In en, this message translates to:
  /// **'Cameras'**
  String get camerasTabLabel;

  /// Hint text for the camera search field
  ///
  /// In en, this message translates to:
  /// **'Search cameras...'**
  String get searchCameraHint;

  /// Button label to open the create camera dialog
  ///
  /// In en, this message translates to:
  /// **'Create Camera'**
  String get createNewCamera;

  /// Message shown when no cameras match the search criteria
  ///
  /// In en, this message translates to:
  /// **'No cameras found'**
  String get noCamerasFound;

  /// Message shown when there's an error fetching camera data
  ///
  /// In en, this message translates to:
  /// **'Error loading cameras'**
  String get errorLoadingCameras;

  /// Label for the RTSP stream health status
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get rtspHealth;

  /// Label when a camera stream is connected
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get statusConnected;

  /// Label when a camera stream is disconnected
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get statusDisconnected;

  /// Title for the create new camera screen
  ///
  /// In en, this message translates to:
  /// **'Create New Camera'**
  String get createCameraTitle;

  /// Label for the camera name input field
  ///
  /// In en, this message translates to:
  /// **'Camera Name'**
  String get cameraNameLabel;

  /// Hint text for the camera name input field
  ///
  /// In en, this message translates to:
  /// **'Front Gate'**
  String get cameraNameHint;

  /// Success message when a camera is created
  ///
  /// In en, this message translates to:
  /// **'Camera created successfully'**
  String get cameraCreatedSuccess;

  /// Error message when a user tries to register with an existing email
  ///
  /// In en, this message translates to:
  /// **'The user with this email already exists in the system.'**
  String get userAlreadyExists;

  /// The title shown at the top of the analytics screen
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analyticsTitle;

  /// Label for the section showing high-level system health metrics
  ///
  /// In en, this message translates to:
  /// **'System Vitals'**
  String get analyticsOverview;

  /// Label for the card showing total number of parking slots
  ///
  /// In en, this message translates to:
  /// **'Total Capacity'**
  String get analyticsTotalCapacity;

  /// Label for the card showing number of currently occupied slots
  ///
  /// In en, this message translates to:
  /// **'Current Occupancy'**
  String get analyticsOccupancy;

  /// Label for the card showing percentage of active cameras
  ///
  /// In en, this message translates to:
  /// **'Stream Health'**
  String get analyticsStreamHealth;

  /// Label for the card showing average time a vehicle stays in a slot
  ///
  /// In en, this message translates to:
  /// **'Avg. Dwell Time'**
  String get analyticsAvgDwell;

  /// The unit for dwell time (minutes)
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get analyticsDwellUnit;

  /// Label for the chart section showing occupancy over time
  ///
  /// In en, this message translates to:
  /// **'Occupancy Trends'**
  String get analyticsOccupancyTrend;

  /// Label for the 24 hour time period filter
  ///
  /// In en, this message translates to:
  /// **'24h'**
  String get analyticsPeriod24h;

  /// Label for the 7 day time period filter
  ///
  /// In en, this message translates to:
  /// **'7d'**
  String get analyticsPeriod7d;

  /// Label for the 30 day time period filter
  ///
  /// In en, this message translates to:
  /// **'30d'**
  String get analyticsPeriod30d;

  /// Legend label for the current period data in charts
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get analyticsTodayLabel;

  /// Legend label for the comparison period data in charts
  ///
  /// In en, this message translates to:
  /// **'Prior Period'**
  String get analyticsPriorLabel;

  /// Label for the turnover metric (vehicles per slot)
  ///
  /// In en, this message translates to:
  /// **'Turnover Rate'**
  String get analyticsTurnoverRate;

  /// Label for the turnover count for the current day
  ///
  /// In en, this message translates to:
  /// **'Turnover Today'**
  String get analyticsTurnoverToday;

  /// Label for the section showing AI model performance metrics
  ///
  /// In en, this message translates to:
  /// **'AI Engine Health'**
  String get analyticsAiHealth;

  /// The average confidence score of the AI detection model
  ///
  /// In en, this message translates to:
  /// **'Detection Confidence'**
  String get analyticsConfidenceMean;

  /// Current CPU usage percentage of the AI inference server
  ///
  /// In en, this message translates to:
  /// **'CPU Load'**
  String get analyticsCpuLoad;

  /// The time taken for a single frame to be processed by the AI model
  ///
  /// In en, this message translates to:
  /// **'Inference Latency'**
  String get analyticsInferenceLatency;

  /// Text shown when a chart has no data points to display
  ///
  /// In en, this message translates to:
  /// **'No data yet'**
  String get analyticsNoData;

  /// Button text to manually reload the analytics data
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get analyticsRefresh;

  /// Noun suffix for slot counts
  ///
  /// In en, this message translates to:
  /// **'slots'**
  String get analyticsSlots;

  /// Status label for occupied slots
  ///
  /// In en, this message translates to:
  /// **'occupied'**
  String get analyticsOccupied;

  /// Status label for available slots
  ///
  /// In en, this message translates to:
  /// **'vacant'**
  String get analyticsVacant;

  /// Suffix for the number of active camera streams
  ///
  /// In en, this message translates to:
  /// **'cameras active'**
  String get analyticsCameras;

  /// Sub-label for the occupancy trend chart explaining the comparison
  ///
  /// In en, this message translates to:
  /// **'Occupancy over time vs. prior period'**
  String get analyticsOccupancyTrendSubtitle;

  /// Subtitle for detection confidence showing the number of logs analyzed
  ///
  /// In en, this message translates to:
  /// **'samples'**
  String get analyticsSampleCount;

  /// Label for the section containing revenue and pricing metrics
  ///
  /// In en, this message translates to:
  /// **'Financials'**
  String get analyticsFinancials;

  /// Total earnings for the current day
  ///
  /// In en, this message translates to:
  /// **'Revenue Today'**
  String get analyticsRevenueToday;

  /// Total earnings for the current month
  ///
  /// In en, this message translates to:
  /// **'Revenue Month'**
  String get analyticsRevenueMonth;

  /// The currency unit used for revenue (Sri Lankan Rupee)
  ///
  /// In en, this message translates to:
  /// **'LKR'**
  String get analyticsRevenueUnit;

  /// Label for the section showing how parking operations impact efficiency
  ///
  /// In en, this message translates to:
  /// **'Operational Impact'**
  String get analyticsOperationalImpact;

  /// Label for the chart section showing revenue earnings over time
  ///
  /// In en, this message translates to:
  /// **'Revenue Trend'**
  String get analyticsRevenueTrend;

  /// Subtitle for the settings screen
  ///
  /// In en, this message translates to:
  /// **'AI Inference & System Configuration'**
  String get settingsSubtitle;

  /// Label for the AI inference configuration panel
  ///
  /// In en, this message translates to:
  /// **'Inference Precision'**
  String get settingsPrecisionPanel;

  /// Slider label for detection confidence
  ///
  /// In en, this message translates to:
  /// **'Confidence Threshold'**
  String get settingsConfidenceThreshold;

  /// Description for confidence threshold
  ///
  /// In en, this message translates to:
  /// **'Lower values catch more objects but increase false positives.'**
  String get settingsConfidenceThresholdDesc;

  /// Slider label for IoU threshold
  ///
  /// In en, this message translates to:
  /// **'IoU (Overlap) Threshold'**
  String get settingsIouThreshold;

  /// Description for IoU threshold
  ///
  /// In en, this message translates to:
  /// **'Percentage overlap with slots required to trigger status.'**
  String get settingsIouThresholdDesc;

  /// Dropdown label for frame skipping
  ///
  /// In en, this message translates to:
  /// **'Frame Skipping'**
  String get settingsFrameSkip;

  /// Description for frame skipping
  ///
  /// In en, this message translates to:
  /// **'Reduce processing load by processing every Nth frame.'**
  String get settingsFrameSkipDesc;

  /// Dropdown option for no frame skipping
  ///
  /// In en, this message translates to:
  /// **'Process every frame (Max accuracy)'**
  String get settingsFrameSkipEveryFrame;

  /// Dropdown option for 1 frame skipping
  ///
  /// In en, this message translates to:
  /// **'Every 2nd frame (Balanced)'**
  String get settingsFrameSkipEvery2nd;

  /// Dropdown option for 2 frame skipping
  ///
  /// In en, this message translates to:
  /// **'Every 3rd frame (Efficiency)'**
  String get settingsFrameSkipEvery3rd;

  /// Number field label for stability buffer
  ///
  /// In en, this message translates to:
  /// **'Stability Buffer'**
  String get settingsStabilityBuffer;

  /// Description for stability buffer
  ///
  /// In en, this message translates to:
  /// **'Consecutive frames required for a status change.'**
  String get settingsStabilityBufferDesc;

  /// Button text to save settings
  ///
  /// In en, this message translates to:
  /// **'Save Settings'**
  String get settingsSaveButton;

  /// Success snackbar message
  ///
  /// In en, this message translates to:
  /// **'Settings updated successfully'**
  String get settingsSaveSuccess;

  /// Error snackbar message
  ///
  /// In en, this message translates to:
  /// **'Failed to update settings'**
  String get settingsSaveError;

  /// Status text shown when settings are being saved
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get settingsSaving;

  /// Title for the system control settings section
  ///
  /// In en, this message translates to:
  /// **'System Control'**
  String get settingsSystemControl;

  /// Label for the global AI inference toggle
  ///
  /// In en, this message translates to:
  /// **'Enable Global Inference'**
  String get settingsGlobalInference;

  /// Description for the global AI inference toggle
  ///
  /// In en, this message translates to:
  /// **'Enable or disable AI inference globally for all available cameras.'**
  String get settingsGlobalInferenceDesc;

  /// Status label when inference is active
  ///
  /// In en, this message translates to:
  /// **'Running'**
  String get settingsInferenceRunning;

  /// Status label when inference is inactive
  ///
  /// In en, this message translates to:
  /// **'Stopped'**
  String get settingsInferenceStopped;

  /// Fallback text displayed when a parking lot name is missing or unknown
  ///
  /// In en, this message translates to:
  /// **'Unknown Parking Lot'**
  String get unknownLot;

  /// Generic loading indicator text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Label for live video feed status
  ///
  /// In en, this message translates to:
  /// **'LIVE'**
  String get liveBadge;

  /// Tooltip for the edit camera button
  ///
  /// In en, this message translates to:
  /// **'Edit Camera'**
  String get editCameraTooltip;

  /// Tooltip for the delete camera button
  ///
  /// In en, this message translates to:
  /// **'Delete Camera'**
  String get deleteCameraTooltip;

  /// Title for the edit camera dialog
  ///
  /// In en, this message translates to:
  /// **'Edit Camera'**
  String get editCameraDialogTitle;

  /// Success message when a camera is updated
  ///
  /// In en, this message translates to:
  /// **'Camera updated successfully'**
  String get cameraUpdatedSuccess;

  /// Success message when a camera is deleted
  ///
  /// In en, this message translates to:
  /// **'Camera deleted successfully'**
  String get cameraDeletedSuccess;

  /// Title for the delete camera confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Delete Camera?'**
  String get deleteCameraConfirmTitle;

  /// Message for the delete camera confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this camera? This action cannot be undone.'**
  String get deleteCameraConfirmMessage;

  /// Text for the save changes button
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChangesButton;

  /// Title for the parking slots management section
  ///
  /// In en, this message translates to:
  /// **'Parking Slots'**
  String get parkingSlotsTitle;

  /// Tooltip for the add parking slot button
  ///
  /// In en, this message translates to:
  /// **'Add Slot'**
  String get addSlotTooltip;

  /// Tooltip for the cancel drawing button
  ///
  /// In en, this message translates to:
  /// **'Cancel Drawing'**
  String get cancelDrawingTooltip;

  /// Instruction text for creating a new parking slot
  ///
  /// In en, this message translates to:
  /// **'Tap 4 points on the video to define the parking slot corners.'**
  String get tapPointsInstruction;

  /// Label for the switch to show/hide AI detections
  ///
  /// In en, this message translates to:
  /// **'Show AI Detections'**
  String get showAiDetectionsLabel;

  /// Message shown when no parking slots are defined for a camera
  ///
  /// In en, this message translates to:
  /// **'No slots defined yet.'**
  String get noSlotsDefinedMessage;

  /// Loading message when saving a new parking slot
  ///
  /// In en, this message translates to:
  /// **'Saving new slot...'**
  String get savingNewSlotMessage;

  /// Label indicating a parking slot is vacant
  ///
  /// In en, this message translates to:
  /// **'Vacant'**
  String get vacantStatus;

  /// Label for the parking slot type selector
  ///
  /// In en, this message translates to:
  /// **'Slot Type'**
  String get slotTypeLabel;

  /// Label for the general parking slot type
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get slotTypeGeneral;

  /// Label for the disabled parking slot type
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get slotTypeDisabled;

  /// Label for the electric vehicle charging parking slot type
  ///
  /// In en, this message translates to:
  /// **'EV Charging'**
  String get slotTypeEv;

  /// Label for the parking lot entrance
  ///
  /// In en, this message translates to:
  /// **'Entrance'**
  String get slotTypeEntrance;

  /// Title for the new parking slot dialog
  ///
  /// In en, this message translates to:
  /// **'New Parking Slot'**
  String get newParkingSlotTitle;

  /// Label for the slot identifier input field
  ///
  /// In en, this message translates to:
  /// **'Slot Identifier'**
  String get slotIdentifierLabel;

  /// Hint text for the slot identifier input field
  ///
  /// In en, this message translates to:
  /// **'e.g. A-15'**
  String get slotIdentifierHint;

  /// Text for the save slot button
  ///
  /// In en, this message translates to:
  /// **'Save Slot'**
  String get saveSlotButton;

  /// Success message when a parking slot is saved
  ///
  /// In en, this message translates to:
  /// **'Slot {name} saved'**
  String slotSavedSuccess(String name);

  /// Title for the delete parking slot confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Delete Slot?'**
  String get deleteSlotConfirmTitle;

  /// Message for the delete parking slot confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {name}?'**
  String deleteSlotConfirmMessage(String name);

  /// Prefix used before a slot type label
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get slotTypePrefix;

  /// Hint text for the parking lot selection dropdown
  ///
  /// In en, this message translates to:
  /// **'Select Parking Lot'**
  String get selectParkingLotHint;

  /// Label for live streams in analytics
  ///
  /// In en, this message translates to:
  /// **'live'**
  String get analyticsLiveStatus;

  /// Millisecond unit label
  ///
  /// In en, this message translates to:
  /// **'ms'**
  String get analyticsMsUnit;

  /// Hint text for numeric input fields
  ///
  /// In en, this message translates to:
  /// **'Enter value'**
  String get enterValueHint;

  /// Title for the current occupancy layout grid section
  ///
  /// In en, this message translates to:
  /// **'Current Occupancy Layout'**
  String get currentOccupancyLayout;

  /// Label for the parking slot width input
  ///
  /// In en, this message translates to:
  /// **'Slot Width (m)'**
  String get slotWidthLabel;

  /// Label for the parking slot length input
  ///
  /// In en, this message translates to:
  /// **'Slot Length (m)'**
  String get slotLengthLabel;

  /// Label for the entrance logical coordinates section
  ///
  /// In en, this message translates to:
  /// **'Entrance Coords'**
  String get entranceCoordsLabel;

  /// Label for logical row input
  ///
  /// In en, this message translates to:
  /// **'Row'**
  String get rowLabel;

  /// Label for logical column input
  ///
  /// In en, this message translates to:
  /// **'Column'**
  String get colLabel;

  /// Label for the explore navigation
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// Label for the bookings navigation
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get bookings;

  /// Label for the check-in action
  ///
  /// In en, this message translates to:
  /// **'Check-in'**
  String get checkIn;

  /// Label for the my vehicle navigation
  ///
  /// In en, this message translates to:
  /// **'My Vehicle'**
  String get myVehicle;

  /// Title for the nearby parking lots section
  ///
  /// In en, this message translates to:
  /// **'Nearby Parking Lots'**
  String get nearbyLots;

  /// Text showing distance to a parking lot
  ///
  /// In en, this message translates to:
  /// **'{distance}m away'**
  String metersAway(String distance);

  /// Text showing distance to a parking lot in kilometers
  ///
  /// In en, this message translates to:
  /// **'{distance}km away'**
  String kmAway(String distance);

  /// Text shown when no parking lots are found nearby
  ///
  /// In en, this message translates to:
  /// **'No parking lots found nearby.'**
  String get noLotsNearby;

  /// Title for the top recommended parking lots section
  ///
  /// In en, this message translates to:
  /// **'Top Recommended P-Spots'**
  String get topRecommended;

  /// Text for the see all button
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// Text showing the number of available parking slots
  ///
  /// In en, this message translates to:
  /// **'{count} available'**
  String availableSlotsCount(String count);

  /// Error message when a vehicle with the same plate already exists
  ///
  /// In en, this message translates to:
  /// **'A vehicle with this license plate is already registered.'**
  String get vehicleAlreadyExists;

  /// Error message when a vehicle is not found
  ///
  /// In en, this message translates to:
  /// **'Vehicle not found.'**
  String get vehicleNotFound;

  /// Error message when a payment method is not found
  ///
  /// In en, this message translates to:
  /// **'Payment method not found.'**
  String get paymentMethodNotFound;

  /// Error message when no slots are available for reservation
  ///
  /// In en, this message translates to:
  /// **'No available slots in this parking lot.'**
  String get reservationNoAvailableSlots;

  /// Error message when a specific slot is already taken
  ///
  /// In en, this message translates to:
  /// **'This parking slot is already occupied.'**
  String get reservationSlotOccupied;

  /// Error message when a reservation slot ID is invalid
  ///
  /// In en, this message translates to:
  /// **'Parking slot not found.'**
  String get reservationSlotNotFound;

  /// Error message when a reservation lot ID is invalid
  ///
  /// In en, this message translates to:
  /// **'Parking lot not found.'**
  String get reservationLotNotFound;

  /// Error message when lot_id is missing for auto reservation
  ///
  /// In en, this message translates to:
  /// **'Please select a parking lot for automatic slot selection.'**
  String get reservationLotIdRequired;

  /// Error message when a camera is not found
  ///
  /// In en, this message translates to:
  /// **'Camera not found.'**
  String get cameraNotFound;

  /// Error message when RTSP URL is missing
  ///
  /// In en, this message translates to:
  /// **'Camera stream URL is not configured.'**
  String get cameraRtspNotConfigured;

  /// Error message when WebRTC negotiation fails
  ///
  /// In en, this message translates to:
  /// **'Failed to establish camera stream connection.'**
  String get cameraWebrtcFailed;

  /// Error message for 403 Forbidden scenarios
  ///
  /// In en, this message translates to:
  /// **'You don\'t have permission to perform this action.'**
  String get permissionDenied;

  /// Label for the language selection
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// English language name
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// Sinhala language name
  ///
  /// In en, this message translates to:
  /// **'සිංහල'**
  String get languageSinhala;

  /// Tamil language name
  ///
  /// In en, this message translates to:
  /// **'தமிழ்'**
  String get languageTamil;

  /// Title for the language settings section
  ///
  /// In en, this message translates to:
  /// **'Display Language'**
  String get languageSectionTitle;

  /// Subtitle for the language selection
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred language'**
  String get languageSubtitle;

  /// Label for the parking history menu item
  ///
  /// In en, this message translates to:
  /// **'Parking History'**
  String get profileParkingHistory;

  /// Subtitle for the parking history menu item
  ///
  /// In en, this message translates to:
  /// **'View your past bookings'**
  String get profileViewPastBookings;

  /// Label for the payment methods menu item
  ///
  /// In en, this message translates to:
  /// **'Payment Methods'**
  String get profilePaymentMethods;

  /// Subtitle for the payment methods menu item
  ///
  /// In en, this message translates to:
  /// **'Manage cards and cash'**
  String get profileManageCards;

  /// Label for the notifications menu item
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get profileNotifications;

  /// Subtitle for the notifications menu item
  ///
  /// In en, this message translates to:
  /// **'Alerts and updates'**
  String get profileAlertsUpdates;

  /// Subtitle for the logout button
  ///
  /// In en, this message translates to:
  /// **'Sign out and secure your data'**
  String get settingsSignOutSubtitle;

  /// Title for the upcoming bookings section
  ///
  /// In en, this message translates to:
  /// **'Upcoming Bookings'**
  String get upcomingBookings;

  /// Title for the previous bookings section
  ///
  /// In en, this message translates to:
  /// **'Previous Bookings'**
  String get previousBookings;

  /// Message shown when no bookings are found
  ///
  /// In en, this message translates to:
  /// **'No bookings found'**
  String get noBookingsFound;

  /// Format for duration in hours and minutes
  ///
  /// In en, this message translates to:
  /// **'{hours}h {minutes}m'**
  String durationHours(String hours, String minutes);

  /// Label for the ticket ID
  ///
  /// In en, this message translates to:
  /// **'Ticket ID: {id}'**
  String ticketId(String id);

  /// Format for LKR amount
  ///
  /// In en, this message translates to:
  /// **'LKR {amount}'**
  String lkrAmount(String amount);

  /// Label for active reservation status
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get statusActive;

  /// Label for completed reservation status
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get statusCompleted;

  /// Label for cancelled reservation status
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get statusCancelled;

  /// Header for the current active booking
  ///
  /// In en, this message translates to:
  /// **'Current Ongoing Booking'**
  String get ongoingBooking;

  /// Label for remaining time
  ///
  /// In en, this message translates to:
  /// **'Time Left'**
  String get timeLeft;

  /// No description provided for @baseRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Base Rate (LKR/hr)'**
  String get baseRateLabel;

  /// No description provided for @baseRateHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 50.0'**
  String get baseRateHint;

  /// No description provided for @originalPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Original Price'**
  String get originalPriceLabel;

  /// No description provided for @finalPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Final Price'**
  String get finalPriceLabel;

  /// No description provided for @checkInLabel.
  ///
  /// In en, this message translates to:
  /// **'Check-in'**
  String get checkInLabel;

  /// No description provided for @checkOutLabel.
  ///
  /// In en, this message translates to:
  /// **'Check-out'**
  String get checkOutLabel;

  /// Text showing minutes remaining
  ///
  /// In en, this message translates to:
  /// **'{mins} mins left'**
  String minsLeft(String mins);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'si', 'ta'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'si':
      return AppLocalizationsSi();
    case 'ta':
      return AppLocalizationsTa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
