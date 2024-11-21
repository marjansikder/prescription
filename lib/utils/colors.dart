import 'dart:ui';

class AppColors {
  AppColors._privateConstructor();
  static final AppColors _instance = AppColors._privateConstructor();
  static AppColors get instance => _instance;

  static const kPrimaryColor = Color(0xFF0851DA);
  static const kSecondaryColor = Color(0xFFDCE9FF);
  static const kDrawerColor = Color(0xFFF1F1F5);
  static const kCardColor = Color(0xFFF6F8FC);
  static const kCardColorMobile = Color(0xFFFFFFFF);
  static const kAppBarColor = Color(0xFFF6F8FF);
  static const kAppBarColorMobile = Color(0xFFFFFFFF);
  static const kNavRailColor = Color(0xFFF6F8FF);
  static const kColorSelected = Color(0xffd7e3f8);
  static const kDividerColor = Color(0xFFD9D9D9);
  static const kPopupDividerColor = Color(0xFFF2F4FF);
  static const kBackgroundColor = Color(0xFFF6F6F6);
  static const kIconColor = Color(0xFF1F1F1F);
  static const kIconGrey = Color(0xFF808080);
  static const kWarningColor = Color(0xFFFFC107);
  static const kBgDarkColor = Color(0xFFEBEDFA);
  static const kBadgeColor = Color(0xFFEB5463);
  static const kRedColor = Color(0xFFE85555);
  static const kGreenColor = Color(0xFF00AB6D);
  static const kLightGreenColor = Color(0xFFD0F1E5);
  static const kYellowColor = Color(0xFFFFA911);
  static const kLightYellowColor = Color(0xFFFFECCB);
  static const kGreyColor = Color(0xFFD5D5D5);
  static const kBlackColor = Color(0xFF000000);
  static const kWhiteColor = Color(0xFFFFFFFF);
  static const kBorderColor = Color(0xFFD8D8D8);
  static const kHomeItemBorderColor = Color(0xFFE5E5E5);
  static const kButtonTextColor = Color(0xFFFFFFFF);
  static const kTitleTextColor = Color(0xFF30384D);
  static const kCardBorderColor = Color(0xffD3DAFF);
  static const kIconBtnBgColor = Color(0xffE1E6FF);
  static const kBottomBorderColor = Color(0xffD8D8D8);
  static const kPrimaryButtonColor = Color(0xff00AB6D);
  static const kGreyButtonColor = Color(0xffA4A6A8);
  static const kCircleBorderColor = Color(0xffD2EAFF);
  static const kSelectedItemColor = Color(0xffD2EAFF);
  static const kLabelTextColor = Color(0xFF282B31);
  static const kTextColor = Color(0xFF282B31);
  static const kTextGreyColor = Color(0xFF737373);
  static const kErrorTextColor = Color(0xFFE85555);
  static const kHintTextColor = Color(0xFFD9D9D9);

  static const kNormalToastTextColor = Color(0xFFFFFFFF);
  static const kNormalToastBgColor = Color(0xFF1F1F1F);
  static const kSuccessToastTextColor = Color(0xFF00C30C);
  static const kSuccessToastBgColor = Color(0xFFE8F9F1);
  static const kErrorToastTextColor = Color(0xFFEB9292);
  static const kErrorToastBgColor = Color(0xFFF5DCDC);
  static const kWarningToastTextColor = Color(0xFFFFA911);
  static const kWarningToastBgColor = Color(0xFFFFECCB);

  static const kFollowupText = Color(0xff28A745);
  static const kFollowupBackground = Color(0xFFDFFDE6);
  static const kNewText = Color(0xff1068eb);
  static const kNewBackground = Color(0xFFD2EAFF);
  static const kReportBackground = Color(0xFFA59F9F);
  static const kDisableColor = Color(0xFFD1D1D1);

  static const kAttendButton = Color(0xff1068eb);
  static const kSegmentButton = Color(0xff1068eb);
  static const kSegmentButtonText = Color(0xFF737373);
  static const kDisableButton = Color(0xFFD8D8D8);
  static const kSelectedSlot = Color(0xFF1068EB);

