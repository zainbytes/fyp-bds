String? emailValidation(String? value) {
  String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty) {
    return "Email can't be empty";
  }

  else if(regex.hasMatch(value)==false){
    return "Provide a valid email";
  }
  return null;
}

String? passwordValidation(String? value) {
  if (value == null || value.isEmpty) {
    return "Password can't be empty";
  } 
  else if (value.length < 8) {
    return "Password must be at least 8 digits long ";
  }
  return null;
}

String? nameValidation(String? value) {
  if (value == null || value.isEmpty) {
    return "Name can't be empty";
  } 
  else if (value.length < 4) {
    return "Name must be at least 4 digits long ";
  }
  return null;
}

String? phoneValidation(String? value) {
  if (value == null || value.isEmpty) {
    return "Please provide an valid Phone No";
  }
  return null;
}

String? bloodGroupValidation(String? value) {
  if (value == null || value.isEmpty) {
    return "Please choose blood group ";
  }
  return null;
}

String? emptyValidation(String? value) {
  if (value == null || value.isEmpty||value=="null") {
    return "This field can't be empty. ";
  }
  return null;
}
