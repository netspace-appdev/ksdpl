import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ksdpl/common/get_header.dart';
import 'dart:convert';
import '../common/base_url.dart';
import 'package:http/http.dart' as http;

import '../common/helper.dart';

class ProductService {

  static const String getAllProductCategory = BaseUrl.baseUrl + 'ProductCategory/GetAllProductCategory';
  static const String addProductList = BaseUrl.baseUrl + 'ProductList/AddProductList';
  static const String getAllProductList = BaseUrl.baseUrl + 'ProductList/GetAllProductList';
  static const String getProductListById = BaseUrl.baseUrl + 'ProductList/GetProductListById';
  static const String getSeniorListById = BaseUrl.baseUrl + 'Employee/GetAllEmployee';
  static const String updateProductList = BaseUrl.baseUrl + 'ProductList/UpdateProductList';
  static const String addProductDocument = BaseUrl.baseUrl + 'ProductList/AddProductDocument';
  static const String getDocumentListByProductId = BaseUrl.baseUrl + 'ProductList/GetDocumentListByProductId';
  static const String getAllNegativeProfileMaster = BaseUrl.baseUrl + 'ProductList/GetAllNegativeProfileMaster';
  static const String getAllCommonDocumentNameList = BaseUrl.baseUrl + 'KsdplProductList/GetAllCommonDocumentNameList';
  static const String getAllVacancyList = BaseUrl.baseUrl + 'VacancyMaster/GetAllVacancy';
  static const String getAllInsuranceIllustrations = BaseUrl.baseUrl + 'CamNoteDetail/GetAllInsuranceIllustrations';
  static const String getProductListByCreatorId = BaseUrl.baseUrl + 'ProductList/GetProductListByCreatorId';
  static const String productActiveDeactive = BaseUrl.baseUrl + 'ProductList/Active-Deactive';




