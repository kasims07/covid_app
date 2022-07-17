import 'package:covid_app/widgets/reuseRow.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class DetailScreen extends StatefulWidget {
  static const routName = '/detailScreen';

  String image ;
  String  name ;
  int totalCases , totalDeaths, totalRecovered , active , critical, todayRecovered , test;

  DetailScreen(
      {Key? key,
      required this.name,
      required this.image,
      required this.totalCases,
      required this.test,
      required this.todayRecovered,
      required this.totalDeaths,
      required this.totalRecovered,
      required this.critical,
      required this.active,})
      : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.067,),
            PieChart(
             dataMap: {
               "Total": double.parse(widget.totalCases.toString()),
               "Recovered": double.parse(widget.totalRecovered.toString()),
               "Deaths" : double.parse(widget.totalDeaths.toString()),
             },
              chartValuesOptions: const ChartValuesOptions(
                showChartValuesInPercentage: true,
              ),
              animationDuration: const Duration(seconds: 2),
              colorList: const [
                Color(0xff4285F4),
                Color(0xff1aa269),
                Color(0xffde5246),
              ],
              chartType: ChartType.ring,
              legendOptions: const LegendOptions(
                legendPosition: LegendPosition.left
              ),
              chartRadius: MediaQuery.of(context).size.width / 3.2,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.067,),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.067),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.06,),
                        ReuseRow(text: 'Cases', value: widget.totalCases.toString()),
                        ReuseRow(text: 'Recovered', value: widget.totalRecovered.toString()),
                        ReuseRow(text: 'Deaths', value: widget.totalDeaths.toString()),
                        ReuseRow(text: 'Critical', value: widget.critical.toString()),
                        ReuseRow(text: 'Today Recovered', value: widget.todayRecovered.toString()),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
