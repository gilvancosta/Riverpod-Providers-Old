import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/helpers/pokemon_information.dart';

final pokemonNameProvider = FutureProvider.autoDispose<String>((ref) async {
  final pokemonId = ref.watch(pokemonIdProvider);

  final pokemonName = await PokemonInformation.getPokemonName(pokemonId);
  return pokemonName;
});

final pokemonIdProvider = StateProvider<int>((ref) {
  return 1;
});

final pokemonProvider =
    FutureProvider.family<String, int>((ref, pokemonId) async {
 // final pokemonId = ref.watch(pokemonIdProvider);
  final pokemonName = await PokemonInformation.getPokemonName(pokemonId);
  return pokemonName;
});
