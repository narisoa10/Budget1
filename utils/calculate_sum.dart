// Файл: calculate_sum.dart

double calculateSum(List<List<String>> data, int priceIndex, int quantityIndex, int totalIndex) {
  double totalSum = 0.0;
  for (var row in data) {
    if (row.length > totalIndex) {
      try {
        double pricePerUnit = double.parse(row[priceIndex]);
        double quantity = double.parse(row[quantityIndex]);
        double total = pricePerUnit * quantity;

        // Обновляем значение total в соответствующей ячейке
        row[totalIndex] = total.toStringAsFixed(2);

        // Суммируем все значения total
        totalSum += total;
      } catch (e) {
        // Игнорируем ошибки при конвертации
      }
    }
  }
  return totalSum;
}
