import 'package:flutter/material.dart';
import 'package:ksdpl/common/helper.dart';

/*class CustomTextFieldPrefix extends StatelessWidget {
  final String? hintText;
  final TextEditingController controller;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onSuffixIconPressed;
  final String? Function(String?)? validator;
  final TextInputType inputType;
  final Function(String)? onChanged;
  final String? prefixImage; // Nullable image path
  final String? label;
  final bool isTextArea;
  final int? maxLength;
  final bool isInputEnabled;
  final bool isSecret;
  final int secretDigit;

  const CustomTextFieldPrefix({
    Key? key,
    this.hintText,
    required this.controller,
    this.isPassword = false,
    this.obscureText = false,
    this.onSuffixIconPressed,
    this.validator,
    required this.inputType,
    this.onChanged,
    this.prefixImage, // Optional parameter
    this.label,
    this.isTextArea = false,
    this.maxLength,
    this.isInputEnabled=true,
    this.isSecret = false,
    this.secretDigit = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      maxLines: isTextArea ? null : 1, // Allow multiple lines if isTextArea is true
      minLines: isTextArea ? 3 : 1, // Minimum 5 lines for text area
      maxLength: maxLength,
      enabled: isInputEnabled,
      style: TextStyle(color: isInputEnabled ? Colors.black : Colors.grey),
      decoration: InputDecoration(
        hintText: hintText!=null?hintText:null,
        hintStyle: TextStyle(color: AppColor.grey2),
        filled: true,
        fillColor: isInputEnabled ? AppColor.grey3 : Colors.grey[300],
        label: label != null?
        Text(label!):null,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:  const BorderSide(color: Colors.red, width: 1.5),
        ),
        enabledBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:  const BorderSide(color: AppColor.borderColor, width: 1.5),
        ),

        // Conditionally add prefix icon
        prefixIcon: prefixImage != null
            ? Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(prefixImage!, width: 24, height: 24),
        )
            : null,
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: AppColor.grey1,
          ),
          onPressed: onSuffixIconPressed,
        )
            : null,
      ),
    );
  }
}*/

class CustomTextFieldPrefix extends StatefulWidget {
  final String? hintText;
  final TextEditingController controller;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onSuffixIconPressed;
  final String? Function(String?)? validator;
  final TextInputType inputType;
  final Function(String)? onChanged;
  final String? prefixImage;
  final String? label;
  final bool isTextArea;
  final int? maxLength;
  final bool isInputEnabled;
  final bool isSecret;
  final int secretDigit;

  const CustomTextFieldPrefix({
    Key? key,
    this.hintText,
    required this.controller,
    this.isPassword = false,
    this.obscureText = false,
    this.onSuffixIconPressed,
    this.validator,
    required this.inputType,
    this.onChanged,
    this.prefixImage,
    this.label,
    this.isTextArea = false,
    this.maxLength,
    this.isInputEnabled = true,
    this.isSecret = false,
    this.secretDigit = 4,
  }) : super(key: key);

  @override
  State<CustomTextFieldPrefix> createState() => _CustomTextFieldPrefixState();
}

class _CustomTextFieldPrefixState extends State<CustomTextFieldPrefix> {
  late TextEditingController _displayController;
  String _actualValue = '';
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _displayController = TextEditingController();
    _actualValue = widget.controller.text;
    _updateDisplayText();

    // Listen to changes in the original controller
    widget.controller.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    _displayController.dispose();
    super.dispose();
  }

  void _onControllerChanged() {
    if (!_isEditing) {
      _actualValue = widget.controller.text;
      _updateDisplayText();
    }
  }

  String _formatSecretText(String text) {
    if (!widget.isSecret || text.length <= widget.secretDigit) {
      return text;
    }

    int charactersToMask = text.length - widget.secretDigit;
    String maskedPart = '*' * charactersToMask;
    String visiblePart = text.substring(charactersToMask);

    return maskedPart + visiblePart;
  }

  void _updateDisplayText() {
    String displayText = _formatSecretText(_actualValue);
    if (_displayController.text != displayText) {
      _displayController.text = displayText;
    }
  }

  void _onTextChanged(String value) {
    _isEditing = true;

    if (widget.isSecret) {
      // Handle secret text input
      String newActualValue = _calculateActualValue(value);
      _actualValue = newActualValue;
      widget.controller.text = newActualValue;

      // Update display after a short delay to show formatted version
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _updateDisplayText();
        _isEditing = false;
      });
    } else {
      _actualValue = value;
      widget.controller.text = value;
      _isEditing = false;
    }

    if (widget.onChanged != null) {
      widget.onChanged!(_actualValue);
    }
  }

  String _calculateActualValue(String displayValue) {
    if (!widget.isSecret) {
      return displayValue;
    }

    // Count asterisks at the beginning
    int asteriskCount = 0;
    for (int i = 0; i < displayValue.length; i++) {
      if (displayValue[i] == '*') {
        asteriskCount++;
      } else {
        break;
      }
    }

    // If user is adding characters
    if (displayValue.length > _formatSecretText(_actualValue).length) {
      // New character added - append to actual value
      String newChars = displayValue.substring(_formatSecretText(_actualValue).length);
      return _actualValue + newChars;
    }
    // If user is removing characters
    else if (displayValue.length < _formatSecretText(_actualValue).length) {
      // Character removed - remove from actual value
      int newLength = _actualValue.length - (_formatSecretText(_actualValue).length - displayValue.length);
      return newLength > 0 ? _actualValue.substring(0, newLength) : '';
    }
    // If length is same, extract visible part and combine with existing masked part
    else {
      String visiblePart = displayValue.substring(asteriskCount);
      if (_actualValue.length > widget.secretDigit) {
        String maskedPart = _actualValue.substring(0, _actualValue.length - widget.secretDigit);
        return maskedPart + visiblePart;
      } else {
        return visiblePart;
      }
    }
  }

  void _onFocusChange(bool hasFocus) {
    if (!hasFocus && widget.isSecret) {
      // When field loses focus, ensure display is properly formatted
      _updateDisplayText();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: _onFocusChange,
      child: TextFormField(
        controller: widget.isSecret ? _displayController : widget.controller,
        keyboardType: widget.inputType,
        obscureText: widget.obscureText,
        validator: widget.validator,
        onChanged: _onTextChanged,
        maxLines: widget.isTextArea ? null : 1,
        minLines: widget.isTextArea ? 3 : 1,
        maxLength: widget.maxLength,
        enabled: widget.isInputEnabled,
        style: TextStyle(color: widget.isInputEnabled ? Colors.black : Colors.grey),
        decoration: InputDecoration(
          hintText: widget.hintText != null ? widget.hintText : null,
          hintStyle: TextStyle(color: AppColor.grey2),
          filled: true,
          fillColor: widget.isInputEnabled ? AppColor.grey3 : Colors.grey[300],
          label: widget.label != null ? Text(widget.label!) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColor.borderColor, width: 1.5),
          ),
          prefixIcon: widget.prefixImage != null
              ? Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(widget.prefixImage!, width: 24, height: 24),
          )
              : null,
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
              widget.obscureText ? Icons.visibility_off : Icons.visibility,
              color: AppColor.grey1,
            ),
            onPressed: widget.onSuffixIconPressed,
          )
              : null,
        ),
      ),
    );
  }
}