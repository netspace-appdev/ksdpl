import 'package:http/http.dart' as http;
import 'package:ksdpl/common/helper.dart';
import 'dart:convert';

import '../common/base_url.dart';
import '../common/storage_service.dart';

class ApiService {
  static const String baseUrl =BaseUrl.baseUrl; //'http://192.168.29.2:8085/api/';
  static const String base2 = '';
  static const String sliderImg = baseUrl + 'slider-img';
  static const String listCategory = baseUrl + 'list-category';
  static const String listProduct = baseUrl + 'list-product';


  static const String authenticate = baseUrl + 'Auth/Authenticate';
  static const String getAllBank = baseUrl + 'BankMaster/GetAllBank';
  static const String getAllBranchByBankId = baseUrl + 'Branch/GetAllBranchByBankId';
  static const String getLevelOfBankerRole = baseUrl + 'BankerRole/GetLevelOfBankerRole';
  static const String getBankerRoleByLevelAndBankId = baseUrl + 'BankerRole/GetBankerRoleByLevelAndBankId';

  static const String getSuperiorNameByBankIdAndShortName = baseUrl + 'BankerRole/GetSuperiorNameByBankIdAndShortName';
  static const String getAdminitrativeNameByBankIdAndShortName = baseUrl + 'BankerRole/GetAdminitrativeNameByBankIdAndShortName';
  static const String checkPhoneNumberAlreadyExists = baseUrl + 'Auth/CheckPhoneNumberAlreadyExists';

  static const String validateBankerRegistrationRole = baseUrl + 'BankerRegistration/ValidateBankerRegistrationRole';
  static const String addUser = baseUrl + 'Auth/AddUser';
  static const String bankersRegistration = baseUrl + 'BankerRegistration/BankersRegistration';
  static const String sendMailForVerification = baseUrl + 'BankerRegistration/SendMailForVerification';
  static const String sendMailToBankerAfterRegistration = baseUrl + 'BankerRegistration/SendMailToBankerAfterRegistration';

  static Future<Map<String, String>> getHeaders() async {
    String? token = StorageService.get(StorageService.TOKEN);

    if (token == null) {
      throw Exception("No token found. Please login again.");
    }

    return {
      'Authorization': 'Bearer $token',
      'accept': 'text/plain',
    };
  }

