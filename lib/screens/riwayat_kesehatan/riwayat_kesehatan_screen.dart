import 'package:ble_client/components/EmptyComponent.dart';
import 'package:ble_client/components/ErrorMessageComponent.dart';
import 'package:ble_client/components/LoadingScreenComponent.dart';
import 'package:ble_client/constants.dart';
import 'package:ble_client/controllers/riwayat_kesehatan_controller.dart';
import 'package:ble_client/enums.dart';
import 'package:ble_client/screens/all_riwayat_kesehatan/all_riwayat_kesehatan.dart';
import 'package:ble_client/screens/home/home_screen.dart';
import 'package:ble_client/screens/riwayat_kesehatan/components/BtnRectangleComponent.dart';
import 'package:ble_client/screens/riwayat_kesehatan/components/CardDataKesehatanTerbaru.dart';
import 'package:charts_painter/chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RiwayatkesehatanScreen extends StatefulWidget {
  const RiwayatkesehatanScreen({Key? key}) : super(key: key);

  @override
  _RiwayatkesehatanScreenState createState() => _RiwayatkesehatanScreenState();

  static String routeName = "/riwayat_kesehatan";
}

class _RiwayatkesehatanScreenState extends State<RiwayatkesehatanScreen> {
  final _riwayatKesehatanC = Get.put(RiwayatKesehatanController());
  var arguments = Get.arguments;

