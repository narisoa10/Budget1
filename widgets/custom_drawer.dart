import 'package:flutter/material.dart';
import '../styles/app_colors.dart';
import '../styles/text_styles.dart';
import '../localization/localization.dart';
import '../pages/settings_page.dart';  // Подключаем страницу настроек

// Виджет для бокового меню Drawer
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // Загружаем локализацию для текущего языка
    Localization.load(Localizations.localeOf(context));

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.generalPageColor,  // Используем цвет из AppColors
            ),
            child: Text(
              Localization.getTranslation('menu'),  // Переводим слово 'Меню'
              style: TextStyles.appBarTextStyle1,  // Используем стиль текста из TextStyles
            ),
          ),
          _buildListTile(context, 'Registration', Icons.person_add, () {
            // Логика для перехода на страницу регистрации
          }),
          _buildListTile(context, 'login', Icons.login, () {
            // Логика для перехода на страницу входа
          }),
          _buildListTile(context, 'settings', Icons.settings, () {
            // Переход на страницу настроек
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          }),
          _buildListTile(context, 'report', Icons.report, () {
            // Логика для перехода на страницу отчетов
          }),
          _buildListTile(context, 'subscription', Icons.subscriptions, () {
            // Логика для перехода на страницу подписки
          }),
          _buildListTile(context, 'help', Icons.help, () {
            // Логика для перехода на страницу помощи
          }),
          _buildListTile(context, 'logout', Icons.logout, () {
            // Логика для выхода из аккаунта с подтверждением
            _showLogoutConfirmation(context);
          }),
          _buildListTile(context, 'deleteAccount', Icons.delete, () {
            // Логика для удаления аккаунта с подтверждением
            _showDeleteAccountConfirmation(context);
          }),
        ],
      ),
    );
  }

  // Вспомогательный метод для создания ListTile с иконкой и текстом
  Widget _buildListTile(BuildContext context, String translationKey, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.generalPageColor),  // Заменяем iconColor на другой цвет
      title: Text(
        Localization.getTranslation(translationKey),
        style: TextStyles.bodyText3,
      ),
      onTap: onTap,
    );
  }

  // Диалоговое окно для подтверждения выхода
  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Localization.getTranslation('logout')),
          content: Text(Localization.getTranslation('logoutConfirmation')),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Закрываем диалог
              child: Text(Localization.getTranslation('cancel')),
            ),
            TextButton(
              onPressed: () {
                // Логика выхода
                Navigator.of(context).pop();
                // Возможно, также нужно перенаправить на страницу входа
              },
              child: Text(Localization.getTranslation('confirm')),
            ),
          ],
        );
      },
    );
  }

  // Диалоговое окно для подтверждения удаления аккаунта
  void _showDeleteAccountConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Localization.getTranslation('deleteAccount')),
          content: Text(Localization.getTranslation('deleteAccountConfirmation')),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Закрываем диалог
              child: Text(Localization.getTranslation('cancel')),
            ),
            TextButton(
              onPressed: () {
                // Логика удаления аккаунта
                Navigator.of(context).pop();
              },
              child: Text(Localization.getTranslation('confirm')),
            ),
          ],
        );
      },
    );
  }
}
