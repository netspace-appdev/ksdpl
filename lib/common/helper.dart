import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;

class AppText{
  static const String brandName="KSDPL";

  static const String home="Home";
  static const String category="Category";
  static const String all="All";
  static const String cart="Cart";
  static const String sc_home="Science Home";
  static const String search="Search";
  static const String viewAll="View All";
  static const String latestProduct="Latest Product";
  static const String noData="No Data Found";
  static const String products="Products";
  static const String mobileNumber="Mobile Number";
  static const String password="Password";
  static const String submit="Submit";
  static const String phoneNumberRequired="Mobile number is required";
  static const String enterValidPhone="Enter a valid 10-digit phone number";
  static const String passwordRequired="Password is required";
  static const String password6characters="'Password must be at least 6 characters";
  static const String somethingWentWrong="Something went wrong";
  static const String lenderPanel="Lender Panel";
  static const String signIn="Sign in";
  static const String registration="Registration";

  static const String employeeID="Employee ID*";
  static const String lenderName="Lender Name*";
  static const String contactNo="Contact No. (Use for Login)*";
  static const String whatsappNo="Whatsapp No.*";
  static const String email="Email*";
  static const String passwordStar="Password*";
  static const String alreadyRegistered="Are you already registered? ";
  static const String login="Login";
  static const String dontHaveAccount ="Don't have an account? ";
  static const String registerHere ="Register here";

  static const String bank ="Bank*";
  static const String branch ="Branch*";
  static const String roleLevel="Role Level*";
  static const String role ="Role*";
  static const String functionalSupervisorName ="Functional Supervisor Name*";
  static const String functionalSupervisorMobile ="Functional Supervisor Mobile No";
  static const String functionalSupervisorEmail ="Functional Supervisor Email";
  static const String administrativeSupervisorName ="Administrative Supervisor Name*";
  static const String administrativeSupervisorMobile="Administrative Supervisor Mobile No";
  static const String administrativeSupervisorEmail ="Administrative Supervisor Email";
  static const String agreeTerms="Agree with the terms and conditions ?";
  static const String termsConditions ="Terms and conditions";

  static const String unknownFunctionalSupervisor ="Unknown Functional Supervisor";
  static const String unknownAdminSupervisor ="Unknown Admin Supervisor";
  static const String unknownContact ="Unknown Contact Number";
  static const String unknownEmail ="Unknown Emailr";
  static const String noTokenFound ="No token found. Please login again.";
  static const String noOptions ="No options available";
  static const String weakPassword ="Password must be at least 8 characters long, contain an uppercase letter, a lowercase letter, and a special character.";
  static const String medium ="Medium";
  static const String strong ="Strong";
  static const String validEmailWarning ="Please enter a valid official email address (e.g., user@company.com). Public domains like gmail.com or yahoo.com are not allowed";
  static const String iAgreeTC ="I agree to the Terms and Conditions";
  static const String companyHeader ="KSDPL";
  static const String registrationsuccessfulMsg ="Lender registration successful. Please wait for verification.";
  static const String ok ="Ok";
  static const String message ="Message";
  static const String pleaseSelectBank ="Please select a bank";
  static const String pleaseSelectBranch ="Please select a branch";
  static const String pleaseSelectRoleLevel ="Please select a role level";
  static const String pleaseSelectRole ="Please select a role";
  static const String pleaseSelectFunctionalSupervisor ="Please select a Functional Supervisor";
  static const String pleaseSelectFuncSupervisor ="Please select a Functional Supervisor";
  static const String pleaseSelectAdminSupervisor ="Please select a Admin Supervisor";
  static const String pleaseSelectTnC ="Please select Terms and conditions";
  static const String phoneInUse ="This phone number is already in use";

  static const String manageProfile ="Manage Profile";
  static const String editProfile ="Edit Profile";
  static const String changePassword ="Change Password";
  static const String lenderCode ="Lender Code";
  static const String oldPassword ="Old Password*";
  static const String newPassword ="New Password*";
  static const String confirmPassword ="Confirm Password*";
  static const String passwordMustBeSame ="New password and Confirm password must be same";
  static const String oldPasswordRequired="Old password is required";
  static const String newPasswordRequired="New password is required";
  static const String confirmPasswordRequired="Confirm password is required";
  static const String lightTheme="Light Theme";
  static const String darkTheme="Dark Theme";
  static const String systemTheme="System Theme";
  static const String changeTheme="Change Theme";


