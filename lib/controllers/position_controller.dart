import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_m4/controllers/controller.dart';
import 'package:proyecto_m4/model/collections.dart';
import 'package:proyecto_m4/model/position.dart';

/// Position controller
class PositionController extends Controller<PositionModel>{
  @override
  Future<List<PositionModel>> getAll() async {
    final List<PositionModel> list = <PositionModel>[];

    final QuerySnapshot<Map<String, dynamic>> query = await Collections
        .positions.get();

    for (
      final QueryDocumentSnapshot<Map<String, dynamic>> document in
      query.docs
    ) {
      list.add(PositionModel.fromDocument(document));
    }

    return list;
  }
}