  static Future<Map<String, dynamic>> fetchSliderItems() async {
    final response = await http.post(Uri.parse(sliderImg));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse['code'] == 200 && jsonResponse['data'] != null) {
        return jsonResponse; // Extract the 'data' array
      } else {
        throw Exception('Invalid API response');
      }
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> fetchCategory() async {
    final response = await http.post(Uri.parse(listCategory));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse['code'] == 200 && jsonResponse['data'] != null) {
        return jsonResponse; // Extract the 'data' array
      } else {
        throw Exception('Invalid API response');
      }
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> fetchProduct(String catId ) async {
    final response = await http.post(
        Uri.parse(listProduct),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'category': catId}),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse['code'] == 200 && jsonResponse['data'] != null) {
        return jsonResponse; // Extract the 'data' array
      } else {
        throw Exception('Invalid API response');
      }
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> loginApi(String phoneNumber, String password) async {
    try {

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(authenticate),
      );

      // Headers
      request.headers.addAll({
        'accept': 'text/plain',
      });

      // Adding form data
      request.fields['PhoneNumber'] = phoneNumber;
      request.fields['Password'] = password;

      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

     // print("Response Status Code: ${response.statusCode}");
     // print("Response Body: ${response.body}");

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
      //var headers = await getHeaders();
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getAllBank),
      );

      // Headers
      request.headers.addAll({
        'accept': 'text/plain',
      });

      print("request--->${request.fields}");


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

  static Future<Map<String, dynamic>> getAllBranchByBankIdApi(String bankId) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getAllBranchByBankId),
      );

      // Headers
      request.headers.addAll({
        'accept': 'text/plain',
      });
      request.fields['bankId'] = bankId;
      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("response in getAllBranchByBankIdApi==<${response.body}");

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

  static Future<Map<String, dynamic>> getLevelOfBankerRoleApi() async {
    try {

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getLevelOfBankerRole),
      );

      // Headers
      request.headers.addAll({
        'accept': 'text/plain',
      });

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

  static Future<Map<String, dynamic>> getBankerRoleByLevelAndBankIdApi(String levelId, String bankId) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getBankerRoleByLevelAndBankId),
      );

      // Headers
      request.headers.addAll({
        'accept': 'text/plain',
      });
      request.fields['LevelId'] = levelId;
      request.fields['BankId'] = bankId;

      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print("reponse==>${response.body}");

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


  static Future<Map<String, dynamic>> functionalSupervisorApi(String bankId, String branchId,String shortName, String status) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getSuperiorNameByBankIdAndShortName),
      );

      // Headers
      request.headers.addAll({
        'accept': 'text/plain',
      });

      request.fields['BankId'] = bankId;
      request.fields['BranchId'] = branchId;
      request.fields['ShortName'] = shortName;
      request.fields['RegsStatus'] = status;

      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("req===functionalSupervisorApi--->${request.fields}");
      print("response===>${response.body}");


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



  static Future<Map<String, dynamic>> adminSupervisorApi(String bankId, String branchId,String shortName) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getAdminitrativeNameByBankIdAndShortName),
      );

      // Headers
      request.headers.addAll({
        'accept': 'text/plain',
      });

      request.fields['BankId'] = bankId;
      request.fields['BranchId'] = branchId;
      request.fields['ShortName'] = shortName;


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

  static Future<Map<String, dynamic>> CheckPhoneNumberAlreadyExistsApi(String phone) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(checkPhoneNumberAlreadyExists),
      );

      // Headers
      request.headers.addAll({
        'accept': 'text/plain',
      });

      request.fields['Contactnumber'] = phone;



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

  ///for Registration
  static Future<Map<String, dynamic>> validateBankerRegistrationRoleApi(String bankId,branchId, shortRole) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(validateBankerRegistrationRole),
      );

      // Headers
      request.headers.addAll({
        'accept': 'text/plain',
      });

      request.fields['BankId'] = bankId;
      request.fields['BranchId'] = branchId;
      request.fields['shortRole'] = shortRole;



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

  static Future<Map<String, dynamic>> addUserApi({
    required String firstName,
    required String lastName,
    required String userName,
    required String emailId,
    required String phoneNumber,
    required String password,
    required String role
}) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(addUser),
      );

      // Headers
      request.headers.addAll({
        'accept': 'text/plain',
      });

      request.fields['FirstName'] = firstName;
      request.fields['LastName'] = lastName;
      request.fields['UserName'] = userName;
      request.fields['EmailId'] = emailId;
      request.fields['PhoneNumber'] = phoneNumber;
      request.fields['Password'] = password;
      request.fields['Role'] = role;



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


  static Future<Map<String, dynamic>> bankersRegistrationApi({
    required String id,
    required String bankId,
    required String branchId,
    required String bankerCode,
    required String bankerName,
    required String contactNo,
    required String whatsappNo,
    required String email,
    required String supervisorName,
    required String supervisorMobileNo,
    required String supervisorEmail,
    required String role,
    required String shortRole,
    required String levelId,
    required String admSupervisorName,
    required String admSupervisorMobileNo,
    required String admSupervisorEmail,
    required String supervisorId,
    required String admSupervisorId,

  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(bankersRegistration),
      );

      // Headers
      request.headers.addAll({
        'accept': 'text/plain',
      });

      request.fields['id'] = id;
      request.fields['BankId'] = bankId;
      request.fields['BranchId'] = branchId;
      request.fields['BankerCode'] = bankerCode;
      request.fields['BankerName'] = bankerName;
      request.fields['ContactNo'] = contactNo;
      request.fields['WhatsappNo'] = whatsappNo;
      request.fields['Email'] = email;
      request.fields['SupervisorName'] = supervisorName;
      request.fields['SupervisorMobileNo'] = supervisorMobileNo;
      request.fields['SupervisorEmail'] = supervisorEmail;
      request.fields['Role'] = role;
      request.fields['ShortRole'] = shortRole;
      request.fields['LevelId'] = levelId;
      request.fields['AdmSupervisorName'] = admSupervisorName;
      request.fields['AdmSupervisorMobileNo'] = admSupervisorMobileNo;
      request.fields['AdmSupervisorEmail'] = admSupervisorEmail;
      request.fields['SupervisorId'] = supervisorId;
      request.fields['AdmSupervisorId'] = admSupervisorId;



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



  static Future<Map<String, dynamic>> sendMailForVerificationApi({
    required String bankerId,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(sendMailForVerification),
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

  static Future<Map<String, dynamic>> sendMailToBankerAfterRegistrationApi({
    required String bankerId,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(sendMailToBankerAfterRegistration),
      );

      // Headers
      request.headers.addAll({
        'accept': 'text/plain',
      });

      request.fields['BankerId'] = bankerId;

      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("request===>SendMailToBankerAfterRegistrationApi==>${request.fields.toString()}");
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

}

