class ValidationHelper {
  /// Validate Name (Only alphabets allowed)
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Name is required";
    }

    String pattern = r'^[a-zA-Z\s]+$';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return "Enter a valid name";
    }

    return null; // Name is valid
  }

  static String? validateDob(String? value) {
    if (value == null || value.isEmpty) {
      return "DOB is required";
    }

    return null; // Name is valid
  }

  static String? validateLoanAmt(String? value) {
    if (value == null || value.isEmpty) {
      return "Loan Amount is required";
    }

    return null; // Name is valid
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
}
