// const WEB_HOST = "https://www.butailing.com";
import 'package:alice/alice.dart';
import 'package:alice/model/alice_configuration.dart';
import 'package:alice_dio/alice_dio_adapter.dart';
import 'package:logger/logger.dart';

// ignore: constant_identifier_names
const WEB_HOST = "https://web5.mukaku.com";
final logger = Logger(printer: PrettyPrinter());

AliceDioAdapter aliceDioAdapter = AliceDioAdapter();

AliceConfiguration configuration = AliceConfiguration();
Alice alice = Alice(configuration: configuration)..addAdapter(aliceDioAdapter);
