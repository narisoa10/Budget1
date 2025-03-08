import 'package:flutter/material.dart';
import '../widgets/appbars/custom_app_bar.dart';
import '../localization/localization.dart';
import '../styles/app_colors.dart';
import '../pages/income_page.dart';
import '../pages/category_page.dart';
import '../pages/report_page.dart';
import '../widgets/custom_drawer.dart';

class HomePage extends StatefulWidget {
  final String currency;

  const HomePage({super.key, required this.currency});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onItemTapped(int index) {
    if (index == 3) {
      _scaffoldKey.currentState?.openDrawer();
    } else {
      setState(() {
        _selectedIndex = index;
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300), // Устанавливаем продолжительность анимации
          curve: Curves.easeInOut, // Устанавливаем кривую анимации
        );
      });
    }
  }


  List<BottomNavigationBarItem> _buildBottomNavBarItems() {
    final items = [
      {
        'icon': Icons.shopping_cart,
        'color': AppColors.expense1ButtonColor.withOpacity(0.7),
        'label': 'expense',
      },
      {
        'icon': Icons.account_balance_wallet,
        'color': AppColors.incomeButtonColor.withOpacity(0.7),
        'label': 'income',
      },
      {
        'icon': Icons.bar_chart,
        'color': AppColors.reportButtonColor.withOpacity(0.7),
        'label': 'report',
      },
      {
        'icon': Icons.menu,
        'color': AppColors.plusButtonBackgroundColor.withOpacity(0.7),
        'label': 'menu',
      },
    ];

    return items.map((item) {
      return BottomNavigationBarItem(
        icon: Icon(item['icon'] as IconData, color: item['color'] as Color),
        label: Localization.getTranslation(item['label'] as String),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Localization.load(Localizations.localeOf(context));

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        scaffoldKey: _scaffoldKey,
        automaticallyImplyLeading: false,
      ),
      drawer: const CustomDrawer(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          CategoryPage(selectedCurrency: widget.currency),
          IncomePage(selectedCurrency: widget.currency),
          ReportPage(),
        ],
      ),
      bottomNavigationBar: Opacity(
        opacity: 1.0, // Прозрачность для всего BottomNavigationBar
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: _buildBottomNavBarItems(),
          backgroundColor: AppColors.generalPageColor, // Используем непрозрачный цвет
          selectedLabelStyle: const TextStyle(fontSize: 10),
          unselectedLabelStyle: const TextStyle(fontSize: 10),
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.expensePageColor, // Обычные цвета без withOpacity
          unselectedItemColor: Colors.white, // Обычные цвета без withOpacity
        ),
      ),
    );
  }
  }
