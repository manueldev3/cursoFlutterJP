import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_m4/controllers/position_controller.dart';

import 'package:proyecto_m4/model/position.dart';

/// Position provider
class PositionsNotifier extends StateNotifier<List<PositionModel>> {
  /// Constructor
  PositionsNotifier(super.state);

  /// Position controller
  final PositionController positionController = PositionController();

  /// Get positins
  Future<void> getAll() async {
    state = await positionController.getAll();
  }
}

/// Positions provider
final StateNotifierProvider<PositionsNotifier, List<PositionModel>>
positionsProvider =
StateNotifierProvider<PositionsNotifier, List<PositionModel>>(
  (StateNotifierProviderRef<PositionsNotifier, List<PositionModel>> ref) =>
    PositionsNotifier(<PositionModel>[]),
);
