import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ksdpl/common/get_header.dart';
import 'package:ksdpl/common/helper.dart';
import 'dart:convert';

import '../common/base_url.dart';
import '../common/storage_service.dart';

class DrawerApiService {
  static const String baseUrl =BaseUrl.baseUrl; //'http://192.168.29.2:8085/api/';
  static const String base2 = '';
  static const String getBankerById = baseUrl + 'BankerRegistration/GetBankerById';
  static const String editBankerRegistration = baseUrl + 'BankerRegistration/EditBankerRegistration';
  static const String changePassword = baseUrl + 'Auth/ChangePassword';

  static const String getCompanyProfile = baseUrl + 'CompanyProfile/GetCompanyProfile';
  static const String addCompanyProfile = baseUrl + 'CompanyProfile/AddCompanyProfile';
  static const String getAllLeads = baseUrl + 'LeadDetail/GetAllLeads';
  static const String updateLeadStage = baseUrl + 'LeadDetail/UpdateLeadStage';
  static const String getLeadDetailById = baseUrl + 'LeadDetail/GetLeadDetailById';
  static const String leadMoveToCommonTask = baseUrl + 'LeadDetail/LeadMoveToCommonTask';
  static const String getAllState = baseUrl + 'StateMaster/GetAllState';
  static const String getDistrictByStateId = baseUrl + 'DistrictMaster/GetDistrictByStateId';
  static const String getCityByDistrictId = baseUrl + 'CityMaster/GetCityByDistrictId';
  static const String getAllBank = baseUrl + 'BankMaster/GetAllBank';
  static const String getAllKsdplProductList = baseUrl + 'KsdplProductList/GetAllKsdplProductList';
  static const String getProductListByBankId = baseUrl + 'ProductList/GetProductListByBankId';
  static const String pickupLeadFromCommonTasks = baseUrl + 'LeadDetail/PickupLeadFromCommonTasks';
  static const String workOnLead = baseUrl + 'LeadDetail/WorkOnLead';
  static const String getLeadWorkByLeadId = baseUrl + 'LeadDetail/GetLeadWorkByLeadId';
  static const String getCampaignName = baseUrl + 'LeadDetail/GetCampaignName';
  static const String getCommonLeadListByFilter = baseUrl + 'LeadDetail/GetCommonLeadListByFilter';
  static const String getAllKsdplBranch = baseUrl + 'KsdplBranch/GetAllKsdplBranch';
  static const String getAllLeadStage = baseUrl + 'LeadStage/GetAllLeadStage';
  static const String getAllBranchByBankId = baseUrl + 'Branch/GetAllBranchByBankId';
  static const String getAllChannelList = baseUrl + 'ChannelMaster/GetAllChannelList';

  static Future<Map<String, dynamic>> getBankerByIdApi({
    required String bankerId,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getBankerById),
      );

      // Headers
      request.headers.addAll({
        'accept': 'text/plain',
      });