  static const String sNo="S No";
  static const String branchName="Branch Name";
  static const String IFSC="IFSC";
  static const String phoneNo="Phone No";
  static const String mobNo="Mobile No";
  static const String eml="Email Address";
  static const String state="State";
  static const String district="District";
  static const String city="City";
  static const String mICRCode="MICR Code";
  static const String zipCode="Zip Code";
  static const String address="Address";
  static const String branchCode="Branch Code";
  static const String noDataFound="No data found";
  static const String clearFilters="Clear Filters";
  static const String clearSort="Clear Sort";
  static const String showAllColumns="Show all columns";
  static const String hideBranchNameColumn="Hide Branch Name Column";
  static const String sortBrNameAsc="Sort by Branch Name ascending";
  static const String sortBrNameDsc="Sort by Branch Name descending";
  static const String sort="Sort";
  static const String ascending="ascending";
  static const String descending="descending";
  static const String hide="Hide";
  static const String column="Column";

  static const String manageBranches="Manage Branches";
  static const String branchList="Branch List";
  static const String manageEnforcement="Manage Enforcement";
  static const String uploadCommonTask="Upload Common Task";
  static const String uctList="Upload Common Task List";
  static const String uploadExcel="Upload Excel";
  static const String noFileSelected="No file selected";
  static const String chooseExcel="Please choose an Excel file (.xlsx, .xls) to upload.";
  static const String selectedFile="Selected File:";
  static const String noFileChosen="No File Chosen";
  static const String chooseFile="Chosen File";
  static const String preview="Preview";

  static const String enterAccDetails="Enter your account details below";
  static const String createNewAccount="Create new account";
  static const String forgotYourPassword="Forgot your password?";
  static const String dashboard="Dashboard";
  static const String companyProfile="Company Profile";
  static const String companyName="Company Name";
  static const String founderName="Founder Name";
  static const String ceoName="CEO Name";
  static const String tagline="Tagline";
  static const String foundingDate="Founding Date";
  static const String headquartLocation="Headquarters Location";
  static const String emailNoStar="Email";
  static const String phoneNumberNoStar="Phone Number";
  static const String whatsappNoNoStar="WhatsApp Number";
  static const String fax="Fax";
  static const String website="Website URL";
  static const String linkedIn="LinkedIn";
  static const String facebook="Facebook";
  static const String twitter="Twitter";
  static const String companyAddress="Company Address";
  static const String gstNumber="GST Number";
  static const String panNumber="PAN Number";
  static const String cinNumber="CIN Number";
  static const String mapIntegration="Map Integration (Embed Code)";
  static const String privacyPolicy="Privacy Policy";
  static const String tncController="Terms and Conditions";
  static const String companyLogo="Company Logo";

