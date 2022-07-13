import 'package:covid_app/model/WorldStateModel.dart';
import 'package:covid_app/services/stateServices.dart';
import 'package:covid_app/widgets/reuseRow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldState extends StatefulWidget {
  static const routName = '/worldStates';

  const WorldState({Key? key}) : super(key: key);

  @override
  State<WorldState> createState() => _WorldStateState();
}

class _WorldStateState extends State<WorldState> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final ColorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa269),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
                FutureBuilder(
                    future: stateServices.fetchWorldStateRecord(),
                    builder: (context, AsyncSnapshot<WorldStateModel> snapshot) {
                      if (!snapshot.hasData) {
                        return Expanded(
                            flex: 1,
                            child: SpinKitFadingCircle(
                              color: Colors.white,
                              size: 50.0,
                              controller: _controller,
                            ));
                      } else {
                        return Column(
                          children: [
                            PieChart(
                              dataMap: {
                                "Total":
                                    double.parse(snapshot.data!.cases.toString()),
                                "Recovered": double.parse(
                                    snapshot.data!.recovered.toString()),
                                "Deaths": double.parse(
                                    snapshot.data!.deaths.toString()),
                              },
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValuesInPercentage: true,
                              ),
                              animationDuration:
                                  const Duration(milliseconds: 1200),
                              colorList: ColorList,
                              chartType: ChartType.ring,
                              legendOptions: const LegendOptions(
                                  legendPosition: LegendPosition.left),
                              chartRadius:
                                  MediaQuery.of(context).size.width / 3.2,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.height * 0.06),
                              child: Card(
                                child: Column(
                                  children: [
                                    ReuseRow(
                                      text: "Total",
                                      value: snapshot.data!.todayCases.toString(),
                                    ),
                                    ReuseRow(
                                      text: "Deaths",
                                      value: snapshot.data!.deaths.toString(),
                                    ),
                                    ReuseRow(
                                      text: "Recoverd",
                                      value: snapshot.data!.recovered.toString(),
                                    ),
                                    ReuseRow(
                                      text: "Active",
                                      value: snapshot.data!.active.toString(),
                                    ),
                                    ReuseRow(
                                      text: "Critical",
                                      value: snapshot.data!.critical.toString(),
                                    ),
                                    ReuseRow(
                                      text: "Today Death",
                                      value:
                                          snapshot.data!.todayDeaths.toString(),
                                    ),
                                    ReuseRow(
                                      text: "Today Recovered",
                                      value: snapshot.data!.recovered.toString(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: const Color(0xff1aa269),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(child: Text("Track Countries")),
                            )
                          ],
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
