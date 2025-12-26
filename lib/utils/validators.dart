class Validators {
  Validators._();

  // ==============================
  // BASIC
  // ==============================

  static String? required(
    String? value, {
    String message = 'Wajib diisi',
  }) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  static String? minLength(
    String? value,
    int min, {
    String? message,
  }) {
    if (value == null) return null;
    if (value.length < min) {
      return message ?? 'Minimal $min karakter';
    }
    return null;
  }

  static String? maxLength(
    String? value,
    int max, {
    String? message,
  }) {
    if (value == null) return null;
    if (value.length > max) {
      return message ?? 'Maksimal $max karakter';
    }
    return null;
  }

  // ==============================
  // FORMAT VALIDATION
  // ==============================

  static String? email(
    String? value, {
    String message = 'Email tidak valid',
  }) {
    if (value == null || value.isEmpty) return null;

    final regex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (!regex.hasMatch(value)) {
      return message;
    }
    return null;
  }

  static String? number(
    String? value, {
    String message = 'Harus berupa angka',
  }) {
    if (value == null || value.isEmpty) return null;

    if (num.tryParse(value.replaceAll(',', '')) == null) {
      return message;
    }
    return null;
  }

  static String? phone(
    String? value, {
    String message = 'Nomor tidak valid',
  }) {
    if (value == null || value.isEmpty) return null;

    final regex = RegExp(r'^[0-9]{8,15}$');
    if (!regex.hasMatch(value)) {
      return message;
    }
    return null;
  }

  // ==============================
  // PASSWORD
  // ==============================

  static String? password(
    String? value, {
    int minLength = 8,
  }) {
    if (value == null || value.isEmpty) {
      return 'Password wajib diisi';
    }

    if (value.length < minLength) {
      return 'Minimal $minLength karakter';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Harus mengandung huruf besar';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Harus mengandung huruf kecil';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Harus mengandung angka';
    }

    return null;
  }

  // ==============================
  // COMPOSITE VALIDATOR
  // ==============================

  static String? combine(
    String? value,
    List<String? Function(String?)> validators,
  ) {
    for (final validator in validators) {
      final result = validator(value);
      if (result != null) return result;
    }
    return null;
  }
}