  static const String leads="Manage Leads";
  static const String leadList="Lead List";
  static const String myProfile="My Profile";
  static const String logout="Logout";
  static const String notification="Notification";
  static const String percentageRequired="Percentage is required";
  static const String leadDetails="Lead Details";
  static const String addLead="Add Lead";
  static const String fullName="Full Name";
  static const String enterFullName="Enter Full Name";
  static const String dateOfBirth="Date of Birth*";
  static const String enterPhNumber="Enter Phone Number";
  static const String lar="Loan Amount Requested";
  static const String enterLar="Enter Loan Amount Requested";
  static const String enterEA="Enter Email Address";
  static const String aadhar="Aadhar";
  static const String enterAadhar="Enter Aadhar";
  static const String enterPan="Enter PAN";
  static const String streetAdd="Street Address";
  static const String enterStreetAdd="Enter Street Address";
  static const String enterZipCode="Enter Zip Code";
  static const String nationality="Nationality";
  static const String enterNationality="Nationality";
  static const String employerName="Employer Name";
  static const String enterEmployerName="Enter Employer Name";
  static const String monIncome="Monthly Income(Gross Income)";
  static const String enterMonIncome="Enter Monthly Income";
  static const String addIncome="Additional Source of Income";
  static const String enterAddIncome="Enter Additional Income";
  static const String brLoc="Branch Location";
  static const String productTypeInt="Product Type Interested";
  static const String enterBrLoc="Enter Branch Location";
  static const String conName="Connector Name";
  static const String conMob="Connector Mobile";
  static const String conShare="Connector Share %";
  static const String enterConName="Enter Connector Name";
  static const String enterConMob="Enter Connector Mobile";
  static const String enterConShare="Enter Connector Share %";
  static const String mmddyyyy="mm/dd/yyyy";
  static const String preferredBank="Preferred Bank for Loan";
  static const String connector="Connector";
  static const String gender="Gender";
  static const String existingRelationship="Existing Relationship with Bank?";
  static const String currEmpSt="Current Employement Status";
  static const String employed="Employed";
  static const String selfEmployed="Self-Employed";
  static const String unemployed="Unemployed";
  static const String retired="Retired";
  static const String student="Student";
  static const String upcomingBirthdays="🎉 Upcoming Birthdays 🎉";
  static const String sendWishes="Send Wishes";
  static const String noBirhday="No upcoming birthdays";
  static const String loanAppl="Loan Application";
  static const String coApplDetails="Co-Applicant Details";
  static const String fathersName="Father's Full Name";
  static const String enterFathersName = "Enter Father's Name";
  static const String qualification = "Qualification";
  static const String enterQualification = "Enter Qualification";
  static const String maritalStatus = "Marital Status";
  static const String enterMaritalStatus = "Enter Marital Status";
  static const String employmentStatus = "Employment Status";
  static const String enterEmploymentStatus = "Enter Employment Status";
  static const String occupation = "Occupation";
  static const String enterOccupation = "Enter Occupation";
  static const String occupationSector = "Occupation Sector";
  static const String enterOccupationSector = "Enter Occupation Sector";
  static const String whatsappMsg = "Hello! We belong to KSDPL...";
  static const String couldNotCall = "Could not make a call";
  static const String couldNotWA = "Could not open WhatsApp";
  static const String couldNotMsg = "Could not open Messages";
  static const String openPollFilter = "Open Poll";
  static const String openPollLeads = "Open Poll Leads";
  static const String followup = "Follow Up";
  static const String history = "History";
  static const String details = "Details";
  static const String openPoll = "Open Poll";
  static const String interested = "Interested";
  static const String notInterested = "Not Interested";
  static const String doable = "Doable";
  static const String notDoable = "Not Doable";
  static const String leadHistory = "Lead History";
  static const String setFollowup = "Set Follow Up";
  static const String selectDate = "Select Date";
  static const String selectTime = "Select Time";
  static const String enterDetails = "Enter Follow-up details";
  static const String addFeedback = "Add Feedback";
  static const String callFeedback = "Call Feedback / Follow up Note";
  static const String leadFeedback = "Lead Feedback";
  static const String enterCallFeedback = "Enter the details";
  static const String enterLeadFeedback = "Enter Lead Feedback";
  static const String addFeedbackFirst = "Add feedback first";
  static const String settings = "Settings";
  static const String aboutUs = "About Us";
  static const String callReminder = "Call Reminder";
  static const String addFAndF = "Add Feedback & Followup";
  static const String noReminder = "No Reminder";
  static const String addFollowUp = "Add Follow-up";
  static const String followupNote = "Followup Note";
  static const String addDetailsFirst = "Add details first";
  static const String upcomingFollowUp = "Upcoming Follow up";
  static const String campaign = "Campaign";
  static const String customdash = "customDash";
  static const String allReminders = "All Reminders";
  static const String fillLeadForm = "Fill Lead form";
  static const String existingLoans = "Existing Loans";
  static const String noOfExistingLoans = "No. of Existing Loans";
  static const String enterExistingLoans = "Enter Existing Loans";
  static const String enterNoOfExistingLoans = "Enter No. of Existing Loans";
  static const String couldntConneect = "Couldn't connect";
  static const String ksdplBr = "KDSPL Branch";
  static const String searchLeads = "Search Leads";
  static const String fromDate = "From Date";
  static const String toDate = "To Date";
  static const String ddmmyyyy = "dd/mm/yyyy";
  static const String searchedLeads = "Searched Leads";
  static const String leadStage = "Lead Stage";
  static const String changeLeadStatus = "Change Status";
  static const String personInformation = "Person Information";
  static const String applFNmae = "Applicant's Full Name";


