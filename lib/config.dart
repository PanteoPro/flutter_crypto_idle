class AppConfig {
  static const kRentFlat = 0.05;
  static const kEnergyPc = 0.2;
  static const kSellPc = 0.6;
  static const kStartIncomePC = 0.025;
  static const kDecreaseIncomePC = 0.0005;
  static const kVisualEnergy = 4.25;
  static const kVisualPower = 3.25;
  static const kStartCountPc = 5;
  static const kPcCosts = [
    100,
    150,
    250,
    400,
    600,
    800,
    1000,
    1400,
    1800,
    2500,
    3000,
    3500,
    4200,
    5000,
    5800,
    6650,
    7900,
    9400,
    11000,
    13000,
    15500,
    19000,
    23000,
    30000,
    45000,
  ];
  static const kFlatCost = [
    0,
    1500,
    5000,
    12000,
    22000,
    30000,
    45000,
    70000,
    100000,
    165000,
    300000,
  ];
  static double minByLevel(int level) {
    return 0.01 + (level - 1) * 0.03;
  }

  static double maxByLevel(int level) {
    return 0.2 + (level - 1) * 0.25;
  }

  static double critByLevel(int level) {
    return 1 + (level - 1) * 1.25;
  }

  static double probabilityByLevel(int level) {
    return 0.05 + (level - 1) * 0.002;
  }

  static double upgradeCostByLevel(int level) {
    return (50 * level) *
        ((minByLevel(level) + maxByLevel(level)) / 2 + (critByLevel(level) * probabilityByLevel(level)));
  }
}
