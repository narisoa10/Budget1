import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../providers/settings_model.dart';
import '../../styles/app_colors.dart';
import '../../localization/localization.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool automaticallyImplyLeading;
  final Color backgroundColor;
  final Color cardColor;

  const CustomAppBar({
    super.key,
    required this.scaffoldKey,
    this.automaticallyImplyLeading = true,
    this.backgroundColor = Colors.white,
    this.cardColor = AppColors.generalPageColor,
  });

  @override
  Size get preferredSize => const Size.fromHeight(110.0);

  @override
  CustomAppBarState createState() => CustomAppBarState();
}

class CustomAppBarState extends State<CustomAppBar> {
  bool _isFlashing = false;
  bool _isVisible = true;
  Timer? _flashingTimer; // Хранение ссылки на таймер

  late SettingsModel _settingsModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _settingsModel = Provider.of<SettingsModel>(context);

    // Запуск мигания при необходимости
    if (_shouldFlash()) {
      _startFlashing();
    } else {
      _stopFlashing();
    }
  }

  bool _shouldFlash() {
    final balance = _settingsModel.totalIncome - _settingsModel.totalExpense;
    final warningLimit = _settingsModel.totalIncome * (_settingsModel.warningThreshold / 100);
    final criticalLimit = _settingsModel.totalIncome * (_settingsModel.criticalThreshold / 100);
    return balance < criticalLimit || balance < warningLimit;
  }

  void _startFlashing() {
    _isFlashing = true;
    _flashingTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (!_isFlashing || !mounted) {
        timer.cancel();
      } else {
        setState(() {
          _isVisible = !_isVisible;
        });
      }
    });
  }

  void _stopFlashing() {
    _isFlashing = false;
    _flashingTimer?.cancel(); // Останавливаем таймер
  }

  @override
  void dispose() {
    _stopFlashing(); // Останавливаем мигание перед уничтожением виджета
    super.dispose();
  }

  Widget _buildInfoCard(
      BuildContext context,
      String title,
      String value,
      IconData icon, {
        bool isBalance = false,
      }) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = screenWidth * 0.3;

    final balance = _settingsModel.totalIncome - _settingsModel.totalExpense;
    final warningLimit = _settingsModel.totalIncome * (_settingsModel.warningThreshold / 100);
    final criticalLimit = _settingsModel.totalIncome * (_settingsModel.criticalThreshold / 100);

    Color dynamicCardColor = widget.cardColor;

    if (isBalance) {
      if (balance < criticalLimit) {
        dynamicCardColor = Colors.red;
      } else if (balance < warningLimit) {
        dynamicCardColor = Colors.orangeAccent;
      }
    }

    final bool isDarkCardColor = ThemeData.estimateBrightnessForColor(dynamicCardColor) == Brightness.dark;
    final Color iconAndTextColor = isDarkCardColor ? Colors.white : Colors.black;

    return SizedBox(
      width: cardWidth,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isBalance && _isFlashing ? (_isVisible ? 1.0 : 0.3) : 1.0,
        child: Card(
          color: dynamicCardColor,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: iconAndTextColor, size: 20),
                const SizedBox(height: 4),
                Text(
                  Localization.getTranslation(title),
                  style: TextStyle(
                    fontSize: 12,
                    color: iconAndTextColor.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: iconAndTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: widget.backgroundColor,
      statusBarIconBrightness: Brightness.dark,
    ));

    String selectedCurrency = _settingsModel.selectedCurrency;
    double totalIncome = _settingsModel.totalIncome;
    double totalExpense = _settingsModel.totalExpense;

    // Форматируем числа до двух знаков после запятой
    String formattedIncome = totalIncome.toStringAsFixed(2);
    String formattedExpense = totalExpense.toStringAsFixed(2);
    String formattedBalance = (totalIncome - totalExpense).toStringAsFixed(2);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: widget.backgroundColor,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoCard(
                    context,
                    'income',
                    '$formattedIncome $selectedCurrency',
                    Icons.attach_money,
                  ),
                  _buildInfoCard(
                    context,
                    'expense',
                    '$formattedExpense $selectedCurrency',
                    Icons.money_off,
                  ),
                  _buildInfoCard(
                    context,
                    'balance',
                    '$formattedBalance $selectedCurrency',
                    Icons.account_balance_wallet,
                    isBalance: true,
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 1,
          color: Colors.grey[300],
        ),
      ],
    );
  }
}
