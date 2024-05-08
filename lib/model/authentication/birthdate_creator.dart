class BirthDateCreator {
  String? month;
  String? day;
  String? year;

  BirthDateCreator({this.month, this.day, this.year});

  BirthDateCreator.parseDateString(String? dateString) {
    if (dateString != null) {
      List<String> parts = dateString.split('/');
      if (parts.length == 3) {
        day = parts[0];
        month = parts[1];
        year = parts[2];
      } else {
        print('Invalid date string format');
      }
    }
  }
  String fullBirthDate(){
    return '$day/$month/$year';
  }
}