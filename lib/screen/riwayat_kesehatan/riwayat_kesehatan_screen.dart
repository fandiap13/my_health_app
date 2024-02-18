import 'dart:math';

import 'package:ble_client/constants.dart';
import 'package:ble_client/screen/riwayat_kesehatan/components/chart_options.dart';
import 'package:ble_client/screen/riwayat_kesehatan/components/toggle_item.dart';
import 'package:charts_painter/chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RiwayatkesehatanScreen extends StatefulWidget {
  const RiwayatkesehatanScreen({Key? key}) : super(key: key);

  @override
  _RiwayatkesehatanScreenState createState() => _RiwayatkesehatanScreenState();

  static String routeName = "/riwayat_kesehatan";
}

class _RiwayatkesehatanScreenState extends State<RiwayatkesehatanScreen> {
  List<double> _values = <double>[];
  // List of sample dates (adjust according to your requirements)
  final List<String> _dates = [];
  double targetMax = 0;
  bool _showValues = true;
  bool _smoothPoints = true;
  bool _showBars = true;
  bool _isScrollable = true;
  bool _fixedAxis = true;
  int minItems = 30;
  int? _selected;

  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _updateValues();
    _generateSampleDates();
  }

  void _updateValues() {
    Random rand = Random();
    final double difference = rand.nextDouble() * 15;

    targetMax = 3 +
        ((rand.nextDouble() * difference * 0.75) - (difference * 0.25))
            .roundToDouble();
    _values.addAll(List.generate(minItems, (index) {
      return 2 + rand.nextDouble() * difference;
    }));
  }

  void _addValues() {
    _values = List.generate(minItems, (index) {
      if (_values.length > index) {
        return _values[index];
      }

      return 2 + Random().nextDouble() * targetMax;
    });
  }

  // Generate sample dates (adjust according to your requirements)
  void _generateSampleDates() {
    DateTime startDate = DateTime.now().subtract(Duration(days: minItems));
    for (int i = 0; i < minItems; i++) {
      DateTime tanggal = startDate.add(Duration(days: i));
      String formattedDate = DateFormat("MM/dd/yy").format(tanggal);
      _dates.add(formattedDate);
    }
    print(_dates);
  }

  @override
  Widget build(BuildContext context) {
    final chartState = ChartState(
      data: ChartData.fromList(
        _values.map((e) => BarValue<void>(e)).toList(),
      ),
      itemOptions: BarItemOptions(
        padding: EdgeInsets.symmetric(horizontal: _isScrollable ? 15.0 : 2.0),
        minBarWidth: _isScrollable ? 30.0 : 4.0,
        barItemBuilder: (data) {
          return BarItem(
            color: kBlueColor.withOpacity(_showBars ? 1.0 : 0.0),
            radius: const BorderRadius.vertical(
              top: Radius.circular(24.0),
            ),
          );
        },
      ),
      behaviour: ChartBehaviour(
        scrollSettings: _isScrollable
            ? const ScrollSettings()
            : const ScrollSettings.none(),
        onItemClicked: (item) {
          setState(() {
            _selected = item.itemIndex;
          });
        },
      ),
      backgroundDecorations: [
        GridDecoration(
          showVerticalGrid: true,
          showHorizontalValues: _fixedAxis ? false : _showValues,
          showVerticalValues: _fixedAxis
              ? !_isScrollable
                  ? false
                  : true
              : _showValues,
          verticalValuesPadding: const EdgeInsets.symmetric(vertical: 12.0),
          verticalAxisStep: 1,
          horizontalAxisStep: 1,
          textStyle: Theme.of(context).textTheme.bodySmall,
          verticalAxisValueFromIndex: (value) => _dates[value],
          gridColor:
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
        ),
        SparkLineDecoration(
          fill: true,
          lineColor: Theme.of(context)
              .primaryColor
              .withOpacity(!_showBars ? 0.2 : 0.0),
          smoothPoints: _smoothPoints,
        ),
      ],
      foregroundDecorations: [
        ValueDecoration(
          alignment:
              _showBars ? Alignment.bottomCenter : const Alignment(0.0, -1.0),
          textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: (_showBars
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.primary)
                  .withOpacity(_isScrollable ? 1.0 : 0.0)),
        ),
        SparkLineDecoration(
          lineWidth: 2.0,
          lineColor: Theme.of(context)
              .primaryColor
              .withOpacity(!_showBars ? 1.0 : 0.0),
          smoothPoints: _smoothPoints,
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Oksimeter',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: _isScrollable
                        ? const ScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    controller: _controller,
                    scrollDirection: Axis.horizontal,
                    child: AnimatedChart(
                      duration: const Duration(milliseconds: 450),
                      width: MediaQuery.of(context).size.width - 24.0,
                      height: MediaQuery.of(context).size.height * 0.4,
                      state: chartState,
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          Colors.white,
                          Colors.white.withOpacity(0.0),
                        ],
                        stops: const [
                          0.5,
                          1.0
                        ]),
                  ),
                  // width: _fixedAxis ? 50.0 : 0.0,
                  // padding: _fixedAxis
                  //     ? const EdgeInsets.only(right: 20.0)
                  //     : EdgeInsets.zero,
                  width: _fixedAxis ? 40.0 : 0.0,
                  margin: _fixedAxis
                      ? const EdgeInsets.only(
                          right: 35.0,
                        )
                      : EdgeInsets.zero,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: DecorationsRenderer(
                    _fixedAxis
                        ? [
                            HorizontalAxisDecoration(
                              asFixedDecoration: true,
                              lineWidth: 1.0,
                              axisStep: 1,
                              showValues: true,
                              endWithChart: false,
                              axisValue: (value) => '$value.00',
                              legendFontStyle:
                                  Theme.of(context).textTheme.bodySmall,
                              valuesAlign: TextAlign.left,
                              valuesPadding: const EdgeInsets.only(right: 0.0),
                              lineColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer
                                  .withOpacity(0.8),
                            ),
                          ]
                        : [],
                    chartState,
                  ),
                ),
              ],
            ),
            Flexible(
              child: ChartOptionsWidget(
                onRefresh: () {
                  setState(() {
                    _values.clear();
                    _updateValues();
                  });
                },
                onAddItems: () {
                  setState(() {
                    minItems += 4;
                    _addValues();
                  });
                },
                onRemoveItems: () {
                  setState(() {
                    if (_values.length > 4) {
                      minItems -= 4;
                      _values.removeRange(_values.length - 4, _values.length);
                    }
                  });
                },
                toggleItems: [
                  ToggleItem(
                    title: 'Axis values',
                    value: _showValues,
                    onChanged: (value) {
                      setState(() {
                        _showValues = value;
                      });
                    },
                  ),
                  ToggleItem(
                    title: 'Fixed axis',
                    value: _fixedAxis,
                    onChanged: (value) {
                      setState(() {
                        _fixedAxis = value;
                      });
                    },
                  ),
                  ToggleItem(
                    value: _showBars,
                    title: 'Show bar items',
                    onChanged: (value) {
                      setState(() {
                        _showBars = value;
                      });
                    },
                  ),
                  ToggleItem(
                    value: _smoothPoints,
                    title: 'Smooth line curve',
                    onChanged: (value) {
                      setState(() {
                        _smoothPoints = value;
                      });
                    },
                  ),
                  ToggleItem(
                    value: _isScrollable,
                    title: 'Scrollable',
                    onChanged: (value) {
                      setState(() {
                        _isScrollable = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
