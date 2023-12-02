import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_app/config/config.dart';
// provider de somente leitura
final simpleNameProvider = Provider<String>((ref) => 'Blade Runner 2049');

/// Esse tipo de provider é usado para prover um valor que não pode ser alterado.
/// O valor é fornecido uma vez e nunca pode ser alterado.
/// são muito usados para prover valores de configuração.
/// para prover instancia de classes para outros providers


final randomGeneratorProvider = Provider.autoDispose<String>((ref) => RandomGenerator.getRandomName());