import 'package:algolia/algolia.dart';

class AlgoliaService {
  // Singleton pattern for a single instance
  static final AlgoliaService _instance = AlgoliaService._();

  AlgoliaService._();

  static AlgoliaService get instance => _instance;

  // Initialize Algolia
  Algolia get algolia => const Algolia.init(
        applicationId: 'NP2WCZJCDV',
        apiKey: '43d8a54389e206d2eca716c0da224ed2',
      );
}
