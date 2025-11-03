import 'package:flutter/material.dart';

import '../custom_widgets/SnackBarHelper.dart';
import 'helper.dart';
class ValidationHelper {


  static String? validatecardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Card Number is required";
    }
  }

  static String? validateCompanyBank(String? value) {
    if (value == null || value.isEmpty) {
      return "Bank Name is required";
    }
  }

  /// Validate Name (Only alphabets allowed)
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Name is required";
    }




   /* String pattern = r'^[a-zA-Z\s]+$';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return "Enter a valid name";
    }*/

    return null; // Name is valid
  }

  static String? validatePostalCode(String? value) {
    if (value == null || value.isEmpty) {
      return "Postal Code is required";
    }
  }
  static String? validateData(String? value) {
    if (value == null || value.isEmpty) {
      return "Please fill above field";
    }

    /* String pattern = r'^[a-zA-Z\s]+$';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return "Enter a valid name";
    }*/

    return null; // Name is valid
  }

  static String? validateWhatsapp(String? value) {
    if (value == null || value.isEmpty) {
      return "Whatsapp number is required";
    }

    String pattern = r'^[0-9]{10,}$';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return "Enter a valid Whatsapp number";
    }

    return null; // Phone is valid
  }
  static String? validateDob(String? value) {
    if (value == null || value.isEmpty) {
      return "DOB is required";
    }

    return null; // Name is valid
  }
  static String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return "Description is required";
    }

    return null; // Name is valid
  }

  static String? validateDocName(String? value) {
    if (value == null || value.isEmpty) {
      return "Document Name is required";
    }

    return null; // Name is valid
  }

  static String? validateFromDate(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    return null; // Name is valid
  }

  static String? validateLoanAmt(String? value) {
    if (value == null || value.isEmpty) {
      return "Loan Amount is required";
    }

    return null; // Name is valid
  }

  static String? validateAmt(String? value) {
    if (value == null || value.isEmpty) {
      return "Amount is required";
    }

    return null; // Name is valid
  }

  static String? validateEmailNotNull(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    // Regular expression for a valid email format
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(emailPattern);

    if (!regex.hasMatch(value!)) {
      return "Enter a valid email address";
    }

    return null; // Email is valid
  }

  static String? validateEmailWithoutRequired(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    // Regular expression for a valid email format
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(emailPattern);

    if (!regex.hasMatch(value!)) {
      return "Enter a valid email address";
    }

    return null; // Email is valid
  }
  static String? validateEmailOfficial(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    // Regular expression for a valid email format
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(emailPattern);

    if (!regex.hasMatch(value)) {
      return "Enter a valid email address";
    }

    // Block common public email providers
    List<String> blockedDomains = [
      "gmail.com",
      "yahoo.com",
      "hotmail.com",
      "outlook.com",
      "aol.com",
      "rediffmail.com",
      "icloud.com"
    ];

    String domain = value.split('@').last.toLowerCase();
    if (blockedDomains.contains(domain)) {
      return "Please enter an official/company email address";
    }

    return null; // Email is valid and not from a blocked domain
  }

  /// Validate Email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter a email address";
    }
    // Regular expression for a valid email format
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(emailPattern);

    if (!regex.hasMatch(value!)) {
      return "Enter a valid email address";
    }
    return null; // Email is valid
  }

  /// Validate Password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null; // Password is valid
  }

  /// Validate Phone Number (Only digits, min 10)
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }

    String pattern = r'^[0-9]{10,}$';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return "Enter a valid phone number";
    }

    return null; // Phone is valid
  }

  static String? validateNationality(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    String pattern = r'^[a-zA-Z\s]+$';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return "Enter a valid nationality";
    }

    return null; // Name is valid
  }

  static String? validateEmpName(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    String pattern = r'^[a-zA-Z\s]+$';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return "Enter a valid Employer Name";
    }

    return null; // Name is valid
  }

  static String? validateAddSrcInc(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    String pattern = r'^[a-zA-Z\s]+$';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return "Enter a valid Source of Income";
    }

    return null; // Name is valid
  }

  static String? validateBrLoc(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    String pattern = r'^[a-zA-Z\s]+$';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return "Enter a valid branch location";
    }

    return null; // Name is valid
  }

  static String? validateConnName(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    String pattern = r'^[a-zA-Z\s]+$';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return "Enter a valid Connection name";
    }

    return null; // Name is valid
  }

  static String? validateExLoan(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    String pattern = r'^[a-zA-Z\s]+$';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return "Enter valid Existing loans";
    }

    return null; // Name is valid
  }

  static String? validateNoExLoan(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    return null; // Name is valid
  }

  static String? validatePanCard(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    // PAN card format: 5 uppercase letters, 4 digits, 1 uppercase letter
    String pattern = r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return "Enter a valid PAN card number (e.g. ABCDE1234F)";
    }

    return null;
  }

  static String? validatePercentage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final numValue = num.tryParse(value);
    if (numValue == null) {
      return 'Please enter a valid number';
    }

    if (numValue < 0 || numValue > 100) {
      return 'Percentage must be between 0 and 100';
    }

    return null; // ✅ All good
  }


  static String? validateFromDateNew(String? value) {
    if (value == null || value.isEmpty) {
      return "From date is required";
    }

    return null; // Name is valid
  }

  static String? validateExpenseDate(String? value) {
    if (value == null || value.isEmpty) {
      return "Expense Date is required";
    }

    return null; // Name is valid
  }

  static String? validateReceivedDate(String? value) {
    if (value == null || value.isEmpty) {
      return "Received date is required";
    }

    return null; // Name is valid
  }

  static String? validateUTR(String? value) {
    if (value == null || value.isEmpty) {
      return "UTR Number is required";
    }

    return null; // Name is valid
  }

  static String? validateToDateNew(String? value) {
    if (value == null || value.isEmpty) {
      return "To date is required";
    }

    return null; // Name is valid
  }


  static String? validatecibilamount(String? value) {
    if (value == null || value.isEmpty) {
      return "Amount is required";
    }
    final amount = double.tryParse(value);
    if (amount == null) {
      return "Amount must be a valid number";
    }
    if (amount < 118) {
      return "Amount must not be less than 118";
    }
    return null;
  }

  static void validatePercentageInput({
    required TextEditingController controller,
    required String value,
    required double maxValue,
    required String errorMessage,
  }) {
    if (value.isNotEmpty) {
      final double? rate = double.tryParse(value);

      // Allow only up to 3 decimal places
      if (value.contains('.')) {
        final parts = value.split('.');
        if (parts.length > 1 && parts[1].length > 3) {
          final newValue = '${parts[0]}.${parts[1].substring(0, 3)}';
          controller.text = newValue;
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: newValue.length),
          );
          return; // stop further processing
        }
      }

      // Check against max value
      if (rate != null && rate > maxValue) {
        SnackbarHelper.showSnackbar(title: "Error", message: errorMessage);

        // Reset back to maxValue
        final newValue = maxValue.toString();
        controller.text = newValue;
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: newValue.length),
        );
      }
    }
  }


  static void validateYearsInput({
    required TextEditingController controller,
    required String value,
    required int minValue,
    required int maxValue,
    required String errorMessageMin,
    required String errorMessageMax,
  }) {
    if (value.isNotEmpty) {
      final int? years = int.tryParse(value);

      if (years != null) {
        // Check minimum
        if (years < minValue) {
          SnackbarHelper.showSnackbar(
              title: "Error", message: errorMessageMin);

          final newValue = minValue.toString();
          controller.text = newValue;
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: newValue.length),
          );
          return;
        }

        // Check maximum
        if (years > maxValue) {
          SnackbarHelper.showSnackbar(
              title: "Error", message: errorMessageMax);

          final newValue = maxValue.toString();
          controller.text = newValue;
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: newValue.length),
          );
        }
      }
    }
  }

  static String? validateAadhar(String? value, {bool isRequired = false}) {
    // Case 1: Required but empty
    if (isRequired && (value == null || value.isEmpty)) {
      return "Aadhar number is required";
    }

    // Case 2: Not required but user entered something
    if (value != null && value.isNotEmpty) {
      if (value.length != 12 || !RegExp(r'^[0-9]{12}$').hasMatch(value)) {
        return "Aadhar number must be exactly 12 digits";
      }
    }

    // Case 3: Empty and not required OR valid 12 digits
    return null;
  }
  static String? validateLoanApplicationNo(String? value) {
    if (value == null || value.isEmpty) {
      return AppText.loanNumberRequired;
    }
    return null;
  }
  static String hideWithStars(String input, {int count = 4}) {
    if (input.isEmpty) return input;

    // If the string is shorter than or equal to count → no need to mask
    if (input.length <= count) {
      return input;
    }

    final maskedLength = input.length - count;
    final hiddenPart = '*' * maskedLength;
    final visiblePart = input.substring(maskedLength);
    return hiddenPart + visiblePart;
  }
}
