enum Day { sun, mon, tue, wed, thu, fri, sat }

extension ParseToString on Day {
  String getValue() {
    return toString().split('.').last;
  }
}

class utils {
  static List<Map<String, Object>> sortByWeekDay(
      List<Map<String, Object>> data) {
    final sorted = Day.values.map((day) {
      return data.firstWhere((el) {
        return el['day'].toString().toLowerCase() == day.getValue();
      });
    });
    return sorted.toList();
  }
}
