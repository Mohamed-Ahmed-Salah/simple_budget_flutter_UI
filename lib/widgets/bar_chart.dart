import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Barchart extends StatelessWidget {
  final List<double> expenses;

  Barchart({this.expenses});

  @override
  Widget build(BuildContext context) {
    List<String> weekdays = const [
      "Mon",
      "Tue",
      "Wed",
      "Thu",
      "Fri",
      "Sat",
      "Sun",
    ];

    int firstdayindex=0;

    String getDay(int day) {
      DateTime now = DateTime.now();
      String today=DateFormat('EEE').format(now);//geting day as mon tue
      //print(today);

        firstdayindex=weekdays.indexOf(today);//geting index of first day
        //print(firstdayindex);

      return weekdays[(firstdayindex + 7 - day)%7]; //get data from List weekdays
    }

    //getting week days of previous month
    dynamic getDate() {
      DateTime now = DateTime.now();
      int currentmonth = int.parse(DateFormat('MM').format(now));
      int currentDay = int.parse(DateFormat('dd').format(now));
      int currentYear = int.parse(DateFormat('yyyy').format(now));

      var date = new DateTime(currentYear, currentmonth, currentDay);
      var nextWeek = new DateTime(date.year, date.month, date.day - 6);
      String PreviousweekformattedDate =
          DateFormat('MMM dd, yyyy').format(nextWeek);

      String formattedDate = DateFormat('MMM dd, yyyy').format(now);
      print(now);
      return "$PreviousweekformattedDate - $formattedDate";
    }

    double mostExpensive = 0;
    expenses.forEach((double price) {
      if (price > mostExpensive) {
        mostExpensive = price;
      }
    });
    return Column(
      children: [
        Text(
          'Weekly Spending',
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 1.2,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back),
            ),
            Text(
              getDate(),
              style: TextStyle(
                fontSize: 18.0,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward),
            ),
          ],
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Bar(
                label: '${getDay(6)}',
                amountSpent: expenses[6],
                mostExpesive: mostExpensive,
              ),
              Bar(
                label: '${getDay(5)}',
                amountSpent: expenses[5],
                mostExpesive: mostExpensive,
              ),
              Bar(
                label: '${getDay(4)}',
                amountSpent: expenses[4],
                mostExpesive: mostExpensive,
              ),
              Bar(
                label: '${getDay(3)}',
                amountSpent: expenses[3],
                mostExpesive: mostExpensive,
              ),
              Bar(
                label: '${getDay(2)}',
                amountSpent: expenses[2],
                mostExpesive: mostExpensive,
              ),
              Bar(
                label: '${getDay(1)}',
                amountSpent: expenses[1],
                mostExpesive: mostExpensive,
              ),
              Bar(
                label: getDay(0),
                amountSpent: expenses[0],
                mostExpesive: mostExpensive,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Bar extends StatelessWidget {
  final String label;
  final double amountSpent, mostExpesive;
  final double _maxBarHeight = 150;

  Bar({this.amountSpent, this.label, this.mostExpesive});

  @override
  Widget build(BuildContext context) {
    final barHeight = amountSpent / mostExpesive * _maxBarHeight;
    return Column(
      children: [
        Text(
          '\$${amountSpent.toStringAsFixed(2)}',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6.0),
        Container(
          height: barHeight,
          width: 18.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ],
    );
  }
}
