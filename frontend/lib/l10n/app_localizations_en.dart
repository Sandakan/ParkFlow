// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'ParkFlow';

  @override
  String get loginTitle => 'ParkFlow';

  @override
  String get welcomeBackSubtitle => 'Welcome back! Sign in to your account.';

  @override
  String get signInToContinue => 'Sign in to continue';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get emailHint => 'you@example.com';

  @override
  String get passwordHint => '••••••••';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get loginButton => 'Login';

  @override
  String get signInButton => 'Sign In';

  @override
  String get dontHaveAccount => 'Don\'t have an account? ';

  @override
  String get signUp => 'Sign up';

  @override
  String get createAccountTitle => 'Create Account';

  @override
  String get signUpSubtitle => 'Sign up to get started!';

  @override
  String get fullNameLabel => 'Full Name';

  @override
  String get fullNameHint => 'John Doe';

  @override
  String get nameRequired => 'Name is required';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get confirmPasswordRequired => 'Confirm Password is required';

  @override
  String get passwordsMustMatch => 'Passwords must match';

  @override
  String get signUpButton => 'Sign Up';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get signIn => 'Sign in';

  @override
  String get liveDashboard => 'ParkFlow Live Dashboard';

  @override
  String get liveFeed => 'Live Feed';

  @override
  String get occupied => 'Occupied';

  @override
  String get available => 'Available';

  @override
  String get logoutTooltip => 'Logout';

  @override
  String get checkInternetConnection =>
      'Please check your internet connection and try again.';

  @override
  String get somethingWrongDescription =>
      'Something went wrong. Please try again later.';

  @override
  String get authTokenExpiredError =>
      'Your session has expired. Please log in again.';

  @override
  String get sessionExpired => 'Session expired';

  @override
  String get invalidPageNumber => 'Invalid page number';

  @override
  String get currentPasswordInvalid => 'Current password is not valid';

  @override
  String get changePasswordFailed => 'Failed to change password';

  @override
  String get emailRequired => 'The email must not be empty';

  @override
  String get emailInvalid => 'The email value must be a valid email';

  @override
  String get passwordRequired => 'The password must not be empty';

  @override
  String get passwordMinLength =>
      'The password must be at least 6 characters long';

  @override
  String get invalidCredentials =>
      'The email or password you entered is incorrect';

  @override
  String get adminDashboard => 'Home';

  @override
  String get adminWelcome => 'Welcome, Administrator';

  @override
  String get home => 'Home';

  @override
  String get profile => 'Profile';

  @override
  String get guest => 'Guest';

  @override
  String get logout => 'Logout';

  @override
  String get adminConsoleSubtitle => 'ParkFlow Administration Console';

  @override
  String get manageSlots => 'Manage Parking Slots';

  @override
  String get featureComingSoon => 'Manage Slots feature coming soon!';

  @override
  String get parkingLots => 'Lots';

  @override
  String get cameras => 'Cameras';

  @override
  String get analytics => 'Analytics';

  @override
  String get settings => 'Settings';

  @override
  String get searchLotHint => 'Search parking lots...';

  @override
  String get createNewLot => 'Create Parking Lot';

  @override
  String get statusOpen => 'Open';

  @override
  String get statusClosed => 'Closed';

  @override
  String get totalSlotsLabel => 'Total Slots';

  @override
  String get revenueToday => 'Revenue Today';

  @override
  String get noLotsFound => 'No parking lots found';

  @override
  String get errorLoadingLots => 'Error loading lots';

  @override
  String get createLotTitle => 'Create New Parking Lot';

  @override
  String get lotNameLabel => 'Lot Name';

  @override
  String get lotNameHint => 'Downtown Parking';

  @override
  String get lotAddressLabel => 'Lot Address';

  @override
  String get lotAddressHint => '123 Main St';

  @override
  String get latitudeLabel => 'Latitude';

  @override
  String get latitudeHint => '0.000';

  @override
  String get longitudeLabel => 'Longitude';

  @override
  String get longitudeHint => '0.000';

  @override
  String get totalSlotsHint => 'Number of slots';

  @override
  String get rtspUrlLabel => 'RTSP URL';

  @override
  String get rtspUrlHint => 'rtsp://...';

  @override
  String get createButton => 'Create';

  @override
  String get lotCreatedSuccess => 'Parking lot created successfully';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get invalidNumber => 'Invalid number';

  @override
  String get editLotTitle => 'Edit Parking Lot';

  @override
  String get updateButton => 'Update';

  @override
  String get lotUpdatedSuccess => 'Parking lot updated successfully';

  @override
  String get deleteLot => 'Delete Lot';

  @override
  String get deleteLotConfirmTitle => 'Delete Parking Lot?';

  @override
  String get deleteLotConfirmMessage =>
      'Are you sure you want to delete this parking lot? This action cannot be undone.';

  @override
  String get deleteButton => 'Delete';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get lotDeletedSuccess => 'Parking lot deleted successfully';

  @override
  String get camerasTabLabel => 'Cameras';

  @override
  String get searchCameraHint => 'Search cameras...';

  @override
  String get createNewCamera => 'Create Camera';

  @override
  String get noCamerasFound => 'No cameras found';

  @override
  String get errorLoadingCameras => 'Error loading cameras';

  @override
  String get rtspHealth => 'Health';

  @override
  String get statusConnected => 'Connected';

  @override
  String get statusDisconnected => 'Disconnected';

  @override
  String get createCameraTitle => 'Create New Camera';

  @override
  String get cameraNameLabel => 'Camera Name';

  @override
  String get cameraNameHint => 'Front Gate';

  @override
  String get cameraCreatedSuccess => 'Camera created successfully';

  @override
  String get userAlreadyExists =>
      'The user with this email already exists in the system.';

  @override
  String get analyticsTitle => 'Analytics';

  @override
  String get analyticsOverview => 'System Vitals';

  @override
  String get analyticsTotalCapacity => 'Total Capacity';

  @override
  String get analyticsOccupancy => 'Current Occupancy';

  @override
  String get analyticsStreamHealth => 'Stream Health';

  @override
  String get analyticsAvgDwell => 'Avg. Dwell Time';

  @override
  String get analyticsDwellUnit => 'min';

  @override
  String get analyticsOccupancyTrend => 'Occupancy Trends';

  @override
  String get analyticsPeriod24h => '24h';

  @override
  String get analyticsPeriod7d => '7d';

  @override
  String get analyticsPeriod30d => '30d';

  @override
  String get analyticsTodayLabel => 'Today';

  @override
  String get analyticsPriorLabel => 'Prior Period';

  @override
  String get analyticsTurnoverRate => 'Turnover Rate';

  @override
  String get analyticsTurnoverToday => 'Turnover Today';

  @override
  String get analyticsAiHealth => 'AI Engine Health';

  @override
  String get analyticsConfidenceMean => 'Detection Confidence';

  @override
  String get analyticsCpuLoad => 'CPU Load';

  @override
  String get analyticsInferenceLatency => 'Inference Latency';

  @override
  String get analyticsNoData => 'No data yet';

  @override
  String get analyticsRefresh => 'Refresh';

  @override
  String get analyticsSlots => 'slots';

  @override
  String get analyticsOccupied => 'occupied';

  @override
  String get analyticsVacant => 'vacant';

  @override
  String get analyticsCameras => 'cameras active';

  @override
  String get analyticsOccupancyTrendSubtitle =>
      'Occupancy over time vs. prior period';

  @override
  String get analyticsSampleCount => 'samples';

  @override
  String get analyticsFinancials => 'Financials';

  @override
  String get analyticsRevenueToday => 'Revenue Today';

  @override
  String get analyticsRevenueMonth => 'Revenue Month';

  @override
  String get analyticsRevenueUnit => 'LKR';

  @override
  String get analyticsOperationalImpact => 'Operational Impact';

  @override
  String get analyticsRevenueTrend => 'Revenue Trend';
}
