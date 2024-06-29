class TValidators {
  static String? validateInput(String? filedName, String? value) {
    if (value == null || value.isEmpty) {
      return '$filedName est obligatoire';
    }

    return null;
  }

  static String? checkPassword(String? value, String password) {
    if (value != password) {
      return "Mot de passe n'est pas identique";
    }

    if (value == null || value.isEmpty) {
      return "Confirmer votre mot de passe";
    }

    return null;
  }

  static String? checkPaformat(String? filedName, String? value) {
    if (value == null || value.isEmpty) {
      return '$filedName est obligatoire';
    }

    if (!value.contains(RegExp(r'\d{2}-\d{3}-[a-zA-Z]?\d{4}'))) {
      return "Police Abonnement pas disponible";
    }

    return null;
  }

  static String? validateCodeCountry(String? fieldName, String? value) {
    final code = value?.substring(0, 4);
    print(code);
    if (code != "+243") {
      return "Utiliser uniquement le code de la RDCongo";
    }

    if (value == null || value.isEmpty) {
      return '$fieldName est obligatoire';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Mot de passe est obligatoire";
    }

    //Check for minimum password length
    if (value.length < 8) {
      return "Le mot de passe doit contenir au moins 6 caractères";
    }

    //Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return "Le mot de passe doit contenir au moins un chiffre";
    }

    //Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return "Le mot de passe doit contenir au moins une lettre Majuscule";
    }

    //Check for Special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "Le mot de passe doit contenir au moins un caractère spécial";
    }

    return null;
  }
}
