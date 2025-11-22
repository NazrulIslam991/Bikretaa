import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/calender/database/calender_api.dart';
import 'package:bikretaa/features/calender/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  static const name = '/Calender';

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Map<DateTime, List<String>> allEvents = {};
  Map<DateTime, List<String>> monthEvents = {};

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadHolidaysForYear(_focusedDay.year);
  }

  Future<void> loadHolidaysForYear(int year) async {
    if (year > DateTime.now().year) return;

    setState(() => isLoading = true);

    List<HolidayModel> holidayList = await ApiService.getHolidays(year);

    for (var h in holidayList) {
      DateTime rawDate = DateTime.parse(h.date).toLocal();
      DateTime date = DateTime(rawDate.year, rawDate.month, rawDate.day);

      if (!allEvents.containsKey(date)) allEvents[date] = [];
      // Prevent duplicate events
      if (!allEvents[date]!.contains(h.name)) allEvents[date]!.add(h.name);
    }

    filterMonthEvents(_focusedDay);

    setState(() => isLoading = false);
  }

  void filterMonthEvents(DateTime day) {
    setState(() => isLoading = true);

    Map<DateTime, List<String>> filtered = {};
    allEvents.forEach((key, value) {
      if (key.year == day.year && key.month == day.month) {
        filtered[key] = value;
      }
    });

    setState(() {
      monthEvents = filtered;
      isLoading = false;
    });
  }

  void onPageChangedHandler(DateTime focusedDay) {
    _focusedDay = focusedDay;

    if (focusedDay.year <= DateTime.now().year &&
        !allEvents.keys.any((d) => d.year == focusedDay.year)) {
      loadHolidaysForYear(focusedDay.year);
    } else {
      filterMonthEvents(focusedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final primaryColor = theme.colorScheme.primary;
    final cardColor = theme.cardColor;
    final todayColor = isDark ? Colors.blueAccent : Colors.blue[300]!;
    final selectedColor = isDark ? Colors.greenAccent : Colors.green;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calendar Events",
          style: TextStyle(
            fontSize: r.fontXL(),
            fontWeight: FontWeight.bold,
            color: theme.appBarTheme.foregroundColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 4,
      ),
      body: Column(
        children: [
          // ---------------------- CALENDAR ----------------------
          Container(
            margin: EdgeInsets.all(r.paddingMedium()),
            padding: EdgeInsets.all(r.paddingSmall()),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(r.radiusLarge()),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                leftChevronIcon: Icon(Icons.chevron_left, color: primaryColor),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: primaryColor,
                ),
                titleTextStyle: TextStyle(
                  fontSize: r.fontLarge(),
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: todayColor,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                selectedDecoration: BoxDecoration(
                  color: selectedColor,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                markerDecoration: BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                ),
                outsideDaysVisible: false,
                weekendTextStyle: TextStyle(color: Colors.redAccent),
              ),
              eventLoader: (day) => isLoading ? [] : allEvents[day] ?? [],
              onPageChanged: onPageChangedHandler,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
            ),
          ),

          // ---------------------- MONTH EVENT LIST ----------------------
          Expanded(
            child: isLoading
                ? Center(
                    child: SizedBox(
                      height: r.height(0.05),
                      width: r.height(0.05),
                      child: CircularProgressIndicator(color: primaryColor),
                    ),
                  )
                : monthEvents.isEmpty
                ? Center(
                    child: Text(
                      "No events this month",
                      style: TextStyle(
                        fontSize: r.fontMedium(),
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                    ),
                  )
                : ListView(
                    padding: EdgeInsets.all(r.paddingMedium()),
                    children: monthEvents.entries.map((entry) {
                      final date = entry.key;
                      final events = entry.value;

                      return Container(
                        margin: EdgeInsets.only(bottom: r.paddingSmall()),
                        padding: EdgeInsets.all(r.paddingSmall()),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(r.radiusMedium()),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: r.width(0.055),
                              backgroundColor: theme.colorScheme.secondary,
                              child: Padding(
                                padding: EdgeInsets.all(r.paddingSmall()),
                                child: Text(
                                  date.day.toString(),
                                  style: TextStyle(
                                    color: selectedColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: r.fontMedium(),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: r.width(0.04)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: events
                                    .map(
                                      (e) => Text(
                                        e,
                                        style: TextStyle(
                                          fontSize: r.fontMedium(),
                                          fontWeight: FontWeight.w600,
                                          color:
                                              theme.textTheme.bodyMedium?.color,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
