class ValidationHelper {
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


  static String? validateToDateNew(String? value) {
    if (value == null || value.isEmpty) {
      return "To date is required";
    }

    return null; // Name is valid
  }
}
