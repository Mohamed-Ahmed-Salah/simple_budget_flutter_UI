import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/helpers/color_helper.dart';
import 'package:flutter_budget_ui/models/category_model.dart';
import 'package:flutter_budget_ui/models/expense_model.dart';
import 'package:flutter_budget_ui/widgets/radial_painter.dart';

class CatergoryScteen extends StatefulWidget {
  final Category category;

  CatergoryScteen({this.category});

  @override
  _CatergoryScteenState createState() => _CatergoryScteenState();
}

class _CatergoryScteenState extends State<CatergoryScteen> {
  double totalamountSpent = 0;
  double amountLeft = 0;

  double percent = 0;

  void fun() {
    widget.category.expenses.forEach((Expense expense) {
      totalamountSpent += expense.cost;
    });

    amountLeft = widget.category.maxAmount - totalamountSpent;
    percent = amountLeft / widget.category.maxAmount;
  }

  _buildExpenses() {
    List<Widget> expensList = [];
    widget.category.expenses.forEach((Expense expense) {
      expensList.add(Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 6.0, offset: Offset(0, 2)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(expense.name, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              Text(
                 '-\$${expense.cost.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20, color: Colors.red),),

            ],
          ),
        ),
      ),);
    });
    return Column(
      children: expensList,
    );
  }

  @override
  Widget build(BuildContext context) {
    fun();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
            iconSize: 30.0,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(20),
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: CustomPaint(
                foregroundPainter: RadialPainter(
                    ngColor: Colors.grey[200],
                    lineColor: getColor(context, percent),
                    percent: percent,
                    width: 15),
                child: Center(
                  child: Text(
                    '\$${amountLeft.toStringAsFixed(2)}/\$${widget.category.maxAmount}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            _buildExpenses(),
          ],
        ),
      ),
    );
  }
}