  static const String dsaCode = "DSA Code";
  static const String enterDsaCode = "Enter DSA Code";
  static const String loanApplicationNo = "Loan Application No";
  static const String enterLoanApplicationNo = "Enter Loan Application No";
  static const String bankNostar ="Bank";
  static const String brNostar ="Branch";
  static const String selectBank = "Select your Bank name";
  static const String selectBranch = "Select your Branch";
  static const String loanType = "Type of Loan";
  static const String selectLoanType = "Select your Loan Type";
  static const String panCardNo = "PAN Card Number";
  static const String enterPanCardNo = "Enter PAN Card Number";
  static const String aadharCardNo = "Aadhar Card Number";
  static const String enterAadharCardNo = "Enter Aadhar Card Number";
  static const String loanAmountApplied = "Loan Amount Applied";
  static const String enterLoanAmountApplied = "Enter Loan Amount Applied";
  static const String dsaStaffName = "DSA Staff Name";
  static const String enterDsaStaffName = "Enter DSA Staff Name";
  static const String uniqueLeadNumber = "Unique Lead Number";
  static const String enterUniqueLeadNumber = "Enter Unique Lead Number";
  static const String channel = "Channel";
  static const String selectChannel = "Select your Channel";
  static const String channelCode = "Channel Code";
  static const String enterChannelCode = "Enter Channel Code";
  static const String processingFee = "Processing Fee";
  static const String enterProcessingFee = "Enter Processing Fee";
  static const String chqDdSlipNo = "CHQ/DD Slip No";
  static const String enterChqDdSlipNo = "Enter CHQ/DD Slip No";
  static const String processingFeeDate = "Processing Fee Date";
  static const String enterProcessingFeeDate = "mm/dd/yyyy";
  static const String loanPurpose = "Loan Purpose";
  static const String enterLoanPurpose = "Enter Loan Purpose";
  static const String scheme = "Scheme";
  static const String enterScheme = "Enter Scheme";
  static const String repaymentType = "Repayment Type";
  static const String enterRepaymentType = "Enter Repayment Type";
  static const String loanTenure = "Loan Tenure (Years)";
  static const String enterLoanTenure = "Enter Loan Tenure in Years";
  static const String monthlyInstallment = "Monthly Installment";
  static const String enterMonthlyInstallment = "Enter Monthly Installment";
  static const String previousLoanApplied = "Previous Loan Applied";

  static const String applicantEmployerDetails = "Applicant's Employer Details";
  static const String organizationName = "Organization Name";
  static const String enterOrganizationName = "Enter Organization Name";
  static const String ownershipType = "Ownership Type";
  static const String selectOwnershipType = "Select Ownership Type";
  static const String natureOfBusiness = "Nature of Business";
  static const String enterNatureOfBusiness = "Enter Nature of Business";
  static const String staffStrength = "Staff Strength";
  static const String enterStaffStrength = "Enter Staff Strength";
  static const String salaryDate = "Salary Date";
  static const String enterSalaryDate = "mm/dd/yyyy";
  static const String presentAddress = "Present Address";
  static const String houseFlatNo = "House/Flat No";
  static const String enterHouseFlatNo = "Enter House/Flat No";
  static const String buildingNo = "Building No";
  static const String enterBuildingNo = "Enter Building No";
  static const String societyName = "Society Name";
  static const String enterSocietyName = "Enter Society Name";
  static const String locality = "Locality";
  static const String enterLocality = "Enter Locality";
  static const String streetName = "Street Name";
  static const String enterStreetName = "Enter Street Name";
  static const String pinCode = "Pin Code";
  static const String enterPinCode = "Enter Pin Code";
  static const String selectState = "Select your State";
  static const String selectDistrict = "Select your District";
  static const String selectCity = "Select your City";
  static const String taluka = "Taluka";
  static const String enterTaluka = "Enter Taluka";
  static const String country = "Country";
  static const String presentAdd = "Present Address";
  static const String permanentAdd = "Permanent Address";
  static const String coApplicantDetails = "Co-Applicant Details";
  static const String propertyDetails = "Property Details";
  static const String propertyId = "Property ID";
  static const String enterPropertyId = "Enter Property ID";
  static const String surveyNo = "Survey No";
  static const String enterSurveyNo = "Enter Survey No";
  static const String finalPlotNo = "Final Plot No";
  static const String enterFinalPlotNo = "Enter Final Plot No";
  static const String blockNo = "Block No";
  static const String enterBlockNo = "Enter Block No";
  static const String socBuildName = "Society/Building Name";
  static const String familyMember = "Family Member";
  static const String name = "Name";

  static const String relWithAppl = "Relation with Applicant ";
  static const String enterRelWithAppl = "Enter Relation with Applicant";
  static const String dependent = "Dependent ";
  static const String monthlyIncome  = "Monthly Income";
  static const String enterMonthlyIncome = "Enter Monthly Income ";
  static const String EmployedWith = "Employed with";
  static const String enterEmployedWith = "Enter Employed with";