  static Future<Map<String, dynamic>> getAllProductCategoryApi() async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getAllProductCategory),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);


      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit application: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }


  static Future<Map<String, dynamic>> addProductListApi({

    required String KSDPLProductId,
    String? Id,
    String? BankId,
    String? bankers_Name,
    String? Bankers_Mobile_Number,
    String? Bankers_WhatsApp_Number,
    String? BankersEmailId,
    String? Min_CIBIL,
    String? Segment_Vertical,
    String? Product,
    String? ProductDescription,
    String? Customer_Category,
    String? Collateral_Security_Category,
    String? Collateral_Security_Excluded,
    String? Income_Types,
    String? Profile_Excluded,
    String? Age_limit_Earning_Applicants,
    String? Age_limit_Non_Earning_Co_Applicant,
    String? Minimum_age_earning_applicants,
    String? Minimum_age_non_earning_applicants,
    String? Minimum_Income_Criteria,
    String? Minimum_Loan_Amount,
    String? Maximum_Loan_Amount,
    String? Min_Tenor,
    String? Maximum_Tenor,
    String? Minimum_ROI,
    String? Maximum_ROI,
    String? Maximum_Tenor_Eligibility_Criteria,
    String? Geo_Limit,
    String? Negative_Profiles,
    String? Negative_Areas,
    String? Maximum_TAT,
    String? Minimum_Property_Value,
    String? Maximum_IIR,
    String? Maximum_FOIR,
    String? Maximum_LTV,
    String? Processing_Fee,
    String? Legal_Fee,
    String? Technical_Fee,
    String? Admin_Fee,
    String? Foreclosure_Charges,
    String? Processing_Charges,
    String? Other_Charges,
    String? Stamp_Duty,
    String? TSR_Years,
    String? TSR_Charges,
    String? Valuation_Charges,
    String? NoOfDocument,
    String? Product_Validate_From_date,
    String? Product_Validate_To_date,
    String? Profit_Percentage,
    String? docDescr,
    String? FromAmountRange,
    String? ToAmountRange,
    String? TotalOverdueCases,
    String? TotalOverdueAmount,
    String? TotalEnquiries,

    String? SuperiorName,
    String? SuperiorMobileNo,
    String? SuperiorWhatsappNo,
    String? SuperiorEmail,
}) async {
    try {
      print("Negative_Profiles===.${Negative_Profiles}");
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(addProductList),
      );


      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Id', Id,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'BankId', BankId,fallback: "0");
      MultipartFieldHelper.addField(request.fields, 'Bankers_Name', bankers_Name);
      MultipartFieldHelper.addField(request.fields, 'Bankers_Mobile_Number', Bankers_Mobile_Number);
      MultipartFieldHelper.addField(request.fields, 'Bankers_WhatsApp_Number', Bankers_WhatsApp_Number);
      MultipartFieldHelper.addField(request.fields, 'Bankers_email_ID', BankersEmailId);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Min_CIBIL', Min_CIBIL,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Segment_Vertical', Segment_Vertical,fallback: "0");
      MultipartFieldHelper.addField(request.fields, 'Product', Product);
      MultipartFieldHelper.addField(request.fields, 'ProductDescription', ProductDescription);
      MultipartFieldHelper.addField(request.fields, 'Customer_Category', Customer_Category);
      MultipartFieldHelper.addField(request.fields, 'Collateral_Security_Category', Collateral_Security_Category);
      MultipartFieldHelper.addField(request.fields, 'Collateral_Security_Excluded', Collateral_Security_Excluded);
      MultipartFieldHelper.addField(request.fields, 'Income_Types', Income_Types);
      MultipartFieldHelper.addField(request.fields, 'Profile_Excluded', Profile_Excluded);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Age_limit_Earning_Applicants', Age_limit_Earning_Applicants,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Age_limit_Non_Earning_Co_Applicant', Age_limit_Non_Earning_Co_Applicant,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Minimum_age_earning_applicants', Minimum_age_earning_applicants,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Minimum_age_non_earning_applicants', Minimum_age_non_earning_applicants,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Minimum_Income_Criteria', Minimum_Income_Criteria,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Minimum_Loan_Amount', Minimum_Loan_Amount,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Maximum_Loan_Amount', Maximum_Loan_Amount,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Min_Tenor', Min_Tenor,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Maximum_Tenor', Maximum_Tenor,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Maximum_Tenor_Eligibility_Criteria', Maximum_Tenor_Eligibility_Criteria,fallback: "0");
      MultipartFieldHelper.addField(request.fields, 'Geo_Limit', Geo_Limit);
      MultipartFieldHelper.addField(request.fields, 'Negative_Profiles', Negative_Profiles);
      MultipartFieldHelper.addField(request.fields, 'Negative_Areas', Negative_Areas);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Maximum_TAT', Maximum_TAT,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Minimum_Property_Value', Minimum_Property_Value,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Maximum_IIR', Maximum_IIR,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Maximum_FOIR', Maximum_FOIR,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Maximum_LTV', Maximum_LTV,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Processing_Fee', Processing_Fee,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Legal_Fee', Legal_Fee,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Technical_Fee', Technical_Fee,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Admin_Fee', Admin_Fee,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Foreclosure_Charges', Foreclosure_Charges,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Processing_Charges', Processing_Charges,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Other_Charges', Other_Charges,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Stamp_Duty', Stamp_Duty,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TSR_Years', TSR_Years,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TSR_Charges', TSR_Charges,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Valuation_Charges', Valuation_Charges,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'NoOfDocument', NoOfDocument,fallback: "0");
      MultipartFieldHelper.addField(request.fields, 'Product_Validate_From_date', Product_Validate_From_date);
      MultipartFieldHelper.addField(request.fields, 'Product_Validate_To_date', Product_Validate_To_date);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'KSDPLProductId', KSDPLProductId,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Profit_Percentage', Profit_Percentage,fallback: "0");

      MultipartFieldHelper.addFieldWithDefault(request.fields, 'FromAmountRange', FromAmountRange,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'ToAmountRange', ToAmountRange,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TotalOverdueCases', TotalOverdueCases,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TotalOverdueAmount', TotalOverdueAmount,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TotalEnquiries', TotalEnquiries,fallback: "0");

      MultipartFieldHelper.addField(request.fields, 'SuperiorName', SuperiorName);
      MultipartFieldHelper.addField(request.fields, 'SuperiorMobileNo', SuperiorMobileNo);
      MultipartFieldHelper.addField(request.fields, 'SuperiorWhatsappNo', SuperiorWhatsappNo);
      MultipartFieldHelper.addField(request.fields, 'SuperiorEmail', SuperiorEmail);


      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(addProductList, request.fields);
      Helper.ApiRes(addProductList, response.body);


      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit application: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }



  static Future<Map<String, dynamic>> updateProductListApi({

    required String KSDPLProductId,
    String? Id,
    String? BankId,
    String? bankers_Name,
    String? Bankers_Mobile_Number,
    String? Bankers_WhatsApp_Number,
    String? BankersEmailId,
    String? Min_CIBIL,
    String? Segment_Vertical,
    String? Product,
    String? ProductDescription,
    String? Customer_Category,
    String? Collateral_Security_Category,
    String? Collateral_Security_Excluded,
    String? Income_Types,
    String? Profile_Excluded,
    String? Age_limit_Earning_Applicants,
    String? Age_limit_Non_Earning_Co_Applicant,
    String? Minimum_age_earning_applicants,
    String? Minimum_age_non_earning_applicants,
    String? Minimum_Income_Criteria,
    String? Minimum_Loan_Amount,
    String? Maximum_Loan_Amount,
    String? Min_Tenor,
    String? Maximum_Tenor,
    String? Minimum_ROI,
    String? Maximum_ROI,
    String? Maximum_Tenor_Eligibility_Criteria,
    String? Geo_Limit,
    String? Negative_Profiles,
    String? Negative_Areas,
    String? Maximum_TAT,
    String? Minimum_Property_Value,
    String? Maximum_IIR,
    String? Maximum_FOIR,
    String? Maximum_LTV,
    String? Processing_Fee,
    String? Legal_Fee,
    String? Technical_Fee,
    String? Admin_Fee,
    String? Foreclosure_Charges,
    String? Other_Charges,
    String? Stamp_Duty,
    String? TSR_Years,
    String? TSR_Charges,
    String? Valuation_Charges,
    String? NoOfDocument,
    String? Product_Validate_From_date,
    String? Product_Validate_To_date,
    String? Profit_Percentage,
    String? docDescr,
    String? Processing_Charges,
    String? FromAmountRange,
    String? ToAmountRange,
    String? TotalOverdueCases,
    String? TotalOverdueAmount,
    String? TotalEnquiries,

    String? SuperiorName,
    String? SuperiorMobileNo,
    String? SuperiorWhatsappNo,
    String? SuperiorEmail,
  }) async {

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(updateProductList),
      );


      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Id', Id,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'BankId', BankId,fallback: "0");
      MultipartFieldHelper.addField(request.fields, 'Bankers_Name', bankers_Name);
      MultipartFieldHelper.addField(request.fields, 'Bankers_Mobile_Number', Bankers_Mobile_Number);
      MultipartFieldHelper.addField(request.fields, 'Bankers_WhatsApp_Number', Bankers_WhatsApp_Number);
      MultipartFieldHelper.addField(request.fields, 'Bankers_email_ID', BankersEmailId);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Min_CIBIL', Min_CIBIL,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Segment_Vertical', Segment_Vertical,fallback: "0");
      MultipartFieldHelper.addField(request.fields, 'Product', Product);
      MultipartFieldHelper.addField(request.fields, 'ProductDescription', ProductDescription);
      MultipartFieldHelper.addField(request.fields, 'Customer_Category', Customer_Category);
      MultipartFieldHelper.addField(request.fields, 'Collateral_Security_Category', Collateral_Security_Category);
      MultipartFieldHelper.addField(request.fields, 'Collateral_Security_Excluded', Collateral_Security_Excluded);
      MultipartFieldHelper.addField(request.fields, 'Income_Types', Income_Types);
      MultipartFieldHelper.addField(request.fields, 'Profile_Excluded', Profile_Excluded);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Age_limit_Earning_Applicants', Age_limit_Earning_Applicants,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Age_limit_Non_Earning_Co_Applicant', Age_limit_Non_Earning_Co_Applicant,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Minimum_age_earning_applicants', Minimum_age_earning_applicants,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Minimum_age_non_earning_applicants', Minimum_age_non_earning_applicants,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Minimum_Income_Criteria', Minimum_Income_Criteria,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Minimum_Loan_Amount', Minimum_Loan_Amount,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Maximum_Loan_Amount', Maximum_Loan_Amount,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Min_Tenor', Min_Tenor,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Maximum_Tenor', Maximum_Tenor,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Maximum_Tenor_Eligibility_Criteria', Maximum_Tenor_Eligibility_Criteria,fallback: "0");
      MultipartFieldHelper.addField(request.fields, 'Geo_Limit', Geo_Limit);
      MultipartFieldHelper.addField(request.fields, 'Negative_Profiles', Negative_Profiles);
      MultipartFieldHelper.addField(request.fields, 'Negative_Areas', Negative_Areas);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Maximum_TAT', Maximum_TAT,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Minimum_Property_Value', Minimum_Property_Value,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Maximum_IIR', Maximum_IIR,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Maximum_FOIR', Maximum_FOIR,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Maximum_LTV', Maximum_LTV,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Processing_Fee', Processing_Fee,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Legal_Fee', Legal_Fee,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Technical_Fee', Technical_Fee,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Admin_Fee', Admin_Fee,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Foreclosure_Charges', Foreclosure_Charges,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Other_Charges', Other_Charges,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Stamp_Duty', Stamp_Duty,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TSR_Years', TSR_Years,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TSR_Charges', TSR_Charges,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Valuation_Charges', Valuation_Charges,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'NoOfDocument', NoOfDocument,fallback: "0");
      MultipartFieldHelper.addField(request.fields, 'Product_Validate_From_date', Product_Validate_From_date);
      MultipartFieldHelper.addField(request.fields, 'Product_Validate_To_date', Product_Validate_To_date);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'KSDPLProductId', KSDPLProductId,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Profit_Percentage', Profit_Percentage,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Minimum_ROI', Minimum_ROI,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Maximum_ROI', Maximum_ROI,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Processing_Charges', Processing_Charges,fallback: "0");

      MultipartFieldHelper.addFieldWithDefault(request.fields, 'FromAmountRange', FromAmountRange,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'ToAmountRange', ToAmountRange,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TotalOverdueCases', TotalOverdueCases,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TotalOverdueAmount', TotalOverdueAmount,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TotalEnquiries', TotalEnquiries,fallback: "0");

      MultipartFieldHelper.addField(request.fields, 'SuperiorName', SuperiorName);
      MultipartFieldHelper.addField(request.fields, 'SuperiorMobileNo', SuperiorMobileNo);
      MultipartFieldHelper.addField(request.fields, 'SuperiorWhatsappNo', SuperiorWhatsappNo);
      MultipartFieldHelper.addField(request.fields, 'SuperiorEmail', SuperiorEmail);



      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq('addloanapplicationapi', jsonEncode((response.body)));
          Helper.ApiRes('addloanapplicationapi', response.body);
      if (response.statusCode == 200) {


        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit application: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }


  static Future<Map<String, dynamic>> getAllProductListApi({
    required int pageNumber,
    required int pageSize,
    String? bankId,
    String? minCibil,
    String? segment,
    String? product,
    String? KsdplProductId,
}) async {
    try {
      var request = http.MultipartRequest(
        'POST',
         //Uri.parse(getAllProductList),
        Uri.parse("$getAllProductList?pageNumber=$pageNumber&pageSize=$pageSize"),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      MultipartFieldHelper.addFieldWithDefault(request.fields, 'BankId', bankId,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'MinCIBIL', minCibil,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Segment', segment,fallback: "0");
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'Product', product);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'KSDPLProductId', KsdplProductId,fallback: "0");

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);


      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit application: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }



  static Future<Map<String, dynamic>>getProductListByIdApi({
    required String id
}) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getProductListById),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      request.fields['Id'] = id.toString();
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(getProductListById, request.fields);
      Helper.ApiRes(getProductListById, response.body);


      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit application: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }



  static Future<Map<String, dynamic>> addProductDocumentApi({
    required List<Map<String, dynamic>> body,
  }) async {
    try {
      var headers = await MyHeader.getHeaders3(); // should return 'Authorization' and 'Content-Type: application/json'

      var response = await http.post(
        Uri.parse(addProductDocument),
        headers: headers,
        body: jsonEncode(body),
      );


      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit application: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }


  static Future<Map<String, dynamic>>getDocumentListByProductIdApi({
    required String productId
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getDocumentListByProductId),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      request.fields['productId'] = productId.toString();
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);


      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit application: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }


  static Future<Map<String, dynamic>>getAllNegativeProfileApi() async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getAllNegativeProfileMaster),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);


      print("response.statusCode===>${response.statusCode}");
      print("response==>getProductListByIdApi==>${response.body.toString()}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit application: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }


  static Future<Map<String, dynamic>>getAllCommonDocumentNameListApi() async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getAllCommonDocumentNameList),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);


      print("response.statusCode===>getAllCommonDocumentNameListApi==>${response.statusCode}");
      print("response==>getAllCommonDocumentNameListApi==>${response.body.toString()}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit application: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }


  static void printInChunks(String text, {int chunkSize = 2048}) {
    final pattern = RegExp('.{1,$chunkSize}', dotAll: true);
    for (final match in pattern.allMatches(text)) {
      print(match.group(0));
    }
  }

  static Future<Map<String, dynamic>> getAllVacancyRequestApi() async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getAllVacancyList),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);


      Helper.ApiReq(getAllVacancyList, request.fields);
      Helper.ApiReq(getAllVacancyList, response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit application: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }
  static Future<Map<String, dynamic>> getAllSeniorListRequestApi() async {
    try {
      final headers = await MyHeader.getHeaders2();

      final body = {
        "stateId": 0,
        "districtId": 0,
        "cityId": 0,
        "pincode": "string",
        "jobrole": "string",
        "channelId": 0
      };

      final response = await http.post(
        Uri.parse(getSeniorListById),
        headers: {
          ...headers,
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      );

      Helper.ApiReq(getSeniorListById, body);
      Helper.ApiReq(getSeniorListById, response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
          "Failed to submit application: ${response.statusCode}",
        );
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Error while submitting: $e");
    }
  }

/*
  static Future<Map<String, dynamic>> getAllSeniorListRequestApi() async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getSeniorListById),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'channelId', '0',fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'cityId', '0',fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'districtId', '0',fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'jobrole', 'string',fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'pincode', 'string',fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'stateId', '0',fallback: "0");

*/
/*
      request.fields['channelId'] = '0';
      request.fields['cityId'] = '0';
      request.fields['districtId'] = '0';
      request.fields['jobrole'] = 'string';
      request.fields['pincode'] = 'string';
      request.fields['stateId'] = '0';
*//*



      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);


      Helper.ApiReq(getSeniorListById, request.fields);
      Helper.ApiReq(getSeniorListById, response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit application: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }
*/

  static Future<Map<String, dynamic>> getInsuranceLeadsApi() async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getAllInsuranceIllustrations),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);


      print("response.statusCode===>getAllInsuranceIllustrations==>${response.statusCode}");
      print("response==>getAllInsuranceIllustrations==>${response.body.toString()}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit application: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }

  static Future<Map<String, dynamic>> getProductListByCreatorIdApi({
    required empId
}) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getProductListByCreatorId),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Id', empId,fallback: "0");
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(getProductListByCreatorId, request.fields);
      Helper.ApiRes(getProductListByCreatorId, response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit application: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }


  static Future<Map<String, dynamic>>productActiveDeactiveApi({
    required productId
}) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(productActiveDeactive),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Id', productId,fallback: "0");
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);


      Helper.ApiReq(productActiveDeactive, request.fields);
      Helper.ApiRes(productActiveDeactive, response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit application: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }
}




