import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import '../styles/app_colors.dart';
import '../styles/text_styles.dart';
import '../localization/localization.dart';
import '../pages/categories/personal_category_page.dart';

class CategoryButtonGrid extends StatefulWidget {
  final double horizontalPadding;
  final double verticalPadding;
  final String selectedCurrency;

  const CategoryButtonGrid({
    super.key,
    this.horizontalPadding = 4,
    this.verticalPadding = 16,
    required this.selectedCurrency,
  });

  @override
  CategoryButtonGridState createState() => CategoryButtonGridState();
}

class CategoryButtonGridState extends State<CategoryButtonGrid> {
  String? _personalCategoryTitleCache;

  @override
  void initState() {
    super.initState();
    _loadPersonalCategoryTitle();
  }

  Future<void> _loadPersonalCategoryTitle() async {
    var settingsBox = await Hive.openBox('settings');
    setState(() {
      _personalCategoryTitleCache = settingsBox.get('personal_category_title') ??
          Localization.getTranslation('personal_category');
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat.yMMMMd(Localizations.localeOf(context).toString()).format(DateTime.now());

    final categories = [
      {'name': Localization.getTranslation('food'), 'icon': Icons.restaurant},
      {'name': Localization.getTranslation('housing'), 'icon': Icons.home},
      {'name': Localization.getTranslation('health'), 'icon': Icons.local_hospital},
      {'name': Localization.getTranslation('clothing'), 'icon': Icons.checkroom},
      {'name': Localization.getTranslation('education'), 'icon': Icons.school},
      {'name': Localization.getTranslation('entertainment'), 'icon': Icons.movie},
      {'name': Localization.getTranslation('transport'), 'icon': Icons.directions_car},
      {'name': Localization.getTranslation('insurance'), 'icon': Icons.policy},
      {'name': Localization.getTranslation('miscellaneous'), 'icon': Icons.miscellaneous_services},
      {'name': Localization.getTranslation('debt'), 'icon': Icons.credit_card},
      {'name': Localization.getTranslation('charity'), 'icon': Icons.volunteer_activism},
    ];

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: widget.verticalPadding),
          child: Text(
            formattedDate,
            style: TextStyles.zagolovka,
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: categories.length + 1,
              itemBuilder: (context, index) {
                if (index == categories.length) {
                  // Button for personal category
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      backgroundColor: AppColors.expense1ButtonColor,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 1,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonalCategoryPage(
                            selectedCurrency: widget.selectedCurrency,
                          ),
                        ),
                      );

                    },
                    onLongPress: () {
                      _showEditTitleDialog(context);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.person, size: 24, color: AppColors.black),
                        Text(
                          _personalCategoryTitleCache ?? Localization.getTranslation('personal_category'),
                          textAlign: TextAlign.center,
                          style: TextStyles.bodyText8,
                        ),
                      ],
                    ),
                  );
                } else {
                  final category = categories[index];
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      backgroundColor: AppColors.plusButtonBackgroundColor,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: AppColors.expense1PageColor, width: 0.8),
                      ),
                      elevation: 1,
                    ),
                    onPressed: () {
                      _navigateToCategoryPage(context, category['name'] as String);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(category['icon'] as IconData, size: 24, color: AppColors.expense1PageColor),
                        Text(
                          category['name'] as String,
                          textAlign: TextAlign.center,
                          style: TextStyles.bodyText8,
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  void _showEditTitleDialog(context) {
    final TextEditingController titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(Localization.getTranslation('edit_page_title')),
          content: TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: Localization.getTranslation('enter_new_title'),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(Localization.getTranslation('cancel')),
            ),
            TextButton(
              onPressed: () async {
                String newTitle = titleController.text;
                if (newTitle.isNotEmpty) {
                  var settingsBox = await Hive.openBox('settings');
                  await settingsBox.put('personal_category_title', newTitle);
                  setState(() {
                    _personalCategoryTitleCache = newTitle;
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text(Localization.getTranslation('save')),
            ),
          ],
        );
      },
    );
  }

  void _navigateToCategoryPage(BuildContext context, String categoryName) {
    if (categoryName == Localization.getTranslation('food')) {
      Navigator.pushNamed(context, '/food');
    } else if (categoryName == Localization.getTranslation('housing')) {
      Navigator.pushNamed(context, '/housing');
    } else if (categoryName == Localization.getTranslation('health')) {
      Navigator.pushNamed(context, '/health');
    } else if (categoryName == Localization.getTranslation('clothing')) {
      Navigator.pushNamed(context, '/clothing');
    } else if (categoryName == Localization.getTranslation('education')) {
      Navigator.pushNamed(context, '/education');
    } else if (categoryName == Localization.getTranslation('entertainment')) {
      Navigator.pushNamed(context, '/entertainment');
    } else if (categoryName == Localization.getTranslation('transport')) {
      Navigator.pushNamed(context, '/transport');
    } else if (categoryName == Localization.getTranslation('insurance')) {
      Navigator.pushNamed(context, '/insurance');
    } else if (categoryName == Localization.getTranslation('miscellaneous')) {
      Navigator.pushNamed(context, '/miscellaneous');
    } else if (categoryName == Localization.getTranslation('debt')) {
      Navigator.pushNamed(context, '/debt');
    } else if (categoryName == Localization.getTranslation('charity')) {
      Navigator.pushNamed(context, '/charity');
    }
  }
}