  static const String creditCard = "Credit Card";
  static const String companyBank = "Company Bank";
  static const String enterCompanyBank = "Enter Company Bank";
  static const String cardNumber = "Card Number";
  static const String enterCardNumber = "Enter Card Number";
  static const String havingSince = "Having Since";
  static const String avgMonSpencing = "Average Monthly Spending";
  static const String enterAvgMonSpencing = "Enter Average Monthly Spending";

  static const String financialDetails = "Financial Details";
  static const String grossMonthlySalary = "Gross Monthly Salary";
  static const String enterGrossMonthlySalary = "Enter Gross Monthly Salary";
  static const String netMonthlySalary = "Net Monthly Salary";
  static const String enterNetMonthlySalary = "Enter Net Monthly Salary";
  static const String annualBonus = "Annual Bonus";
  static const String enterAnnualBonus = "Enter Annual Bonus";
  static const String avgMonOvertime = "Average Monthly Overtime";
  static const String enterAvgMonOvertime = "Enter Average Monthly Overtime";
  static const String enterAvgMonCommission = "Enter Average Monthly Commission";
  static const String avgMonCommission = "Average Monthly Commission";
  static const String monthlyPfDeduction = "Monthly PF Deduction";
  static const String enterMonthlyPfDeduction = "Enter Monthly PF Deduction";
  static const String enterOtherMonthlyIncome = "Enter Other Monthly Monthly";
  static const String otherMonthlyIncome = "Other Monthly Income";

  static const String references = "References";
  static const String enterReferenceName = "Enter Reference Name";
  static const String enterReferenceAdd = "Enter Reference Address";
  static const String enterReferencePhone = "Enter Reference Phone";
  static const String enterReferenceMob = "Enter Reference Mobile";
  static const String loanApplicationForm = "Loan Application Form";
  static const String dateOfBirth2="Date of Birth";
  static const String leadMobileNUmber="Lead Mobile Number";
  static const String enterLeadMobileNUmber="Enter Lead Mobile Number";

  static const String bankerDetails="Banker Details";
  static const String bankerName="Banker Name";
  static const String bankerMobile="Banker Mobile";
  static const String bankerWhatsapp="Banker Whatsapp";
  static const String bankerEmail="Banker Email";

  static const String enterBankerName = "Enter Banker Name";
  static const String enterBankerMobile = "Enter Banker Mobile";
  static const String enterBankerWhatsapp = "Enter Banker Whatsapp";
  static const String enterBankerEmail = "Enter Banker Email";
  static const String manageProducts = "Manage Products";

  ///product
  static const String addProduct = "Add Product";
  static const String collateralSecurityExcluded = "Collateral Security Excluded";
  static const String enterCollateralSecurityExcluded = "Enter Collateral Security Excluded";

  static const String profileExcluded = "Profile Excluded";
  static const String enterProfileExcluded = "Enter Profile Excluded";

  static const String ageLimitEarningApplicants = "Age Limit Earning Applicants";
  static const String enterAgeLimitEarningApplicants = "Enter Age Limit Earning Applicants";
  static const String ageLimitNonEarningCoApplicant = "Age Limit Non-Earning Co-Applicant";
  static const String enterAgeLimitNonEarningCoApplicant = "Enter Age Limit Non-Earning Co-Applicant";
  static const String minAgeEarningApplicants = "Minimum Age Earning Applicants";
  static const String enterMinAgeEarningApplicants = "Enter Minimum Age Earning Applicants";
  static const String minAgeNonEarningApplicants = "Minimum Age Non-Earning Applicants";
  static const String enterMinAgeNonEarningApplicants = "Enter Minimum Age Non-Earning Applicants";
  static const String minIncomeCriteria = "Minimum Income Criteria";
  static const String enterMinIncomeCriteria = "Enter Minimum Income Criteria";

  static const String minLoanAmount = "Minimum Loan Amount";
  static const String maxLoanAmount = "Maximum Loan Amount";

  static const String profitPercentage = "Profit Percentage";
  static const String minCibil = "Minimum CIBIL";
  static const String minTenor = "Minimum Tenor";
  static const String maxTenor = "Maximum Tenor";

  static const String minRoi = "Minimum ROI";
  static const String maxRoi = "Maximum ROI";

  static const String maxTenorEligibilityCriteria = "Maximum Tenor Eligibility Criteria";

  static const String geoLimit = "Geo Limit";
  static const String enterGeoLimit = "Enter Geo Limit";

  static const String negativeProfiles = "Negative Profiles";
  static const String negativeProfilesHint = "Type and press Enter to add";