      request.fields['bankerId'] = bankerId;

      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);


      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == "200" && jsonResponse['success'] == true) {

          return jsonResponse;
        } else {
          //throw Exception('Invalid API response');
          return jsonResponse;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }




  static Future<Map<String, dynamic>> editBankerRegistrationApi({
    required String id,
    required String bankId,
    required String branchId,
    required String bankerCode,
    required String bankerName,
    required String contactNo,
    required String whatsappNo,
    required String email,
    required String supervisorId,
    required String admSupervisorId,
    required String supervisorName,
    required String supervisorMobileNo,
    required String supervisorEmail,
    required String admSupervisorName,
    required String admSupervisorMobileNo,
    required String admSupervisorEmail,
    required String role,
    required String shortRole,
    required String levelId,
  }) async {
    try {
      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse(editBankerRegistration),
      );
      var header=await MyHeader.getHeaders2();

      // Headers
      request.headers.addAll(header);

      request.fields['Id'] = id;
      request.fields['BankId'] = bankId;
      request.fields['BranchId'] = branchId;
      request.fields['BankerCode'] = bankerCode;
      request.fields['BankerName'] = bankerName;
      request.fields['ContactNo'] = contactNo;
      request.fields['WhatsappNo'] = whatsappNo;
      request.fields['Email'] = email;
      request.fields['SupervisorId'] = supervisorId;
      request.fields['AdmSupervisorId'] = admSupervisorId;
      request.fields['SupervisorName'] = supervisorName;
      request.fields['SupervisorMobileNo'] = supervisorMobileNo;
      request.fields['SupervisorEmail'] = supervisorEmail;
      request.fields['AdmSupervisorName'] = admSupervisorName;
      request.fields['AdmSupervisorMobileNo'] = admSupervisorMobileNo;
      request.fields['AdmSupervisorEmail'] = admSupervisorEmail;
      request.fields['Role'] = role;
      request.fields['ShortRole'] = shortRole;
      request.fields['LevelId'] = levelId;

      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);


      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == "200" && jsonResponse['success'] == true) {

          return jsonResponse;
        } else {
          //throw Exception('Invalid API response');
          return jsonResponse;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }



  static Future<Map<String, dynamic>> changePasswordApi({
    required String newPassword,


  }) async {
    try {
      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse(changePassword),
      );
      var header=await MyHeader.getHeaders2();



      // Headers
      request.headers.addAll(header);

      request.fields['NewPassword'] = newPassword;

      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("request===>changePasswordApi==>${request.fields.toString()}");
      print("response.statusCode===>${response.statusCode}");
      print("response==>${response.body.toString()}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == "200" && jsonResponse['success'] == true) {

          return jsonResponse;
        } else {
          //throw Exception('Invalid API response');
          return jsonResponse;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  ///KSDPL


  static Future<Map<String, dynamic>> getCompanyProfileApi() async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getCompanyProfile),
      );
      print("uri===>getCompanyProfileApi==>${getCompanyProfile.toString()}");
      // Headers
      request.headers.addAll({
        'accept': 'text/plain',
      });
      var header=await MyHeader.getHeaders2();
      print("uri===>getCompanyProfileApi==>${header}");
      request.headers.addAll(header);
      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print("request===>getCompanyProfileApi==>${request.fields.toString()}");
      print("response.statusCode===>${response.statusCode}");
      print("response==>${response.body.toString()}");
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == "200" && jsonResponse['success'] == true) {

          return jsonResponse;
        } else {
          //throw Exception('Invalid API response');
          return jsonResponse;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<Map<String, dynamic>> addCompanyProfileApi({
    required String id,
    required String companyName,
    required String founderName,
    required String ceoName,
    required String tagline,
    required String foundingDate,
    required String headquartersLocation,
    required String email,
    required String phoneNo,
    required String whatsAppNo,
    required String fax,
    required String websiteURL,
    required String linkedIn,
    required String facebook,
    required String twitter,
    required String companyAddress,
    required String mapIntegration,
    required String privacyPolicy,
    required String termsAndConditions,
    required String gstNumber,
    required String panNumber,
    required String cinNumber,
    required String createdDate,
    required String createdBy,
    required String updateDate,
    required String updatedBy,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(addCompanyProfile),
      );
      var header=await MyHeader.getHeaders2();

      // Headers
      request.headers.addAll(header);

      request.fields['Id'] = id;
      request.fields['CompanyName'] = companyName;
      request.fields['FounderName'] = founderName;
      request.fields['CEOName'] = ceoName;
      request.fields['Tagline'] = tagline;
      request.fields['FoundingDate'] = foundingDate;
      request.fields['HeadquartersLocation'] = headquartersLocation;
      request.fields['Email'] = email;
      request.fields['PhoneNo'] = phoneNo;
      request.fields['WhatsAppNo'] = whatsAppNo;
      request.fields['Fax'] = fax;
      request.fields['WebsiteURL'] = websiteURL;
      request.fields['LinkedIn'] = linkedIn;
      request.fields['Facebook'] = facebook;
      request.fields['Twitter'] = twitter;
      request.fields['CompanyAddress'] = companyAddress;
      request.fields['MapIntegration'] = mapIntegration;
      request.fields['PrivacyPolicy'] = privacyPolicy;
      request.fields['TermsAndConditions'] = termsAndConditions;
      request.fields['GSTNumber'] = gstNumber;
      request.fields['PANNumber'] = panNumber;
      request.fields['CINNumber'] = cinNumber;
      request.fields['CreatedDate'] = createdDate;
      request.fields['CreatedBy'] = createdBy;
      request.fields['UpdateDate'] = updateDate;
      request.fields['UpdatedBy'] = updatedBy;

      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);


      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == "200" && jsonResponse['success'] == true) {

          return jsonResponse;
        } else {
          //throw Exception('Invalid API response');
          return jsonResponse;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

/*
  static Future<Map<String, dynamic>> getAllLeadsApi({
    required leadStage,
    required employeeId,
    required stateId,
    required distId,
    required cityId,
    required campaign,


  }) async {
    print("request===>  getAllLeadsApi in leadlist==>${getAllLeads.toString()}");
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getAllLeads),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      request.fields['LeadStage'] = leadStage.toString();
      request.fields['AssignedEmployeeId'] =employeeId.toString();
      request.fields['StateId'] =stateId;
      request.fields['DistrictId'] =distId;
      request.fields['CityId'] =cityId;
      request.fields['Campaign'] =campaign;
      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("request===>  getAllLeadsApi==>${getAllLeads.toString()}");
      print("request===>==>${request.fields.toString()}");
      print("response.statusCode===>${response.statusCode}");
      print("response==>${response.body.toString()}");
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == "200" && jsonResponse['success'] == true) {

          return jsonResponse;
        } else {
          //throw Exception('Invalid API response');
          return jsonResponse;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
*/
  static Future<Map<String, dynamic>> getAllLeadsApi({
    required leadStage,
    required employeeId,
    required stateId,
    required distId,
    required cityId,
    required campaign,
    required int pageNumber,
    required int pageSize,
    required fromDate,
    required toDate,
    required branch,
    required uniqueLeadNumber,
    required leadMobileNumber,
  }) async {
    try {
      print("API called");
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("$getAllLeads?pageNumber=$pageNumber&pageSize=$pageSize"),
      );

      var header = await MyHeader.getHeaders2();
      request.headers.addAll(header);

      request.fields['LeadStage'] = leadStage.toString();
      request.fields['AssignedEmployeeId'] = employeeId.toString();
      request.fields['StateId'] = stateId;
      request.fields['DistrictId'] = distId;
      request.fields['CityId'] = cityId;
      request.fields['Campaign'] = campaign;
      request.fields['FromDate'] = fromDate;
      request.fields['ToDate'] = toDate;
      request.fields['Branch'] = branch;
      request.fields['UniqueLeadNumber'] = uniqueLeadNumber;
      request.fields['LeadMobileNumber'] = leadMobileNumber;

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("request===> getAllLeadsApi==>${request.fields}");
      print("response===>getAllLeadsApi ==>${response.statusCode}");
      print("response===>getAllLeadsApi ==>${response.body}");
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }



  static Future<Map<String, dynamic>> updateLeadStageApi({
    required id,
    required stage,
    required active,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse( updateLeadStage),
      );
      print("uri===> updateLeadStage==>");
      // Headers
      request.headers.addAll({
        'accept': 'text/plain',
      });
      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      request.fields['Id'] = id;
      request.fields['Stage'] = stage;
      request.fields['Active'] = active;
      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("request===> updateLeadStage==>${request.fields}");
      print("response===> updateLeadStage==>${response.statusCode}");
      print("response===> updateLeadStage==>${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == "200" && jsonResponse['success'] == true) {

          return jsonResponse;
        } else {
          //throw Exception('Invalid API response');
          return jsonResponse;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }


  static Future<Map<String, dynamic>> getLeadDetailByIdApi({
    required leadId,
  }) async {
    print("request===> getLeadDetailById==>");
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getLeadDetailById),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      request.fields['LeadId'] = leadId.toString();
      // Sending request
      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      print("request===>  getLeadDetailById==>${getLeadDetailById.toString()}");
      print("request===>==>${request.fields.toString()}");
      print("response.statusCode===>${response.statusCode}");
      print("response==>getLeadDetailById==>${response.body.toString()}");
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == "200" && jsonResponse['success'] == true) {

          return jsonResponse;
        } else {
          //throw Exception('Invalid API response');
          return jsonResponse;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }


  static Future<Map<String, dynamic>> leadMoveToCommonTaskApi({
    required leadId,
    required percentage,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(leadMoveToCommonTask),
      );
      print("uri===> leadMoveToCommonTask==>${leadMoveToCommonTask.toString()}");
      // Headers
      request.headers.addAll({
        'accept': 'text/plain',
      });
      var header=await MyHeader.getHeaders2();
      print("uri===> leadMoveToCommonTask==>${header}");
      request.headers.addAll(header);
      request.fields['LeadId'] = leadId;
      request.fields['Percentage'] = percentage;

      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);


      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == "200" && jsonResponse['success'] == true) {

          return jsonResponse;
        } else {
          //throw Exception('Invalid API response');
          return jsonResponse;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<Map<String, dynamic>> getAllStateApi() async {

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getAllState),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      request.fields['Language'] = "English";
      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == "200" && jsonResponse['success'] == true) {

          return jsonResponse;
        } else {
          //throw Exception('Invalid API response');
          return jsonResponse;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<Map<String, dynamic>> getDistrictByStateIdApi({
    required stateId
  }) async {

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getDistrictByStateId),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      request.fields['StateId'] = stateId;
      request.fields['Language'] = "English";
      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("Req--->getDistrictByStateIdApi==>${request.fields}");
      print("Res--->${response.body}");
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == "200" && jsonResponse['success'] == true) {

          return jsonResponse;
        } else {
          //throw Exception('Invalid API response');
          return jsonResponse;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }



  static Future<Map<String, dynamic>> getCityByDistrictIdApi({
    required districtId
  }) async {

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getCityByDistrictId),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      request.fields['districtId'] = districtId;
      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print("getCityByDistrictIdApi req===>${request.fields}");
      print("getCityByDistrictIdApi res===>${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == "200" && jsonResponse['success'] == true) {

          return jsonResponse;
        } else {
          //throw Exception('Invalid API response');
          return jsonResponse;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }


  static Future<Map<String, dynamic>> getAllBankApi() async {

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getAllBank),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == "200" && jsonResponse['success'] == true) {

          return jsonResponse;
        } else {
          //throw Exception('Invalid API response');
          return jsonResponse;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }


  static Future<Map<String, dynamic>> getAllKsdplProductApi() async {

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getAllKsdplProductList),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);


      print("res====>getAllKsdplProductApi==>${response.body.toString()}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == "200" && jsonResponse['success'] == true) {

          return jsonResponse;
        } else {
          //throw Exception('Invalid API response');
          return jsonResponse;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }



  static Future<Map<String, dynamic>> getProductListByBankIdApi({
    required bankId
  }) async {
print("getProductListByBankIdApi===>${bankId}");
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getProductListByBankId),
      );
      print("getProductListByBankIdApi===>2");
      // Headers

      var header=await MyHeader.getHeaders2();
      print("getProductListByBankIdApi===>3");
      request.headers.addAll(header);
      print("getProductListByBankIdApi===>4");
      request.fields['BankId'] = bankId.toString();
      print("getProductListByBankIdApi===>5");
      // Sending request
      var streamedResponse = await request.send();
      print("getProductListByBankIdApi===>6");
      var response = await http.Response.fromStream(streamedResponse);
      print("req==>getProductListByBankIdApi==>${request.fields}");
      print("resp==>getProductListByBankIdApi==>${response.body}");
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == "200" && jsonResponse['success'] == true) {

          return jsonResponse;
        } else {
          //throw Exception('Invalid API response');
          return jsonResponse;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }


  static Future<Map<String, dynamic>> pickupLeadFromCommonTasksApi({
    required leadId,
    required employeeId

  }) async {

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(pickupLeadFromCommonTasks),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      request.fields['LeadId'] = leadId;
      request.fields['EmployeeId'] = employeeId;
      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("request===>  getUpcomingDateOfBirth==>${pickupLeadFromCommonTasks.toString()}");
      print("request===>==>${request.fields.toString()}");
      print("response.statusCode===>${response.statusCode}");
      print("response==>${response.body.toString()}");
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == "200" && jsonResponse['success'] == true) {

          return jsonResponse;
        } else {
          //throw Exception('Invalid API response');
          return jsonResponse;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }



  static Future<Map<String, dynamic>> workOnLeadApi({
    required String leadId,
    String leadStageStatus="0",
    String leadPercent = "0",
    String employeeId = "0",
    String? callEndTime,
    String callStatus = "0",
    String? callStartTime,
    String? feedbackRelatedToLead,
    String? callDuration,
    String? callReminder,
    String? feedbackRelatedToCall,
    String moveToCommon = "0",
    File? callRecordingPathUrl, // File upload
    String reminderStatus = "0",
    String id = "0",
  }) async {
    try {
      if(reminderStatus=="0"){
        DateTime now = DateTime.now();

        callReminder=now.toString();
      }
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(workOnLead),
      );

      print("URI ===> workOnLead ===> ${workOnLead.toString()}");

      // Headers
      request.headers.addAll({
        'accept': 'text/plain',
        'Content-Type': 'multipart/form-data',
      });

      var header = await MyHeader.getHeaders2();
      request.headers.addAll(header);

      // Required fields
      request.fields['Id'] = id;
      request.fields['LeadId'] = leadId;
      request.fields['LeadStage_Status'] = leadStageStatus;
      request.fields['Lead_Percent'] = leadPercent;
      request.fields['EmployeeId'] = employeeId;
      request.fields['CallStatus'] = callStatus;
      request.fields['MoveToCommon'] = moveToCommon;
      request.fields['Call_Recording_PathURL'] = "null";
      request.fields['ReminderStatus'] = reminderStatus;

      // Optional fields (Set null for "string" values)
      if (callEndTime != "string") request.fields['CallEndTime'] = callEndTime ?? "null";
      if (callStartTime != "string") request.fields['CallStartTime'] = callStartTime ?? "null";
      if (feedbackRelatedToLead != "string") request.fields['FeedBack_Related_To_Lead'] = feedbackRelatedToLead ?? "null";
      if (callDuration != "string") request.fields['CallDuration'] = callDuration ?? "null";
      if (callReminder != "string") request.fields['Call_Reminder'] = callReminder ?? "null";

      if (feedbackRelatedToCall != "string") request.fields['FeedBack_Related_To_Call'] = feedbackRelatedToCall ?? "null";

      // File Upload: Only attach if file exists
      /* if (callRecordingPathUrl != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'Call_Recording_PathURL',
            callRecordingPathUrl.path,
            contentType: MediaType('image', 'png'), // Adjust based on file type
          ),
        );
      }*/

      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print("Request Fields: ${request.fields}");
      print("Response Status: ${response.statusCode}");
      print("Response Body work onlead: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == "200" && jsonResponse['success'] == true) {
          return jsonResponse;
        } else {
          return jsonResponse;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }


  static Future<Map<String, dynamic>> getLeadWorkByLeadIdApi({
    required leadId,
  }) async {

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getLeadWorkByLeadId),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      request.fields['LeadId'] = leadId;

      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("request===>  getLeadWorkByLeadId==>${getLeadWorkByLeadId.toString()}");
      print("request===>==>${request.fields.toString()}");
      print("response.statusCode===>${response.statusCode}");
      print("response==>${response.body.toString()}");
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == "200" && jsonResponse['success'] == true) {

          return jsonResponse;
        } else {
          //throw Exception('Invalid API response');
          return jsonResponse;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<Map<String, dynamic>> getCampaignNameApi() async {
    print("request===>  getCampaignNameApi ==>${getCampaignName.toString()}");
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getCampaignName),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("request===>  getCampaignNameApi==>");
      print("request===>==>${request.fields.toString()}");
      print("response.statusCode===>${response.statusCode}");
      print("response==>getCampaignNameApi==>${response.body.toString()}");
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == "200" && jsonResponse['success'] == true) {

          return jsonResponse;
        } else {
          //throw Exception('Invalid API response');
          return jsonResponse;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<Map<String, dynamic>> getCommonLeadListByFilterApi({

    String stateId="0",
    String distId="0",
    String cityId="0",
    String KsdplBranchId="0",

  }) async {
    print("request===>  getCommonLeadListByFilter in open poll==>${getCommonLeadListByFilter.toString()}");
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getCommonLeadListByFilter),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      request.fields['State'] = stateId.toString();
      request.fields['District'] = distId.toString();
      request.fields['City'] = cityId.toString();
      request.fields['KsdplBranchId'] = KsdplBranchId.toString();


      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("request===>  getCommonLeadListByFilterApi==>${getAllLeads.toString()}");
      print("request===>==>${request.fields.toString()}");
      print("response.statusCode===>${response.statusCode}");
      print("response==>${response.body.toString()}");
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == "200" && jsonResponse['success'] == true) {

          return jsonResponse;
        } else {
          //throw Exception('Invalid API response');
          return jsonResponse;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<Map<String, dynamic>> getAllKsdplBranchApi() async {

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getAllKsdplBranch),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("request===>  getAllKsdplBranch==>${getAllKsdplProductList.toString()}");
      print("request===>==>${request.fields.toString()}");
      print("response.statusCode===>${response.statusCode}");
      print("response==>${response.body.toString()}");
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == "200" && jsonResponse['success'] == true) {

          return jsonResponse;
        } else {
          //throw Exception('Invalid API response');
          return jsonResponse;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<Map<String, dynamic>> getAllLeadStageApi() async {

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getAllLeadStage),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == "200" && jsonResponse['success'] == true) {

          return jsonResponse;
        } else {
          //throw Exception('Invalid API response');
          return jsonResponse;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<Map<String, dynamic>> getAllBranchByBankIdApi({
    required bankId
  }) async {

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getAllBranchByBankId),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      request.fields['bankId'] = bankId;

      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print("request---->${request.fields}");
      print("response.bdy---->${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == "200" && jsonResponse['success'] == true) {

          return jsonResponse;
        } else {
          //throw Exception('Invalid API response');
          return jsonResponse;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }


  static Future<Map<String, dynamic>> getAllChannelListApi() async {

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getAllChannelList),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);


      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == "200" && jsonResponse['success'] == true) {

          return jsonResponse;
        } else {
          //throw Exception('Invalid API response');
          return jsonResponse;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

}
