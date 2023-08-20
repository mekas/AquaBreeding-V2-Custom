class Urls {
  // static const String baseUrl = 'https://cc83-103-136-58-71.ngrok-free.app/api';
  static const String baseUrl = 'http://jft.web.id/fishapiv3/api';
  // static const String baseUrl = 'http://10.0.2.2:5000/api';

  // Home
  static const String statistic = '$baseUrl/statistic';

  // Pond
  static const String ponds = '$baseUrl/ponds';
  static String pond(String? pondId) => '$baseUrl/ponds/$pondId';

  // Activation
  static String activation(String? pondId) => '$baseUrl/ponds/status/$pondId';
  // Post Activation
  static String pondActivation(String? pondId) =>
      '$baseUrl/ponds/$pondId/activation';
  static String pondDeactivation(String? pondId) =>
      '$baseUrl/ponds/$pondId/closing';
  // Feed Type
  static const String feedType = '$baseUrl/feedtypes';
  // fish chart
  static String fishChart(String? activationId) =>
      '$baseUrl/fishchart/$activationId';

  // Feed History
  static const String feedhistorys = '$baseUrl/feedhistorys';
  static String feedHistoryMonthly(String? activationId) =>
      '$baseUrl/feedhistorys/month/$activationId';
  static String feedChartApi(String? activationId) =>
      '$baseUrl/feedhistoryforchart/$activationId';
  static String feedHistoryWeekly(String? activationId, month) =>
      '$baseUrl/feedhistorys/week/$activationId/$month';
  static String feedHistoryDaily(String? activationId, week) =>
      '$baseUrl/feedhistorys/day/$activationId/$week';
  static String feedHistory(String? activationId, date) =>
      '$baseUrl/feedhistorys/hour/$activationId/$date';
  static String feedChartHistory(String? type) =>
      '$baseUrl/feedhistoryforchart?type=$type';

  // Fish Grading
  static const String fishGradings = '$baseUrl/fishgradings';
  static String fishGrading(String? activationId) =>
      '$baseUrl/fishgradings/activation/$activationId';

  // Fish Death
  static const String fishDeaths = '$baseUrl/fishdeath';
  static String fishDeath(String? activationId) =>
      '$baseUrl/fishdeath/activation/$activationId';

  // Add Fish
  static const String addFish = '$baseUrl/addfish';

  //Treatment
  static const String treatment = '$baseUrl/pondtreatment';
  static String pondTreatment(String? activationId) =>
      '$baseUrl/fishdeath/activation/$activationId';

  //Water Quality
  static String dailyWater = '$baseUrl/dailywaterquality';
  static String weeklyWater = '$baseUrl/weeklywaterquality';

  static String dailyWaterbyid(String? dailywaterId) =>
      '$baseUrl/dailywaterquality/$dailywaterId';

  //Fish Transfer
  static String fishtransfer = '$baseUrl/fishtransfer';
  static String newfishtransfer = '$baseUrl/fishsort';

  //auth
  static String authentication = '$baseUrl/login';
  static String register = '$baseUrl/register';

  //user
  static String breeder = '$baseUrl/breeder';
  static String farm = '$baseUrl/farm';

  // inventories
  static String invSeed = '$baseUrl/inventory/seed';
  static String invFeed = '$baseUrl/inventory/feed';
  static String invSup = '$baseUrl/inventory/suplemen';
  static String invAsset = '$baseUrl/inventory/asset';
  static String invElect = '$baseUrl/inventory/electric';

  // histories
  static String seedSch = '$baseUrl/history/inventory/seed';
  static String feedSch = '$baseUrl/history/inventory/feed';
  static String suplemenSch = '$baseUrl/history/inventory/suplemen';
  static String logging = '$baseUrl/logging';

  // name list
  static String feedNameList = '$baseUrl/inventory/feed/name';
  static String suplemenNameList = '$baseUrl/inventory/suplemen/name';

  // recap deactivation
  static String deactivationRecap = '$baseUrl/recap/deactivation';
}
