import 'package:charts_flutter/flutter.dart' as charts;
import 'package:task_keeper/PetDataModel.dart';
import 'package:flutter/material.dart';

class PetChart extends StatelessWidget {
  final List<PetDataModel> data;

  PetChart({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<PetDataModel, String>> series = [
      charts.Series(
          id: "Subscribers",
          data: data,
          domainFn: (PetDataModel series, _) => series.title,
          measureFn: (PetDataModel series, _) => series.value,
          colorFn: (PetDataModel series, _) => series.barColor,
      ),
    ];

    return Container(
      height: 200,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                "Kevin the Chicken",
                style: Theme.of(context).textTheme.body2,
              ),
              Expanded(
                child: charts.BarChart(
                  series,
                  animate: true,
                  vertical: false,
                  barRendererDecorator: new charts.BarLabelDecorator<String>(),
                  domainAxis: new charts.OrdinalAxisSpec(
                      renderSpec: new charts.NoneRenderSpec()
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}