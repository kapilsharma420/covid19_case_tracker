import 'package:covid19_case_tracker/model/world_states_model.dart';
import 'package:covid19_case_tracker/services/state_services.dart';
import 'package:covid19_case_tracker/view/countrylist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({super.key});

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  late final AnimationController _Controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    super.dispose();
    _Controller.dispose();
  }

  final colorlist = [Color(0xff4285F4), Color(0xff1aa260), Color(0xffde52246)];

  Widget build(BuildContext context) {
    StateServices stateservices = StateServices();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            FutureBuilder(
                future: stateservices.fetchworldrecord(),
                builder: (context, AsyncSnapshot<worldstatemodel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          controller: _Controller,
                          size: 50,
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
                            "Death":
                                double.parse(snapshot.data!.deaths.toString()),
                          },
                          chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          animationDuration: Duration(seconds: 2),
                          chartType: ChartType.ring,
                          chartRadius: MediaQuery.of(context).size.width / 2.5,
                          colorList: colorlist,
                          legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.06),
                          child: Card(
                            child: Column(
                              children: [
                                ReusableRow(
                                    title: 'total',
                                    value: snapshot.data!.cases.toString()),
                                ReusableRow(
                                    title: 'Recover',
                                    value: snapshot.data!.recovered.toString()),
                                ReusableRow(
                                    title: 'Death',
                                    value: snapshot.data!.deaths.toString()),
                                ReusableRow(
                                    title: 'Affected countries',
                                    value: snapshot.data!.affectedCountries
                                        .toString()),
                                ReusableRow(
                                    title: 'TodayCases',
                                    value:
                                        snapshot.data!.todayCases.toString()),
                                ReusableRow(
                                    title: 'Population',
                                    value:
                                        snapshot.data!.population.toString()),
                                ReusableRow(
                                    title: 'Tests',
                                    value: snapshot.data!.tests.toString()),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CountryList()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 50,
                            child: Center(child: Text('Track Countries')),
                          ),
                        ),
                      ],
                    );
                  }
                }),
          ],
        ),
      )),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
