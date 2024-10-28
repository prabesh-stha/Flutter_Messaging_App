class Validation {
  static bool isValidEmail(String email) {
    if (email == "") {
      return false;
    } else {
      final RegExp emailRegExp = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      );
      return emailRegExp.hasMatch(email);
    }
  }

  static bool isValidPassword(String password) {
    if (password == "") {
      return false;
    } else {
      final RegExp passwordRegExp = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
      );
      return passwordRegExp.hasMatch(password);
    }
  }

  static bool isValidName(String name) {
    if (name == "") {
      return false;
    } else {
      final RegExp nameRegExp = RegExp(r'^[A-Za-z]+(?:\s[A-Za-z]+)+$');
      return nameRegExp.hasMatch(name);
    }
  }
}
