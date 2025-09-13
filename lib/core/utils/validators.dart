class Validators {

  //validate email input
  static String? email(String? value) {
    if (value == null || value.isEmpty) return "Email is required";
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return "Enter a valid email";
    return null;
  }

  //validate password input
  static String? password(String? value) {
    if (value == null || value.isEmpty) return "Password is required";
    if (value.length < 6) return "Password must be at least 6 characters";
    return null;
  }

  //Validate name input 
   static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Name is required";
    }
    if (value.trim().length < 2) {
      return "Name must be at least 2 characters";
    }
    final nameRegex = RegExp(r"^[a-zA-Z\s]+$"); // only letters and spaces
    if (!nameRegex.hasMatch(value.trim())) {
      return "Enter a valid name (letters only)";
    }
    return null;
  }

}