  static const String negativeAreas = "Negative Areas";
  static const String negativeAreasHint = "Type and press Enter to add";

  static const String minPropertyValue = "Minimum Property Value";
  static const String maxIir = "Maximum IIR";
  static const String maxFoir = "Maximum FOIR";
  static const String maxLtv = "Maximum LTV";

  static const String legalFee = "Legal Fee";
  static const String technicalFee = "Technical Fee";
  static const String adminFee = "Admin Fee";
  static const String foreclosureCharges = "Foreclosure Charges";
  static const String otherCharges = "Other Charges";
  static const String stampDuty = "Stamp Duty";

  static const String tsrYears = "TSR Years";
  static const String tsrCharges = "TSR Charges";
  static const String valuationCharges = "Valuation Charges";

  static const String ksdplProduct = "KSDPL Product";
  static const String selectKsdplProduct = "Select KSDPL Product";

  static const String productValidateFrom = "Product Validate From";
  static const String productValidateTo = "Product Validate To";

  static const String maxTat = "Maximum TAT";

  static const String documentDescriptions = "Document Descriptions";
  static const String documentDescriptionsHint = "Type and press Enter to add";

  static const String productDescriptions = "Product Descriptions";
  static const String productSegment = "Product Segment";

  static const String prodName = "Product Name";
  static const String selectCustomerCategory = "Select Customer Category";
  static const String selectCollateralSecurityCategory = "Select Collateral Security Category";
  static const String selectIncomeType = "Select Income Type";


}

class AppColor{
  static const Color primaryColor=Color(0xff32438e);
  // static const Color secondaryColor=Color(0xffFFCC29);
  static const Color secondaryColor=Color(0xffFF8900);
  static const Color lightGrey=Colors.grey;
  static const Color platinumGrey=Color(0xfffefefe);
  static const Color appBlue=Color(0xfff9ffff);
  static const Color appBlue2=Color(0xffd0fffc);
  static const Color appWhite=Colors.white;
  static const Color backgroundColor=Color(0xffF9F8F8);
  static const Color buttonSelectedColor=Color(0xff65558f);
  static const Color black45=Colors.black45;
  static const Color black54=Colors.black54;
  static const Color black87=Colors.black87;
  static const Color grey200=Color(0xFFE0E0E0);
  static const Color blackColor=Colors.black;
  static const Color redColor=Colors.red;
  static const Color lightYellow=Color(0xFFfef4ea);
  static const Color grey1=Color(0xFF8A7B7B);
  static const Color grey2=Color(0xFF5E5F60);
  static const Color grey3=Color(0xFFEBEBEB);
  // static const Color orangeColor=Color(0xFFFFB057);
  static const Color orangeColor=Color(0xFFFF8900);
/*  static const Color primaryLight=Color(0xFF384F9F);
  static const Color primaryDark=Color(0xFF323F6E);*/
  static const Color primaryLight=Color(0xFF3850A5);
  static const Color primaryDark=Color(0xFF313E6C);
  static const Color black1=Color(0xFF3D3D3D);
  static const Color amberVersion=Color(0x38FFB057);
  static const Color grey4=Color(0xFFE1E1E1);
  static const Color pinkColor=Colors.pink;
  static const Color purpleColor=Colors.purple;
  static const Color tealColor= Colors.teal;
  static const Color bgMore=Color(0xFFFFF6DC);
  static const Color grey700=Color(0xFF616161);
  static const Color lightYellow2=Color(0xFFF5F5F5);
  static const Color borderColor=Color(0xFFDCDADA);
  static const Color blackLight=Color(0xFF3D3D3D);
  static const Color lightGreen=Color(0xFF00B383);
  static const Color lightBrown=Color(0xFF704F38);
  static const Color lightPrimary2=Color(0xFFDEE5FD);
  static const Color lightRed=Color(0xFFf79999);
  static const Color greenColor= Colors.green;




}

class AppFSize{
  static const double mediumFont=15.0;
  static const double largeFont=20.0;
  static const double smallFont=12.0;
}

class AppImage{

