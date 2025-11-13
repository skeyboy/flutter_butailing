import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hello_world.g.dart';

@riverpod
String helloWorld(Ref ref) {
  return 'Hello world';
}
