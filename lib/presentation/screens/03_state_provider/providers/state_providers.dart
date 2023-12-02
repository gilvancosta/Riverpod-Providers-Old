import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/helpers/random_generator.dart';

final countProvider1 = StateProvider<int>((ref) {
  return 5;
});

final isDarkModeProvider = StateProvider<bool>((ref) {
  return false;
});

final randomNameProvider = Provider<String>((ref) {
  return RandomGenerator.getRandomName();
});


final countProvider2 = StateProvider<int>((ref) => 0);