  static const String ok="assets/lottie/ok.json";
  static const String drawerIcon="assets/svgIcon/drawerIcon.svg";
  static const String splash="assets/images/logo.png";
  static const String logo1="assets/images/logo1.png";
  static const String intro1="assets/images/intro1.png";
  static const String phoneIcon="assets/images/phoneIcon.png";
  static const String passwordIcon="assets/images/passwordIcon.png";
  static const String bellIcon="assets/images/bellIcon.png";
  static const String searchIcon="assets/images/searchIcon.png";
  static const String offerImage="assets/images/offerImage.png";
  static const String doc="assets/images/doc.png";
  static const String arrow="assets/images/arrow.png";
  static const String addIcon="assets/images/addIcon.png";
  static const String addIconYellow="assets/images/addIcon_yellow.png";
  static const String faq="assets/images/faq.png";
  static const String searchGlass="assets/images/searchGlass.png";
  static const String editImage="assets/images/editImage.png";
  static const String homeIcon="assets/images/homeIcon.png";
  static const String personIcon="assets/images/personIcon.png";
  static const String personYellow="assets/images/personYellow.png";
  static const String settingIcon="assets/images/settingIcon.png";
  static const String settingYellow="assets/images/settingYellow.png";
  static const String peopleGroup="assets/images/peopleGroup.png";
  static const String moreIcon="assets/images/moreIcon.png";
  static const String homeYellow="assets/images/homeYellow.png";
  static const String backDrawer="assets/images/backDrawer.png";
  static const String home2="assets/images/home2.png";
  static const String manInBlack="assets/images/manInBlack.png";
  static const String powerIcon="assets/images/powerIcon.png";
  static const String forwardIcon="assets/images/forwardIcon.png";
  static const String noti_icon="assets/images/noti_icon.png";
  static const String searchIcon2="assets/images/searchIcon2.png";
  static const String filterIcon="assets/images/filterIcon.png";
  static const String call1="assets/images/call1.png";
  static const String chat1="assets/images/chat1.png";
  static const String message1="assets/images/message1.png";
  static const String whatsapp="assets/images/whatsapp.png";
  static const String arrowLeft="assets/images/arrowLeft.png";
  static const String down_arrow="assets/images/down_arrow.png";
  static const String news="assets/images/news.jpg";
  static const String noImage="assets/images/no_image2.png";
  static const String poll_white="assets/images/poll_yellow.png";
  static const String poll_yellow="assets/images/poll_white.png";
  static const String lead_white="assets/images/lead_white.png";
  static const String lead_yellow="assets/images/lead_yellow.png";
  static const String img_not_found="assets/images/img_not_found.jpg";
  static const String webImg="assets/images/webImg.png";
  static const String product="assets/images/product.png";

}

class AppStyles {
  static const TextStyle headerTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodyTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 14,
  );
}
class Helper{
  static Future<void> checkInternet(Future<void> Function() onConnected) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          await onConnected(); // Internet is really available
          return;
        }
      } on SocketException catch (_) {
        // Still no real internet
      }
    }

    ToastMessage.msg("Please check your internet connection");
  }

