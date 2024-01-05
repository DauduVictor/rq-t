import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roqqu_test/core/core.dart';
import 'package:roqqu_test/theme/theme.dart';
import 'package:roqqu_test/utils/asset_path.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'widgets/widget.dart';

class Dashboard extends StatefulWidget {
  static const String id = 'dashboard';
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final repository = Repository();

  WebSocketChannel? _candleStickChannel;

  @override
  void initState() {
    _candleStickChannel = repository.fetchCandleStickData();
    super.initState();
  }

  @override
  void dispose() {
    _candleStickChannel!.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ValueNotifier(false);
    final orderTabSelected = ValueNotifier('open_order');
    final chartTabSelected = ValueNotifier('orderbook');
    final selectedCandleFilterType = ValueNotifier('');
    final selectedCandleDateFilterType = ValueNotifier('1D');
    final textTheme = Theme.of(context).textTheme;
    final mqr = MediaQuery.of(context).size;
    final textToDisplay = {
      'open_order': 'No Open Orders',
      'positions': 'No Positions',
      'open_history': 'No Open History',
      'trade_history': 'No Trade History',
    };
    return AnimatedBuilder(
      animation: isDarkMode,
      builder: (context, _) {
        return Scaffold(
          backgroundColor:
              isDarkMode.value ? AppColors.darkBgColor : AppColors.lightBgColor,
          appBar: AppBar(
            backgroundColor:
                isDarkMode.value ? AppColors.blackColor : AppColors.whiteColor,
            shadowColor: isDarkMode.value
                ? AppColors.lightStrokeColor
                : AppColors.darkStrokeColor.withOpacity(0.2),
            title: Image.asset(
              AssetsPath.logo,
              width: 125.w,
              height: 125.w,
              color: isDarkMode.value
                  ? AppColors.whiteColor
                  : AppColors.darkBgColor,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 8,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      AssetsPath.avatar,
                      width: 33.w,
                      height: 33.w,
                    ),
                    const SizedBox(width: 16),
                    //globe
                    InkWell(
                      onTap: () {},
                      child: SvgPicture.asset(
                        AssetsPath.globeIcon,
                        width: 25.sp,
                      ),
                    ),
                    const SizedBox(width: 16),
                    //menu-bar
                    InkWell(
                      onTap: () => isDarkMode.value = !isDarkMode.value,
                      child: SvgPicture.asset(
                        AssetsPath.menuIcon,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  StrokeContainerWidget(
                    isDarkMode: isDarkMode,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.centerRight,
                              children: [
                                SvgPicture.asset(AssetsPath.btcIcon),
                                Positioned(
                                  left: 20,
                                  child: SvgPicture.asset(AssetsPath.usdtIcon),
                                ),
                              ],
                            ),
                            const SizedBox(width: 30),
                            Text(
                              'BTC/USDT',
                              style: textTheme.bodyMedium!.copyWith(
                                color: isDarkMode.value
                                    ? AppColors.whiteColor
                                    : AppColors.blackColor,
                              ),
                            ),
                            const SizedBox(width: 20),
                            SvgPicture.asset(
                              AssetsPath.chevronDownIcon,
                              color: !isDarkMode.value
                                  ? null
                                  : AppColors.whiteColor,
                            ),
                            const SizedBox(width: 18),
                            Text(
                              '\$20,634',
                              style: textTheme.bodyMedium!.copyWith(
                                color: AppColors.greenColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 14.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DashboardChangeField(
                              isDarkMode: isDarkMode,
                              assetPath: AssetsPath.clockIcon,
                              fieldTitle: '24h change',
                              fieldText: '520.80 +1.25%',
                              useSolidColor: true,
                            ),
                            DashboardChangeField(
                              isDarkMode: isDarkMode,
                              assetPath: AssetsPath.arrowUp,
                              fieldTitle: '24h high',
                              fieldText: '520.80 +1.25%',
                            ),
                            DashboardChangeField(
                              isDarkMode: isDarkMode,
                              assetPath: AssetsPath.arrowDown,
                              fieldTitle: '24h low',
                              fieldText: '520.80 -1.2%',
                              showDivider: false,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: chartTabSelected,
                    builder: (context, _, val) {
                      return StrokeContainerWidget(
                        isDarkMode: isDarkMode,
                        usePadding: false,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(16, 16, 0, 5),
                          child: Scrollbar(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(2.5),
                                      decoration: BoxDecoration(
                                        color: isDarkMode.value
                                            ? AppColors.pureBlackColor
                                                .withOpacity(0.3)
                                            : AppColors.lightStrokeColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          TabButton(
                                            isDarkMode: isDarkMode,
                                            onTap: () => chartTabSelected
                                                .value = 'charts',
                                            label: 'Charts',
                                            selected: chartTabSelected.value ==
                                                'charts',
                                            width: mqr.width * 0.25,
                                          ),
                                          TabButton(
                                            isDarkMode: isDarkMode,
                                            onTap: () => chartTabSelected
                                                .value = 'orderbook',
                                            label: 'Orderbook',
                                            selected: chartTabSelected.value ==
                                                'orderbook',
                                            width: mqr.width * 0.3,
                                          ),
                                          Expanded(
                                            child: TabButton(
                                              isDarkMode: isDarkMode,
                                              onTap: () => chartTabSelected
                                                  .value = 'recent_trades',
                                              label: 'Recent trades',
                                              selected:
                                                  chartTabSelected.value ==
                                                      'recent_trades',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (chartTabSelected.value == 'charts')
                                      // show candle chart
                                      SizedBox(
                                        height: mqr.height * 0.4,
                                        child: Column(
                                          children: [
                                            ValueListenableBuilder(
                                              valueListenable:
                                                  selectedCandleDateFilterType,
                                              builder: (context, val, _) {
                                                return SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SelectionButton(
                                                        buttonLabel: 'Time',
                                                        isDarkMode: isDarkMode,
                                                        isSelected:
                                                            selectedCandleDateFilterType
                                                                    .value ==
                                                                'time',
                                                        onTap: () =>
                                                            selectedCandleDateFilterType
                                                                .value = 'time',
                                                      ),
                                                      SizedBox(
                                                        width: 47.w,
                                                        child: SelectionButton(
                                                          buttonLabel: '1H',
                                                          isDarkMode:
                                                              isDarkMode,
                                                          isSelected:
                                                              selectedCandleDateFilterType
                                                                      .value ==
                                                                  '1h',
                                                          onTap: () =>
                                                              selectedCandleDateFilterType
                                                                  .value = '1h',
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 47.w,
                                                        child: SelectionButton(
                                                          buttonLabel: '2H',
                                                          isDarkMode:
                                                              isDarkMode,
                                                          isSelected:
                                                              selectedCandleDateFilterType
                                                                      .value ==
                                                                  '2h',
                                                          onTap: () =>
                                                              selectedCandleDateFilterType
                                                                  .value = '2h',
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 47.w,
                                                        child: SelectionButton(
                                                          buttonLabel: '4H',
                                                          isDarkMode:
                                                              isDarkMode,
                                                          isSelected:
                                                              selectedCandleDateFilterType
                                                                      .value ==
                                                                  '4h',
                                                          onTap: () =>
                                                              selectedCandleDateFilterType
                                                                  .value = '4h',
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 47.w,
                                                        child: SelectionButton(
                                                          buttonLabel: '1D',
                                                          isDarkMode:
                                                              isDarkMode,
                                                          isSelected:
                                                              selectedCandleDateFilterType
                                                                      .value ==
                                                                  '1d',
                                                          onTap: () =>
                                                              selectedCandleDateFilterType
                                                                  .value = '1d',
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 47.w,
                                                        child: SelectionButton(
                                                          buttonLabel: '1W',
                                                          isDarkMode:
                                                              isDarkMode,
                                                          isSelected:
                                                              selectedCandleDateFilterType
                                                                      .value ==
                                                                  '1w',
                                                          onTap: () =>
                                                              selectedCandleDateFilterType
                                                                  .value = '1w',
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 47.w,
                                                        child: SelectionButton(
                                                          buttonLabel: 'dd',
                                                          isDarkMode:
                                                              isDarkMode,
                                                          isSelected:
                                                              selectedCandleDateFilterType
                                                                      .value ==
                                                                  'dd',
                                                          onTap: () =>
                                                              selectedCandleDateFilterType
                                                                  .value = 'dd',
                                                          child: Icon(
                                                            Icons
                                                                .keyboard_arrow_down_rounded,
                                                            color: isDarkMode
                                                                    .value
                                                                ? AppColors
                                                                    .darkGreyColor
                                                                : null,
                                                            size: 21,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 47.w,
                                                        child: SelectionButton(
                                                          buttonLabel: '',
                                                          isDarkMode:
                                                              isDarkMode,
                                                          isSelected:
                                                              selectedCandleDateFilterType
                                                                      .value ==
                                                                  'chart',
                                                          onTap: () =>
                                                              selectedCandleDateFilterType
                                                                      .value =
                                                                  'chart',
                                                          child: Image.asset(
                                                            AssetsPath.chart,
                                                            color: isDarkMode
                                                                    .value
                                                                ? AppColors
                                                                    .darkGreyColor
                                                                : null,
                                                          ),
                                                        ),
                                                      ),
                                                      SelectionButton(
                                                        buttonLabel:
                                                            'Fx Indicators',
                                                        isDarkMode: isDarkMode,
                                                        isSelected:
                                                            selectedCandleDateFilterType
                                                                    .value ==
                                                                'fx',
                                                        onTap: () =>
                                                            selectedCandleDateFilterType
                                                                .value = 'fx',
                                                      ),
                                                      SizedBox(
                                                        width: 47.w,
                                                        child: SelectionButton(
                                                          buttonLabel: '',
                                                          isDarkMode:
                                                              isDarkMode,
                                                          isSelected:
                                                              selectedCandleDateFilterType
                                                                      .value ==
                                                                  'undoRedo',
                                                          onTap: () =>
                                                              selectedCandleDateFilterType
                                                                      .value =
                                                                  'undoRedo',
                                                          child: Image.asset(
                                                            AssetsPath.undoRedo,
                                                            color: isDarkMode
                                                                    .value
                                                                ? AppColors
                                                                    .darkGreyColor
                                                                : null,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                            Divider(
                                              color: isDarkMode.value
                                                  ? AppColors.greenColor4
                                                  : AppColors.lightStrokeColor,
                                              thickness: 1.3,
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: ValueListenableBuilder(
                                                valueListenable:
                                                    selectedCandleFilterType,
                                                builder: (context, val, _) {
                                                  return Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SelectionButton(
                                                        buttonLabel:
                                                            'Trading view',
                                                        isDarkMode: isDarkMode,
                                                        isSelected:
                                                            selectedCandleFilterType
                                                                    .value ==
                                                                'trading_view',
                                                        onTap: () =>
                                                            selectedCandleFilterType
                                                                    .value =
                                                                'trading_view',
                                                      ),
                                                      SelectionButton(
                                                        buttonLabel: 'Depth',
                                                        isDarkMode: isDarkMode,
                                                        isSelected:
                                                            selectedCandleFilterType
                                                                    .value ==
                                                                'depth',
                                                        onTap: () =>
                                                            selectedCandleFilterType
                                                                    .value =
                                                                'depth',
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 15,
                                                          top: 15,
                                                        ),
                                                        child: SvgPicture.asset(
                                                          AssetsPath.expandIcon,
                                                          color: isDarkMode
                                                                  .value
                                                              ? AppColors
                                                                  .darkGreyColor
                                                              : null,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                            Divider(
                                              color: isDarkMode.value
                                                  ? AppColors.greenColor4
                                                  : AppColors.lightStrokeColor,
                                              thickness: 1.3,
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                // height: mqr.height * 0.4,
                                                child: Theme(
                                                  data: ThemeData(
                                                    brightness: isDarkMode.value
                                                        ? Brightness.dark
                                                        : Brightness.light,
                                                  ),
                                                  child: Candlesticks(
                                                    actions: [],
                                                    candles: [
                                                      // Candle(
                                                      //   date: DateTime.now(),
                                                      //   open: 950.36,
                                                      //   high: 1100.93,
                                                      //   low: 900.34,
                                                      //   close: 1000.56,
                                                      //   volume: 100.0,
                                                      // ),
                                                      Candle(
                                                        date: DateTime.now()
                                                            .add(const Duration(
                                                                seconds: 5)),
                                                        open: 950.36,
                                                        high: 1100.93,
                                                        low: 900.34,
                                                        close: 1000.56,
                                                        volume: 100.0,
                                                      ),
                                                      Candle(
                                                        date: DateTime.now()
                                                            .add(const Duration(
                                                                seconds: 10)),
                                                        open: 950.36,
                                                        high: 1100.93,
                                                        low: 900.34,
                                                        close: 1000.56,
                                                        volume: 100.0,
                                                      ),
                                                      Candle(
                                                        date: DateTime.now()
                                                            .add(const Duration(
                                                                seconds: 15)),
                                                        open: 950.36,
                                                        high: 1100.93,
                                                        low: 900.34,
                                                        close: 1000.56,
                                                        volume: 100.0,
                                                      ),
                                                      Candle(
                                                        date: DateTime.now()
                                                            .add(const Duration(
                                                                seconds: 20)),
                                                        open: 950.36,
                                                        high: 1100.93,
                                                        low: 900.34,
                                                        close: 1000.56,
                                                        volume: 100.0,
                                                      ),
                                                      Candle(
                                                        date: DateTime.now()
                                                            .add(const Duration(
                                                                seconds: 25)),
                                                        open: 950.36,
                                                        high: 1100.93,
                                                        low: 900.34,
                                                        close: 1000.56,
                                                        volume: 100.0,
                                                      ),
                                                      Candle(
                                                        date: DateTime.now()
                                                            .add(const Duration(
                                                                seconds: 5)),
                                                        open: 950.36,
                                                        high: 1100.93,
                                                        low: 900.34,
                                                        close: 1000.56,
                                                        volume: 100.0,
                                                      ),
                                                      Candle(
                                                        date: DateTime.now()
                                                            .add(const Duration(
                                                                seconds: 10)),
                                                        open: 950.36,
                                                        high: 1100.93,
                                                        low: 900.34,
                                                        close: 1000.56,
                                                        volume: 100.0,
                                                      ),
                                                      Candle(
                                                        date: DateTime.now()
                                                            .add(const Duration(
                                                                seconds: 15)),
                                                        open: 950.36,
                                                        high: 1100.93,
                                                        low: 900.34,
                                                        close: 1000.56,
                                                        volume: 100.0,
                                                      ),
                                                      Candle(
                                                        date: DateTime.now()
                                                            .add(const Duration(
                                                                seconds: 20)),
                                                        open: 950.36,
                                                        high: 1100.93,
                                                        low: 900.34,
                                                        close: 1000.56,
                                                        volume: 100.0,
                                                      ),
                                                      Candle(
                                                        date: DateTime.now()
                                                            .add(const Duration(
                                                                seconds: 25)),
                                                        open: 950.36,
                                                        high: 1100.93,
                                                        low: 900.34,
                                                        close: 1000.56,
                                                        volume: 100.0,
                                                      ),
                                                      Candle(
                                                        date: DateTime.now()
                                                            .add(const Duration(
                                                                seconds: 5)),
                                                        open: 950.36,
                                                        high: 1100.93,
                                                        low: 900.34,
                                                        close: 1000.56,
                                                        volume: 100.0,
                                                      ),
                                                      Candle(
                                                        date: DateTime.now()
                                                            .add(const Duration(
                                                                seconds: 10)),
                                                        open: 950.36,
                                                        high: 1100.93,
                                                        low: 900.34,
                                                        close: 1000.56,
                                                        volume: 100.0,
                                                      ),
                                                      Candle(
                                                        date: DateTime.now()
                                                            .add(const Duration(
                                                                seconds: 15)),
                                                        open: 950.36,
                                                        high: 1100.93,
                                                        low: 900.34,
                                                        close: 1000.56,
                                                        volume: 100.0,
                                                      ),
                                                      Candle(
                                                        date: DateTime.now()
                                                            .add(const Duration(
                                                                seconds: 20)),
                                                        open: 950.36,
                                                        high: 1100.93,
                                                        low: 900.34,
                                                        close: 1000.56,
                                                        volume: 100.0,
                                                      ),
                                                      Candle(
                                                        date: DateTime.now()
                                                            .add(const Duration(
                                                                seconds: 25)),
                                                        open: 950.36,
                                                        high: 1100.93,
                                                        low: 900.34,
                                                        close: 1000.56,
                                                        volume: 100.0,
                                                      ),
                                                      Candle(
                                                        date: DateTime.now()
                                                            .add(const Duration(
                                                                seconds: 5)),
                                                        open: 950.36,
                                                        high: 1100.93,
                                                        low: 900.34,
                                                        close: 1000.56,
                                                        volume: 100.0,
                                                      ),
                                                      Candle(
                                                        date: DateTime.now()
                                                            .add(const Duration(
                                                                seconds: 10)),
                                                        open: 950.36,
                                                        high: 1100.93,
                                                        low: 900.34,
                                                        close: 1000.56,
                                                        volume: 100.0,
                                                      ),
                                                      Candle(
                                                        date: DateTime.now()
                                                            .add(const Duration(
                                                                seconds: 15)),
                                                        open: 950.36,
                                                        high: 1100.93,
                                                        low: 900.34,
                                                        close: 1000.56,
                                                        volume: 100.0,
                                                      ),
                                                      Candle(
                                                        date: DateTime.now()
                                                            .add(const Duration(
                                                                seconds: 20)),
                                                        open: 950.36,
                                                        high: 1100.93,
                                                        low: 900.34,
                                                        close: 1000.56,
                                                        volume: 100.0,
                                                      ),
                                                      Candle(
                                                        date: DateTime.now()
                                                            .add(const Duration(
                                                                seconds: 25)),
                                                        open: 950.36,
                                                        high: 1100.93,
                                                        low: 900.34,
                                                        close: 1000.56,
                                                        volume: 100.0,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    // show bar charts
                                    Visibility(
                                      visible:
                                          chartTabSelected.value == 'orderbook',
                                      child: SizedBox(
                                        height: mqr.height * 0.4,
                                        child: OrderBookWidget(
                                          isDarkMode: isDarkMode,
                                        ),
                                      ),
                                    ),
                                    if (chartTabSelected.value ==
                                        'recent_trades')
                                      SizedBox(
                                        height: mqr.height * 0.4,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Text(
                                                'No recent trades',
                                                style: textTheme.bodyMedium!
                                                    .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  color: isDarkMode.value
                                                      ? AppColors.whiteColor
                                                      : AppColors.blackColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: orderTabSelected,
                    builder: (context, _, val) {
                      return StrokeContainerWidget(
                        isDarkMode: isDarkMode,
                        usePadding: false,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(2.5),
                                decoration: BoxDecoration(
                                  color: isDarkMode.value
                                      ? AppColors.pureBlackColor
                                          .withOpacity(0.3)
                                      : AppColors.lightStrokeColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      TabButton(
                                        isDarkMode: isDarkMode,
                                        onTap: () => orderTabSelected.value =
                                            'open_order',
                                        label: 'Open Orders',
                                        selected: orderTabSelected.value ==
                                            'open_order',
                                      ),
                                      TabButton(
                                        isDarkMode: isDarkMode,
                                        onTap: () => orderTabSelected.value =
                                            'positions',
                                        label: 'Positions',
                                        selected: orderTabSelected.value ==
                                            'positions',
                                      ),
                                      TabButton(
                                        isDarkMode: isDarkMode,
                                        onTap: () => orderTabSelected.value =
                                            'open_history',
                                        label: 'Open History',
                                        selected: orderTabSelected.value ==
                                            'open_history',
                                      ),
                                      TabButton(
                                        isDarkMode: isDarkMode,
                                        onTap: () => orderTabSelected.value =
                                            'trade_history',
                                        label: 'Trade History',
                                        selected: orderTabSelected.value ==
                                            'trade_history',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: mqr.height * 0.1),
                              Text(
                                textToDisplay[orderTabSelected.value] ?? '',
                                style: textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: isDarkMode.value
                                      ? AppColors.whiteColor
                                      : AppColors.blackColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 30.0.w),
                                child: Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Id pulvinar nullam sit imperdiet pulvinar.',
                                  textAlign: TextAlign.center,
                                  style: textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    height: 1.6,
                                    color: isDarkMode.value
                                        ? AppColors.darkGreyColor
                                        : AppColors.lightGreyColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  StrokeContainerWidget(
                    isDarkMode: isDarkMode,
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            onPressed: () => showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) => Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: BuySellModalSheet(
                                  isDarkMode: isDarkMode,
                                  isBuy: true,
                                ),
                              ),
                              isScrollControlled: true,
                            ),
                            color: AppColors.greenColor2,
                            label: 'Buy',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomButton(
                            onPressed: () => showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) => Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: BuySellModalSheet(
                                  isDarkMode: isDarkMode,
                                  isBuy: false,
                                ),
                              ),
                              isScrollControlled: true,
                            ),
                            color: AppColors.redColor,
                            label: 'Sell',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).padding.bottom,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class OrderBookWidget extends StatefulWidget {
  const OrderBookWidget({
    super.key,
    required this.isDarkMode,
  });

  final ValueNotifier<bool> isDarkMode;

  @override
  State<OrderBookWidget> createState() => _OrderBookWidgetState();
}

class _OrderBookWidgetState extends State<OrderBookWidget> {
  final repository = Repository();
  WebSocketChannel? _orderBookChannel;
  final showOrderBooks = ValueNotifier(false);

  @override
  void initState() {
    _orderBookChannel = repository.fetchOrderBookData();
   Future.delayed(const Duration(seconds: 2))
        .then((value) => showOrderBooks.value = true);

    super.initState();
  }

  @override
  void dispose() {
    _orderBookChannel!.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filterType = ValueNotifier(1);
    final textTheme = Theme.of(context).textTheme;
    return StreamBuilder(
      stream: _orderBookChannel!.stream,
      builder: (context, snapshot) {
        print(snapshot);
        if (snapshot.hasError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100.h),
              Center(
                child: Text(
                  'An error occured in establishing\nconnection',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.redColor,
                  ),
                ),
              ),
            ],
          );
        } else if (snapshot.hasData) {
          print(snapshot.data);
          return Column(
            children: [
              const SizedBox(height: 9),
              ValueListenableBuilder(
                valueListenable: filterType,
                builder: (context, val, _) {
                  return Row(
                    children: [
                      InkWell(
                        onTap: () => filterType.value = 1,
                        child: Container(
                          padding: const EdgeInsets.all(11),
                          margin: const EdgeInsets.only(right: 4),
                          decoration: BoxDecoration(
                            color: filterType.value == 1
                                ? widget.isDarkMode.value
                                    ? AppColors.greenColor3
                                    : AppColors.greyColor
                                : null,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Image.asset(
                            AssetsPath.filter1,
                            width: 15.w,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => filterType.value = 2,
                        child: Container(
                          padding: const EdgeInsets.all(11),
                          margin: const EdgeInsets.only(right: 4),
                          decoration: BoxDecoration(
                            color: filterType.value == 2
                                ? widget.isDarkMode.value
                                    ? AppColors.greenColor3
                                    : AppColors.greyColor
                                : null,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Image.asset(
                            AssetsPath.filter2,
                            width: 15.w,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => filterType.value = 3,
                        child: Container(
                          padding: const EdgeInsets.all(11),
                          margin: const EdgeInsets.only(right: 4),
                          decoration: BoxDecoration(
                            color: filterType.value == 3
                                ? widget.isDarkMode.value
                                    ? AppColors.greenColor3
                                    : AppColors.greyColor
                                : null,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Image.asset(
                            AssetsPath.filter3,
                            width: 15.w,
                          ),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          margin: const EdgeInsets.only(right: 4),
                          decoration: BoxDecoration(
                            color: widget.isDarkMode.value
                                ? AppColors.greenColor3
                                : AppColors.greyColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              Text(
                                '10',
                                style: textTheme.titleSmall!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: widget.isDarkMode.value
                                      ? AppColors.whiteColor
                                      : AppColors.darkBgColor,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.lightGreyColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        Text(
                          'Price',
                          style: textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: widget.isDarkMode.value
                                ? AppColors.darkGreyColor
                                : AppColors.lightGreyColor,
                          ),
                        ),
                        Text(
                          '(USDT)',
                          style: textTheme.titleSmall!.copyWith(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w500,
                            color: widget.isDarkMode.value
                                ? AppColors.darkGreyColor
                                : AppColors.lightGreyColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(height: 12),
                        Text(
                          'Amounts',
                          style: textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: widget.isDarkMode.value
                                ? AppColors.darkGreyColor
                                : AppColors.lightGreyColor,
                          ),
                        ),
                        Text(
                          '(BTC)',
                          style: textTheme.titleSmall!.copyWith(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w500,
                            color: widget.isDarkMode.value
                                ? AppColors.darkGreyColor
                                : AppColors.lightGreyColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Total',
                      style: textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: widget.isDarkMode.value
                            ? AppColors.darkGreyColor
                            : AppColors.lightGreyColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              OrderBookFieldWidget(
                isDarkMode: widget.isDarkMode,
                price: '39620.34',
                amount: '0.56980',
                total: '23,080.99',
                bgColor: AppColors.redColor2,
                bgWidth: 0.24,
              ),
              OrderBookFieldWidget(
                isDarkMode: widget.isDarkMode,
                price: '20780.00',
                amount: '0.34909',
                total: '15,200.92',
                bgColor: AppColors.redColor2,
                bgWidth: 0.03,
              ),
              OrderBookFieldWidget(
                isDarkMode: widget.isDarkMode,
                price: '40384.84',
                amount: '1.436793',
                total: '30,248.22',
                bgColor: AppColors.redColor2,
                bgWidth: 0.4,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '36,641.20',
                      style: textTheme.bodyMedium!.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.greenColor2,
                      ),
                    ),
                    const SizedBox(width: 8),
                    SvgPicture.asset(
                      AssetsPath.arrowUp,
                      color: AppColors.greenColor2,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '36,641.20',
                      style: textTheme.bodyMedium!.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: widget.isDarkMode.value
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
              OrderBookFieldWidget(
                isDarkMode: widget.isDarkMode,
                price: '31348.12',
                amount: '0.99982',
                total: '31,459.03',
                bgColor: AppColors.greenColor2,
                bgWidth: 1,
              ),
              OrderBookFieldWidget(
                isDarkMode: widget.isDarkMode,
                price: '36920.12',
                amount: '0.758965',
                total: '28,020.98',
                bgColor: AppColors.greenColor2,
                bgWidth: 0.3,
              ),
              OrderBookFieldWidget(
                isDarkMode: widget.isDarkMode,
                price: '45212.12',
                amount: '0.34523',
                total: '15,670.00',
                bgColor: AppColors.greenColor2,
                bgWidth: 0.1,
              ),
            ],
          );
        } else {
          return ValueListenableBuilder(
              valueListenable: showOrderBooks,
              builder: (context, val, _) {
                return Visibility(
                  visible: showOrderBooks.value,
                  replacement: Column(
                    children: [
                      SizedBox(height: 100.h),
                      const CircleProgressIndicator(),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 9),
                      ValueListenableBuilder(
                        valueListenable: filterType,
                        builder: (context, val, _) {
                          return Row(
                            children: [
                              InkWell(
                                onTap: () => filterType.value = 1,
                                child: Container(
                                  padding: const EdgeInsets.all(11),
                                  margin: const EdgeInsets.only(right: 4),
                                  decoration: BoxDecoration(
                                    color: filterType.value == 1
                                        ? widget.isDarkMode.value
                                            ? AppColors.greenColor3
                                            : AppColors.greyColor
                                        : null,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Image.asset(
                                    AssetsPath.filter1,
                                    width: 15.w,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => filterType.value = 2,
                                child: Container(
                                  padding: const EdgeInsets.all(11),
                                  margin: const EdgeInsets.only(right: 4),
                                  decoration: BoxDecoration(
                                    color: filterType.value == 2
                                        ? widget.isDarkMode.value
                                            ? AppColors.greenColor3
                                            : AppColors.greyColor
                                        : null,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Image.asset(
                                    AssetsPath.filter2,
                                    width: 15.w,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => filterType.value = 3,
                                child: Container(
                                  padding: const EdgeInsets.all(11),
                                  margin: const EdgeInsets.only(right: 4),
                                  decoration: BoxDecoration(
                                    color: filterType.value == 3
                                        ? widget.isDarkMode.value
                                            ? AppColors.greenColor3
                                            : AppColors.greyColor
                                        : null,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Image.asset(
                                    AssetsPath.filter3,
                                    width: 15.w,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  margin: const EdgeInsets.only(right: 4),
                                  decoration: BoxDecoration(
                                    color: widget.isDarkMode.value
                                        ? AppColors.greenColor3
                                        : AppColors.greyColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        '10',
                                        style: textTheme.titleSmall!.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: widget.isDarkMode.value
                                              ? AppColors.whiteColor
                                              : AppColors.darkBgColor,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: AppColors.lightGreyColor,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 12),
                                Text(
                                  'Price',
                                  style: textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: widget.isDarkMode.value
                                        ? AppColors.darkGreyColor
                                        : AppColors.lightGreyColor,
                                  ),
                                ),
                                Text(
                                  '(USDT)',
                                  style: textTheme.titleSmall!.copyWith(
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w500,
                                    color: widget.isDarkMode.value
                                        ? AppColors.darkGreyColor
                                        : AppColors.lightGreyColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(height: 12),
                                Text(
                                  'Amounts',
                                  style: textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: widget.isDarkMode.value
                                        ? AppColors.darkGreyColor
                                        : AppColors.lightGreyColor,
                                  ),
                                ),
                                Text(
                                  '(BTC)',
                                  style: textTheme.titleSmall!.copyWith(
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w500,
                                    color: widget.isDarkMode.value
                                        ? AppColors.darkGreyColor
                                        : AppColors.lightGreyColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Total',
                              style: textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: widget.isDarkMode.value
                                    ? AppColors.darkGreyColor
                                    : AppColors.lightGreyColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      OrderBookFieldWidget(
                        isDarkMode: widget.isDarkMode,
                        price: '39620.34',
                        amount: '0.56980',
                        total: '23,080.99',
                        bgColor: AppColors.redColor2,
                        bgWidth: 0.24,
                      ),
                      OrderBookFieldWidget(
                        isDarkMode: widget.isDarkMode,
                        price: '20780.00',
                        amount: '0.34909',
                        total: '15,200.92',
                        bgColor: AppColors.redColor2,
                        bgWidth: 0.03,
                      ),
                      OrderBookFieldWidget(
                        isDarkMode: widget.isDarkMode,
                        price: '40384.84',
                        amount: '1.436793',
                        total: '30,248.22',
                        bgColor: AppColors.redColor2,
                        bgWidth: 0.4,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '36,641.20',
                              style: textTheme.bodyMedium!.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.greenColor2,
                              ),
                            ),
                            const SizedBox(width: 8),
                            SvgPicture.asset(
                              AssetsPath.arrowUp,
                              color: AppColors.greenColor2,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '36,641.20',
                              style: textTheme.bodyMedium!.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: widget.isDarkMode.value
                                    ? AppColors.whiteColor
                                    : AppColors.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      OrderBookFieldWidget(
                        isDarkMode: widget.isDarkMode,
                        price: '31348.12',
                        amount: '0.99982',
                        total: '31,459.03',
                        bgColor: AppColors.greenColor2,
                        bgWidth: 1,
                      ),
                      OrderBookFieldWidget(
                        isDarkMode: widget.isDarkMode,
                        price: '36920.12',
                        amount: '0.758965',
                        total: '28,020.98',
                        bgColor: AppColors.greenColor2,
                        bgWidth: 0.3,
                      ),
                      OrderBookFieldWidget(
                        isDarkMode: widget.isDarkMode,
                        price: '45212.12',
                        amount: '0.34523',
                        total: '15,670.00',
                        bgColor: AppColors.greenColor2,
                        bgWidth: 0.1,
                      ),
                    ],
                  ),
                );
              });
        }
      },
    );
  }
}