  double targetMax = 0;
  final bool _showValues = true;
  final bool _smoothPoints = true;
  final bool _showBars = true;
  final bool _isScrollable = true;
  final bool _fixedAxis = true;
  int minItems = 30;
  int? _selected;

  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _screenInit();
  }

  Future<void> _screenInit() async {
    await _riwayatKesehatanC.getRiwayatKesehatan(
        jenisPerangkat: arguments['jenis_perangkat'],
        jenisPengecekan: arguments['jenis_pengecekan']);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Obx(
            () => Text(
              "${arguments['jenis_perangkat'].toString()} (${_riwayatKesehatanC.jenisPengecekanKesehatan.value})",
            ),
          ),
        ),
        body: Obx(() {
          if (_riwayatKesehatanC.status.value == Status.LOADING) {
            return const LoadingScreenComponent();
          }

          if (_riwayatKesehatanC.status.value == Status.FAILED) {
            return ErrorMessageComponent(
                errorMessage: "Terdapat Kesalahan Pada Sistem!",
                action: () {
                  _riwayatKesehatanC.status.value = Status.NONE;
                  Get.toNamed(HomeScreen.routeName);
                });
          }

          if (_riwayatKesehatanC.values.isEmpty ||
              _riwayatKesehatanC.dates.isEmpty) {
            return const Center(
              child: EmptyComponent(
                title: "Data kesehatan kosong...",
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => await _screenInit(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    if (_riwayatKesehatanC.values.isNotEmpty) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (_riwayatKesehatanC.jenisPengecekanKesehatan.value
                                  .toString()
                                  .toLowerCase() !=
                              "suhu tubuh") ...[
                            Row(
                              children: [
                                BtnRectangleComponent(
                                  action: () async {
                                    await _riwayatKesehatanC
                                        .getRiwayatKesehatan(
                                            jenisPerangkat:
                                                arguments['jenis_perangkat'],
                                            jenisPengecekan: 'Detak Jantung');
                                  },
                                  text: "Detak Jantung",
                                  active: _riwayatKesehatanC
                                          .jenisPengecekanKesehatan.value
                                          .toString()
                                          .toLowerCase() ==
                                      "detak jantung",
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                BtnRectangleComponent(
                                  action: () async {
                                    await _riwayatKesehatanC
                                        .getRiwayatKesehatan(
                                            jenisPerangkat:
                                                arguments['jenis_perangkat'],
                                            jenisPengecekan:
                                                "Saturasi Oksigen");
                                  },
                                  text: "Saturasi Oksigen",
                                  active: _riwayatKesehatanC
                                          .jenisPengecekanKesehatan.value
                                          .toString()
                                          .toLowerCase() ==
                                      "saturasi oksigen",
                                ),
                              ],
                            ),
                          ],
                          TextButton(
                              onPressed: () async {
                                var data = arguments;
                                if (_riwayatKesehatanC
                                        .jenisPengecekanKesehatan.value !=
                                    "") {
                                  data['jenis_pengecekan'] = _riwayatKesehatanC
                                      .jenisPengecekanKesehatan.value;
                                }
                                Get.offNamed(
                                    AllRiwayatKesehatanScreen.routeName,
                                    arguments: data);
                              },
                              child: const Text("History")),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        // color: kLightBlueColor,
                        child: Row(
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
                                  width:
                                      MediaQuery.of(context).size.width - 24.0,
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  // state: chartState,
                                  state: ChartState(
                                    data: ChartData.fromList(
                                      _riwayatKesehatanC.values
                                          .map((e) => BarValue<void>(e))
                                          .toList(),
                                    ),
                                    itemOptions: BarItemOptions(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              _isScrollable ? 15.0 : 2.0),
                                      minBarWidth: _isScrollable ? 30.0 : 4.0,
                                      barItemBuilder: (data) {
                                        return BarItem(
                                          color: kBlueColor.withOpacity(
                                              _showBars ? 1.0 : 0.0),
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
                                      // BorderDecoration(color: kRedColor),
                                      GridDecoration(
                                        // todo: menyembunyikan grid
                                        showVerticalGrid: false,
                                        showHorizontalGrid: false,
                                        showHorizontalValues:
                                            _fixedAxis ? false : _showValues,
                                        showVerticalValues: _fixedAxis
                                            ? !_isScrollable
                                                ? false
                                                : true
                                            : _showValues,
                                        verticalValuesPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 12.0),
                                        verticalAxisStep: 1,
                                        horizontalAxisStep: 1,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        verticalAxisValueFromIndex: (value) =>
                                            _riwayatKesehatanC.dates[value],
                                        gridColor: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer
                                            .withOpacity(0.2),
                                      ),
                                      SparkLineDecoration(
                                        fill: true,
                                        lineColor: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(
                                                !_showBars ? 0.2 : 0.0),
                                        smoothPoints: _smoothPoints,
                                      ),
                                    ],
                                    foregroundDecorations: [
                                      ValueDecoration(
                                        // todo: updated
                                        hideZeroValues: true,
                                        alignment: _showBars
                                            ? Alignment.bottomCenter
                                            : const Alignment(0.0, -1.0),
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(
                                                color: (_showBars
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .onPrimary
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .primary)
                                                    .withOpacity(_isScrollable
                                                        ? 1.0
                                                        : 0.0)),
                                      ),
                                      SparkLineDecoration(
                                        lineWidth: 2.0,
                                        lineColor: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(
                                                !_showBars ? 1.0 : 0.0),
                                        smoothPoints: _smoothPoints,
                                      ),
                                    ],
                                  ),
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
                              // margin: _fixedAxis
                              //     ? const EdgeInsets.only(
                              //         right: 35.0,
                              //       )
                              //     : EdgeInsets.zero,
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: DecorationsRenderer(
                                _fixedAxis
                                    ? [
                                        // menampilkan nilai di samping kanan
                                        HorizontalAxisDecoration(
                                          asFixedDecoration: true,
                                          lineWidth: 1.0,
                                          // mengatur jarak nilai di samping kanan
                                          legendPosition:
                                              HorizontalLegendPosition.start,
                                          showLines: true,
                                          showTopValue: true,
                                          axisStep: 10,
                                          showValues: true,
                                          endWithChart: true,
                                          axisValue: (value) => '$value.00',
                                          legendFontStyle: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                          valuesAlign: TextAlign.left,
                                          valuesPadding:
                                              const EdgeInsets.only(right: 0.0),
                                          lineColor: Theme.of(context)
                                              .colorScheme
                                              .primaryContainer
                                              .withOpacity(0.8),
                                        ),
                                      ]
                                    : [],
                                ChartState(
                                  data: ChartData.fromList(
                                    _riwayatKesehatanC.values
                                        .map((e) => BarValue<void>(e))
                                        .toList(),
                                  ),
                                  itemOptions: BarItemOptions(
                                    // padding: EdgeInsets.symmetric(
                                    //     horizontal: _isScrollable ? 15.0 : 2.0),
                                    // minBarWidth: _isScrollable ? 30.0 : 4.0,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: _isScrollable ? 15.0 : 2.0),
                                    minBarWidth: _isScrollable ? 30.0 : 4.0,
                                    barItemBuilder: (data) {
                                      return BarItem(
                                        color: kBlueColor
                                            .withOpacity(_showBars ? 1.0 : 0.0),
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
                                      showHorizontalValues:
                                          _fixedAxis ? false : _showValues,
                                      showVerticalValues: _fixedAxis
                                          ? !_isScrollable
                                              ? false
                                              : true
                                          : _showValues,
                                      verticalValuesPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 12.0),
                                      verticalAxisStep: 1,
                                      horizontalAxisStep: 1,
                                      textStyle:
                                          Theme.of(context).textTheme.bodySmall,
                                      verticalAxisValueFromIndex: (value) =>
                                          _riwayatKesehatanC.dates[value],
                                      gridColor: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer
                                          .withOpacity(0.2),
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
                                      alignment: _showBars
                                          ? Alignment.bottomCenter
                                          : const Alignment(0.0, -1.0),
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                              color: (_showBars
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .onPrimary
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .primary)
                                                  .withOpacity(_isScrollable
                                                      ? 1.0
                                                      : 0.0)),
                                    ),
                                    SparkLineDecoration(
                                      // fill: true,
                                      lineWidth: 2.0,
                                      lineColor: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(!_showBars ? 1.0 : 0.0),
                                      smoothPoints: _smoothPoints,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Ini adalah bagian bawhnya yang bukan chart
                    ],
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Pengecekan Terakhir",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: kDarkColor),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (_riwayatKesehatanC.jenisPengecekanKesehatan.value
                                  .toLowerCase() !=
                              "suhu tubuh") ...[
                            CardDataKesehatanTerbaru(
                                title: "Saturasi Oksigen",
                                imgUrl: "assets/icons/blood_oxygen.svg",
                                tanggal: DateFormat(
                                        'EEEE, dd MMMM yyyy', 'id_ID')
                                    .format(_riwayatKesehatanC
                                        .detailKesehatan2['tanggal_pengecekan']
                                        .toDate() as DateTime)
                                    .toString(),
                                jam: DateFormat('HH:mm', 'id_ID')
                                    .format(_riwayatKesehatanC
                                        .detailKesehatan2['tanggal_pengecekan']
                                        .toDate() as DateTime)
                                    .toString(),
                                nilai: _riwayatKesehatanC
                                    .detailKesehatan2['nilai'],
                                satuanPengukuran: "%"),
                            const SizedBox(
                              height: 30,
                            ),
                            CardDataKesehatanTerbaru(
                                title: "Detak Jantung",
                                imgUrl: "assets/icons/heart_rate.svg",
                                tanggal: DateFormat(
                                        'EEEE, dd MMMM yyyy', 'id_ID')
                                    .format(_riwayatKesehatanC
                                        .detailKesehatan1['tanggal_pengecekan']
                                        .toDate() as DateTime)
                                    .toString(),
                                jam: DateFormat('HH:mm', 'id_ID')
                                    .format(_riwayatKesehatanC
                                        .detailKesehatan1['tanggal_pengecekan']
                                        .toDate() as DateTime)
                                    .toString(),
                                nilai: _riwayatKesehatanC
                                    .detailKesehatan1['nilai'],
                                satuanPengukuran: "bpm"),
                          ] else ...[
                            CardDataKesehatanTerbaru(
                                title: "Suhu Tubuh",
                                imgUrl: "assets/icons/termometer.svg",
                                tanggal: DateFormat(
                                        'EEEE, dd MMMM yyyy', 'id_ID')
                                    .format(_riwayatKesehatanC
                                        .detailKesehatan1['tanggal_pengecekan']
                                        .toDate() as DateTime)
                                    .toString(),
                                jam: DateFormat('HH:mm', 'id_ID')
                                    .format(_riwayatKesehatanC
                                        .detailKesehatan1['tanggal_pengecekan']
                                        .toDate() as DateTime)
                                    .toString(),
                                nilai: _riwayatKesehatanC
                                    .detailKesehatan1['nilai'],
                                satuanPengukuran: "°C"),
                          ]
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