///Ix
/*  static Future<void> checkInternet(Future<dynamic> callback) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      callback.asStream();
      // callback.call();
    } else {
      Fluttertoast.showToast(msg: "Check Internet connection");
    }
  }*/

  static Widget CustomCNImage(String imageURL, double cHeight, double cWidth){
    return CachedNetworkImage(
      imageUrl: imageURL,//"",//"https://img.freepik.com/free-photo/close-up-portrait-brunette-smiling-woman-looking-confident-front-standing-hoodie-against-white-wall_176420-39066.jpg?t=st=1737785621~exp=1737789221~hmac=e5648802111562bfcb27f8ed3e9c8d2ca70f826e407a1b9007a98e326b455929&w=1380",
      imageBuilder: (context, imageProvider) => Container(
        width: cHeight, // Must be 2 * radius to fit
        //height: cWidth, // Must be 2 * radius to fit
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            /*  colorFilter:
                               ColorFilter.mode(Colors.red, BlendMode.colorBurn)*/
          ),
        ),
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            shape: BoxShape.circle,
          ),
        ),
      ),
      errorWidget: (context, url, error) =>ClipOval(
        child: Container(
          width: 80, // Must be 2 * radius to fit
          height: 80, // Must be 2 * radius to fit
          color: Colors.white,
          child: Icon(Icons.person, size: 40,),
        ),
      ),
    );
  }


  static Widget CustomCNImageBig(String imageURL, double cHeight, double cWidth){
    return CachedNetworkImage(
      imageUrl: imageURL,//"",//"https://img.freepik.com/free-photo/close-up-portrait-brunette-smiling-woman-looking-confident-front-standing-hoodie-against-white-wall_176420-39066.jpg?t=st=1737785621~exp=1737789221~hmac=e5648802111562bfcb27f8ed3e9c8d2ca70f826e407a1b9007a98e326b455929&w=1380",
      imageBuilder: (context, imageProvider) => Container(
        width: cHeight, // Must be 2 * radius to fit
        //height: cWidth, // Must be 2 * radius to fit
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            /*  colorFilter:
                               ColorFilter.mode(Colors.red, BlendMode.colorBurn)*/
          ),
        ),
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey[300],

          ),
        ),
      ),
      errorWidget: (context, url, error) =>Center(
        child: Container(
          width: 200, // Must be 2 * radius to fit
          height: 200, // Must be 2 * radius to fit
          color: Colors.white,
          child: Image.asset(AppImage.img_not_found),
        ),
      ),
    );
  }

  static Map<String, String> splitName(String fullName) {
    List<String> nameParts = fullName.trim().split(' ');

    if (nameParts.length == 1) {
      return {
        'firstName': nameParts[0],
        'lastName': '',
      };
    }

    String firstName = nameParts.sublist(0, nameParts.length - 1).join(' ');
    String lastName = nameParts.last;

    return {
      'firstName': firstName,
      'lastName': lastName,
    };
  }


  static Widget customDivider({
    required color
}){
    return SizedBox(
      height: 10,
      child: Divider(
        color: color,
        height: 10,
      ),
    );
  }

  static String capitalizeEachWord(String text) {
    if (text.isEmpty) return text;
    return text
        .split(' ')
        .map((word) => word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '')
        .join(' ');
  }
  static String formatDate(String dateTime) {


    try {
      // Parse the input date-time string
      DateTime parsedDateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SS").parse(dateTime);

      // Format to "dd-MM-yyyy, HH:mm a"
      return DateFormat("dd-MM-yyyy, HH:mm a").format(parsedDateTime);
    } catch (e) {
      return "Invalid Date Format";
    }
  }
  static String convertToIso8601(String dateString) {
    try {
      // Parse the input date in "MM/dd/yyyy" format
      DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(dateString);

      // Convert to ISO 8601 format with UTC
      return parsedDate.toUtc().toIso8601String(); // returns "2025-04-01T00:00:00.000Z"
    } catch (e) {
      return "Invalid Date Format";
    }
  }
  static String convertFromIso8601(String? isoDateString) {
    try {
      if (isoDateString == null || isoDateString.isEmpty) {
        return ""; // or whatever fallback you want
      }

      DateTime parsedDate = DateTime.parse(isoDateString);
      return DateFormat("yyyy-MM-dd").format(parsedDate.toLocal());
    } catch (e) {
      return "Invalid Date";
    }
  }

  static String convertDateTime(String dateTimeStr) {
    try {
      // Parse the input date-time string
      DateTime parsedDateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(dateTimeStr);

      // Subtract one day
     // parsedDateTime = parsedDateTime.subtract(Duration(days: 1));

      // Format to "dd-MM-yyyy, HH:mm a"
      return DateFormat("dd-MM-yyyy, HH:mm a").format(parsedDateTime);
    } catch (e) {
      return "Invalid Date Format";
    }
  }

  static String birthdayFormat(String dateTime) {
    // Split the string at 'T' to get the date part
    String datePart = dateTime.split('T')[0];

    // Split the date into year, month, and day
    List<String> parts = datePart.split('-');

    // Get the current year
    String currentYear = DateTime.now().year.toString();

    // Return the date in DD-MM-YYYY format with the current year
    return '${parts[2]}-${parts[1]}-$currentYear';
  }
  static String formatTimeAgo(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);

    if (difference.inDays >= 1) {
      // If more than a day, show formatted date & time
      return DateFormat('dd-MM-yyyy, h:mm a').format(dateTime);
    } else {
      // Show relative time like "5 min ago"
      return timeago.format(dateTime, locale: 'en');
    }
  }
  static String formatCallDuration(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    List<String> parts = [];

    if (hours > 0) parts.add("${hours}h");
    if (minutes > 0) parts.add("${minutes}m");
    if (remainingSeconds > 0 || parts.isEmpty) parts.add("${remainingSeconds}s");

    return parts.join(" ");
  }



  static String convertUnixTo12HourFormat(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('h:mm:ss a').format(dateTime); // local time
  }







}


class ToastMessage {
  static void msg(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
        backgroundColor: AppColor.secondaryColor,
        textColor: Colors.white);
  }

  static void alertmsg(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
        backgroundColor: AppColor.primaryColor,
        textColor: Colors.white);
  }
}
