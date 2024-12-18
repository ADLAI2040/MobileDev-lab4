import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarApp extends StatefulWidget {
  const CalendarApp({super.key});

  @override
  State<CalendarApp> createState() {
    return _CalendarAppState();
  }
}

class _CalendarAppState extends State<CalendarApp> {
  DateTime selectedDate = DateTime.now();
  DateTime currentDate = DateTime.now();
  DateTime nextDate = DateTime.now().add(const Duration(days: 1));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Calendar",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    selectedDate = DateTime(
                      selectedDate.year,
                      selectedDate.month - 1,
                      1,
                    );
                  });
                },
              ),
              Column(
                children: [
                  Text(
                    DateFormat.yMMMM().format(selectedDate),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            selectedDate = DateTime(
                              selectedDate.year - 1,
                              selectedDate.month,
                              1,
                            );
                          });
                        },
                      ),
                      Text(
                        "${selectedDate.year}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            selectedDate = DateTime(
                              selectedDate.year + 1,
                              selectedDate.month,
                              1,
                            );
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  setState(() {
                    selectedDate = DateTime(
                      selectedDate.year,
                      selectedDate.month + 1,
                      1,
                    );
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (var day in ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"])
                Text(day, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
              ),
              itemCount: daysInMonth(selectedDate) +
                  firstDayOfMonth(selectedDate).weekday -
                  1,
              itemBuilder: (context, index) {
                final firstDayOffset =
                    firstDayOfMonth(selectedDate).weekday - 1;
                final day = index - firstDayOffset + 1;

                if (day < 1 || day > daysInMonth(selectedDate)) {
                  return const SizedBox.shrink();
                }

                final isToday = selectedDate.year == currentDate.year &&
                    selectedDate.month == currentDate.month &&
                    day == currentDate.day;

                if (day == nextDate.day) {
                  return Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "$day",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else {
                  return Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: isToday ? Colors.orange : Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "$day",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          if (selectedDate.year != currentDate.year ||
              selectedDate.month != currentDate.month)
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.blue),
              ),
              onPressed: () {
                setState(() {
                  selectedDate = DateTime.now();
                });
              },
              child: const Text(
                "To current month",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  int daysInMonth(DateTime date) {
    final nextMonth = DateTime(date.year, date.month + 1, 1);
    final lastDayOfMonth = nextMonth.subtract(const Duration(days: 1));
    return lastDayOfMonth.day;
  }

  DateTime firstDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }
}
