// const WEB_HOST = "https://www.butailing.com";
import 'package:alice/alice.dart';
import 'package:alice/model/alice_configuration.dart';
import 'package:alice_dio/alice_dio_adapter.dart';
// ignore: depend_on_referenced_packages
import 'package:logger/logger.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'config.config.dart';

@Singleton()
class Config {
  String get webHost => "https://web5.mukaku.com";
  // 'https://web5.mukaku.com/prod/api/v1'
  String get apiBaseUrl => "$webHost/prod/api/v1";

  String get torrentApiBaseUrl => 'http://127.0.0.1:8888';
}

// final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() => GetIt.instance.init();

// ignore: constant_identifier_names
final logger = Logger(printer: PrettyPrinter());

AliceDioAdapter aliceDioAdapter = AliceDioAdapter();
Alice alice = Alice(configuration: AliceConfiguration())
  ..addAdapter(aliceDioAdapter);
