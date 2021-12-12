import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/data/data.dart';
import 'package:flutter_budget_ui/helpers/color_helper.dart';
import 'package:flutter_budget_ui/models/category_model.dart';
import 'package:flutter_budget_ui/models/expense_model.dart';
import 'package:flutter_budget_ui/screens/category_screen.dart';
import '../widgets/bar_chart.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    _buildCategory(Category category, double totalAmountSpent) {
      return GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=> CatergoryScteen(category: category)));
        },
        child: Container(

          padding: EdgeInsets.all(20.0),
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 6.0
            ),
            ],
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text(category.name,style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                  ),),
                  Text('\$${(category.maxAmount - totalAmountSpent).toStringAsFixed(2)} / \$${category.maxAmount.toStringAsFixed(2)}',style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                  ),)
                ],
              ),
              SizedBox(height: 10,),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints){
                 // print(constraints.maxHeight);
                  //print(constraints.maxWidth);
                  final double maxBarWidth=constraints.maxWidth;
                  final double percentage=(category.maxAmount - totalAmountSpent) /category.maxAmount;
                  double barWidth= percentage*maxBarWidth;
                  if(barWidth<0){
                    barWidth=0;
                  }
                  return Stack(
                    children: [
                      Container(
                        height: 20.0,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      Container(
                        height: 20.0,
                        width: barWidth,
                        decoration: BoxDecoration(
                          color: getColor(context, percentage),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ],
                  );
                },

              ),
            ],
          ),
        ),
      );
    }



    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Theme
                .of(context)
                .primaryColor,
            forceElevated: true,
            floating: true,
            expandedHeight: 100.0,
            leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                size: 30,
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Simple Budget'),
            ),
          ),
          SliverList(
            delegate:
            SliverChildBuilderDelegate((BuildContext context, int index) {
              if (index == 0) {
                return Container(
                  //height: 100,

                  //color: Colors.green,
                  margin: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),

                  child: Barchart(expenses: weeklySpending),
                );
              } else {
                final Category categor = categories[index - 1];
                double totalAmountSpent = 0;
                categor.expenses.forEach((Expense expense) {
                  totalAmountSpent += expense.cost;
                });
                return _buildCategory(categor, totalAmountSpent);
              }
            }, childCount: 1 + categories.length),
          ),
        ],
      ),
    );
  }
}
