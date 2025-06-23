dynamic safeAssign<T>(Map<String, dynamic> json, String key, {bool verbose = true}) {
  try {
    final value = json[key];

    if (value == null) {
      if (verbose) print("🔍 Key '$key' is null");
      return null;
    }

    if (T == String) {
      if (value is! String && verbose) {
        print("⚠️ '$key': Expected String, got ${value.runtimeType}. Converting...");
      }
      return value.toString();
    }

    if (T == int) {
      if (value is int) return value;
      if (value is String) {
        final parsed = int.tryParse(value);
        if (parsed == null && verbose) {
          print("❌ '$key': Failed to parse '$value' to int");
        }
        return parsed;
      }
      if (verbose) {
        print("❌ '$key': Cannot assign ${value.runtimeType} to int");
      }
    }

    if (T == double) {
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) {
        final parsed = double.tryParse(value);
        if (parsed == null && verbose) {
          print("❌ '$key': Failed to parse '$value' to double");
        }
        return parsed;
      }
      if (verbose) {
        print("❌ '$key': Cannot assign ${value.runtimeType} to double");
      }
    }

    if (T == num) {
      if (value is num) return value;
      if (value is String) {
        final parsed = num.tryParse(value);
        if (parsed == null && verbose) {
          print("❌ '$key': Failed to parse '$value' to num");
        }
        return parsed;
      }
      if (verbose) {
        print("❌ '$key': Cannot assign ${value.runtimeType} to num");
      }
    }

    if (T == bool) {
      if (value is bool) return value;
      if (value is String) {
        final lower = value.toLowerCase();
        if (lower == 'true') return true;
        if (lower == 'false') return false;
      }
      if (verbose) {
        print("❌ '$key': Cannot assign ${value.runtimeType} to bool");
      }
    }

    // fallback
    return value;
  } catch (e) {
    if (verbose) {
      print("🚨 Error assigning key '$key': $e");
    }
    return null;
  }
}
