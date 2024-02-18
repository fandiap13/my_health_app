// import 'dart:math';

// import 'package:ble_client/constants.dart';
// import 'package:ble_client/screen/riwayat_kesehatan/components/chart_options.dart';
// import 'package:ble_client/screen/riwayat_kesehatan/components/toggle_item.dart';
// import 'package:charts_painter/chart.dart';
// import 'package:flutter/material.dart';

// class RiwayatkesehatanScreen extends StatefulWidget {
//   const RiwayatkesehatanScreen({Key? key}) : super(key: key);

//   @override
//   _RiwayatkesehatanScreenState createState() => _RiwayatkesehatanScreenState();

//   static String routeName = "/riwayat_kesehatan";
// }

// class _RiwayatkesehatanScreenState extends State<RiwayatkesehatanScreen> {
//   List<double> _values = <double>[];
//   double targetMax = 0;
//   bool _isScrollable = true;
//   final bool _fixedAxis = true;
//   int minItems = 30;
//   int? _selected;

//   final _controller = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     _updateValues();
//   }

//   void _updateValues() {
//     final Random rand = Random();
//     final double difference = rand.nextDouble() * 15;

//     targetMax = 3 +
//         ((rand.nextDouble() * difference * 0.75) - (difference * 0.25))
//             .roundToDouble();
//     _values.addAll(List.generate(minItems, (index) {
//       return 2 + rand.nextDouble() * difference;
//     }));
//   }

//   void _addValues() {
//     _values = List.generate(minItems, (index) {
//       if (_values.length > index) {
//         return _values[index];
//       }

//       return 2 + Random().nextDouble() * targetMax;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final targetArea = TargetAreaDecoration(
//       targetMax: targetMax + 2,
//       targetMin: targetMax,
//       // warna apa ini
//       colorOverTarget: Theme.of(context).colorScheme.error.withOpacity(1.0),
//       targetAreaFillColor: Theme.of(context).colorScheme.error.withOpacity(0.2),
//       targetLineColor: Theme.of(context).colorScheme.error,
//       targetAreaRadius: BorderRadius.circular(12.0),
//     );

//     final chartState = ChartState(
//       data: ChartData.fromList(
//         _values.map((e) => BarValue<void>(e)).toList(),
//         axisMax: 20,
//       ),
//       itemOptions: BarItemOptions(
//         padding: EdgeInsets.symmetric(horizontal: _isScrollable ? 12.0 : 2.0),
//         minBarWidth: _isScrollable ? 36.0 : 4.0,
//         barItemBuilder: (data) {
//           return BarItem(
//             color: targetArea.getTargetItemColor(
//                 kBlueColor.withOpacity(1.0), data.item),
//             radius: const BorderRadius.vertical(
//               top: Radius.circular(24.0),
//             ),
//           );
//         },
//       ),
//       behaviour: ChartBehaviour(
//         scrollSettings: _isScrollable
//             ? const ScrollSettings()
//             : const ScrollSettings.none(),
//         onItemClicked: (item) {
//           print('ini menampilkan nilai paling atas');
//           setState(() {
//             _selected = item.itemIndex;
//           });
//         },
//       ),
//       backgroundDecorations: [
//         HorizontalAxisDecoration(
//           endWithChart: false,
//           lineWidth: 2.0,
//           axisStep: 2,
//           lineColor: kLightBlueColor.withOpacity(0.2),
//         ),
//         VerticalAxisDecoration(
//           endWithChart: false,
//           lineWidth: 2.0,
//           axisStep: 7,
//           lineColor: kLightBlueColor.withOpacity(0.8),
//         ),
//         GridDecoration(
//           showVerticalGrid: true,
//           showHorizontalValues: true,
//           showVerticalValues: true,
//           verticalValuesPadding: const EdgeInsets.symmetric(vertical: 12.0),
//           verticalAxisStep: 1,
//           horizontalAxisStep: 1,
//           textStyle: Theme.of(context).textTheme.bodySmall,
//           gridColor:
//               Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
//         ),
//         targetArea,
//         SparkLineDecoration(
//           fill: true,
//           lineColor: Theme.of(context).primaryColor.withOpacity(0.0),
//           smoothPoints: true,
//         ),
//       ],
//       foregroundDecorations: [
//         ValueDecoration(
//           alignment: Alignment.bottomCenter,
//           textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
//               color: Theme.of(context)
//                   .colorScheme
//                   .onPrimary
//                   .withOpacity(_isScrollable ? 1.0 : 0.0)),
//         ),
//         SparkLineDecoration(
//           lineWidth: 2.0,
//           lineColor: Theme.of(context).primaryColor.withOpacity(0.0),
//           smoothPoints: true,
//         ),

