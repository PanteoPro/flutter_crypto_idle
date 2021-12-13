class AppImages {
  static String getTokenPathBySymbol(String symbol) {
    final result = 'assets/images/tokens/${symbol.toLowerCase()}.png';
    return result;
  }
}