  static const kDarkPowderBlue = Color(0xffa4b8ff);
  static const kScheduleBorder = Color(0xff1068eb);
  static const kButtonText = Color(0xFF282B31);
  static const kWaitingButton = Color(0xFFD3DAFF);
  static const kWaitingButtonBorder = Color(0xFF1068EB);

  static const kOrgHeader = Color(0xFF1068EB);
  static const kDivider = Color(0xFFD9D9D9);
  static const kAccept = Color(0xFF00AB6D);
  static const kReject = Color(0xFFEB5463);
  static const kDateTime = Color(0xFF808080);
  static const kTrophyColor = Color(0xFF00D689);
  static const kTrophyIncompleteColor = Color(0xFF979797);
  static const kTrophyIncompleteCircleColor = Color(0xFFE1E1E1);
  static const kProgressBarColor = Color(0xFFFFBC25);
  static const kChipBackgroundColor = Color(0xFFE7F0FF);

  static const kStartCallColor = Color(0xFF00BF8A);
  static const kRxFavouriteColor = Color(0xFFFFA911);
  static const kSaveButton = Color(0xFF00AB6D);

  static const kFilterPrimary = ColorFilter.mode(kPrimaryColor, BlendMode.srcIn);
  static const kFilterButton = ColorFilter.mode(kButtonText, BlendMode.srcIn);
  static const kFilterText = ColorFilter.mode(kTextColor, BlendMode.srcIn);
  static const kFilterHint = ColorFilter.mode(kHintTextColor, BlendMode.srcIn);

  static const kBlankMsgBackground = Color(0xFFD2EAFF);
  static const kSkyButtonButton = Color(0xFF1068EB);
  static const kFemale = Color(0xFFEC49A6);
  static const kMale = Color(0xFF02A3FE);
  static const colorAccentLightFade = Color(0xffFDF1EE);

  static const kPending = Color(0xFFFFA911);
  static const kConfirm = Color(0xFF00AB6D);
  static const kComplete = Color(0xFF1068EB);
  static const kCancel = Color(0xFFEB5463);
  static const kWaiting = Color(0xFF535050);
  static const kStatus = Color(0xFF979797);

  static const kPrescription = Color(0xFFF2F2FE);
  static const kReport = Color(0xFFFFF6F6);
  static const kPowderBlue = Color(0xFFDFEBFF);
  static const kPowderBlue2 = Color(0xFFD3DAFF);
  static const kChipDisabled = Color(0xFFEDEDED);
  static const kBooked = Color(0xFF979797);

  static const kFavDrug = Color(0xFFFFFBED);
  static const kInactiveDrugBackground = Color(0xFFFFECCB);
  static const kOnlineBackground = Color(0xFFE3FAE8);
  static const kOfflineBackground = Color(0xFF535050);
  static const kOfflineBackground2 = Color(0xFFD9D9D9);
  static const kSkyBlue = Color(0xFFE7F0FF);
  static const kReady = Color(0xFF00AB6D);
  static const kInProgress = Color(0xFF63D429);
  static const kTypeAheadDisabled = Color(0xFFF2F2F2);
  static const kdurgDetails = Color(0xFF76A9FF);
  static const tabSelectedColor = Color(0xFF226CC3);
  static const ratingCountNumber = Color(0xFF4A4A4A);
  static const colorPest = Color(0xff4BCDE1);
  static const tealLightColor = Color(0xff1F93C3);
}

List<Color> randomBackgroundColors = [
  const Color(0xFFCCE5FF), // light blue
  const Color(0xFFD7F9E9), // pale green
  const Color(0xFFFFF8E1), // pale yellow
  const Color(0xFFF5E6CC), // beige
  const Color(0xFFFFD6D6), // light pink
  const Color(0xFFE5E5E5), // light grey
  const Color(0xFFFFF0F0), // pale pink
  const Color(0xFFE6F9FF), // pale blue
  const Color(0xFFD4EDDA), // mint green
  const Color(0xFFFFF3CD), // pale orange
];
