import 'package:flutter_web_plugins/url_strategy.dart';

/// Hash : GitHub Pages ne réécrit pas les chemins ; évite les 404 sur les routes client.
void configureUrlStrategyForWeb() {
  setUrlStrategy(const HashUrlStrategy());
}
