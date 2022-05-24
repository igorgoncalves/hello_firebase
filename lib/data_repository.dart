import 'package:cloud_firestore/cloud_firestore.dart';

class DataRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAll() {
    CollectionReference tarefasRef = firestore.collection("tarefas");
    final snapshots = tarefasRef.snapshots();
    return snapshots;
  }

  Future create({required String titulo}) async {
    CollectionReference tarefasRef = firestore.collection("tarefas");
    return await tarefasRef.add({'titulo': titulo});
  }

  Future delete({required String idDocument}) async {
    CollectionReference tarefasRef = firestore.collection("tarefas");
    return await tarefasRef.doc(idDocument).delete();
  }
}