//         // Header color ============================================
//         // BorderDecoration(
//         //   endWithChart: true,
//         //   color: kBlueColor,
//         // ),
//         // SelectedItemDecoration(
//         //   _selected,
//         //   animate: true,
//         //   selectedColor: Theme.of(context).colorScheme.secondary,
//         //   topMargin: 40.0,
//         //   child: Padding(
//         //     padding: const EdgeInsets.only(bottom: 40.0),
//         //     child: Container(
//         //       padding: const EdgeInsets.all(8.0),
//         //       decoration: BoxDecoration(
//         //         color: Colors.white,
//         //         border: Border.all(),
//         //         shape: BoxShape.circle,
//         //       ),
//         //       child: Text(_selected != null
//         //           ? _values[_selected!].toStringAsPrecision(2)
//         //           : '...'),
//         //     ),
//         //   ),
//         //   backgroundColor: Theme.of(context)
//         //       .scaffoldBackgroundColor
//         //       .withOpacity(_isScrollable ? 0.5 : 0.8),
//         // ),
//       ],
//     );

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Scrollable chart',
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: SingleChildScrollView(
//                     physics: _isScrollable
//                         ? const ScrollPhysics()
//                         : const NeverScrollableScrollPhysics(),
//                     controller: _controller,
//                     scrollDirection: Axis.horizontal,
//                     child: AnimatedChart(
//                       duration: const Duration(milliseconds: 450),
//                       width: MediaQuery.of(context).size.width - 24.0,
//                       height: MediaQuery.of(context).size.height * 0.4,
//                       state: chartState,
//                     ),
//                   ),
//                 ),

//                 // ini buat fixed axis kanan
//                 AnimatedContainer(
//                   duration: const Duration(milliseconds: 350),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                         begin: Alignment.centerRight,
//                         end: Alignment.centerLeft,
//                         colors: [
//                           Colors.white,
//                           Colors.white.withOpacity(0.0),
//                         ],
//                         stops: const [
//                           0.5,
//                           1.0
//                         ]),
//                   ),
//                   width: _fixedAxis ? 40.0 : 0.0,
//                   height: MediaQuery.of(context).size.height * 0.4,
//                   child: DecorationsRenderer(
//                     _fixedAxis
//                         ? [
//                             HorizontalAxisDecoration(
//                               asFixedDecoration: true,
//                               lineWidth: 1.0,
//                               axisStep: 1,
//                               showValues: true,
//                               endWithChart: true,
//                               axisValue: (value) => '$value E',
//                               legendFontStyle:
//                                   Theme.of(context).textTheme.bodySmall,
//                               valuesAlign: TextAlign.center,
//                               valuesPadding: const EdgeInsets.only(right: 8.0),
//                               lineColor: Theme.of(context)
//                                   .colorScheme
//                                   .primaryContainer
//                                   .withOpacity(0.8),
//                             )
//                           ]
//                         : [],
//                     chartState,
//                   ),
//                 )
//               ],
//             ),
//           ),

//           // OPTIONS
//           Flexible(
//             child: ChartOptionsWidget(
//               onRefresh: () {
//                 setState(() {
//                   _values.clear();
//                   _updateValues();
//                 });
//               },
//               onAddItems: () {
//                 setState(() {
//                   minItems += 4;
//                   _addValues();
//                 });
//               },
//               onRemoveItems: () {
//                 setState(() {
//                   if (_values.length > 4) {
//                     minItems -= 4;
//                     _values.removeRange(_values.length - 4, _values.length);
//                   }
//                 });
//               },
//               toggleItems: [
//                 ToggleItem(
//                   value: _isScrollable,
//                   title: 'Scrollable',
//                   onChanged: (value) {
//                     setState(() {
//                       _isScrollable = value;
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
