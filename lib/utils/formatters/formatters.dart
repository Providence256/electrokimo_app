import 'package:intl/intl.dart';

class Formatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();

    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String reclamationStatus(bool status) {
    if (status) {
      return "VALIDE";
    } else {
      return "NON VALIDE";
    }
  }

  static String getFirstTwoNames(String fullName) {
    List<String> names = fullName.split(' ');

    String joinedNames =
        names.length > 1 ? '${names[0]} ${names[1]}' : fullName;

    if (joinedNames.length <= 10) {
      return joinedNames;
    } else {
      for (var name in names) {
        if (name.length <= 10) {
          return name;
        }
      }
      return '';
    }
  }

  static String getGreetings() {
    final currentTime = DateTime.now();
    final hours = currentTime.hour;

    if (hours >= 5 && hours < 12) {
      return "Bonjour";
    } else if (hours >= 12 && hours < 17) {
      return "Bon après midi";
    } else {
      return "Bonsoir";
    }
  }
}
