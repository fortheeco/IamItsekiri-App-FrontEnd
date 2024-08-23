import 'package:hive/hive.dart';
import 'package:oneitsekiri_flutter/models/tokens/token_model.dart';
import 'package:path_provider/path_provider.dart' as path_provider;


//! THIS CLASS IS BUILT TO SOLELY HANDLE ALL HIVE ADAPTER REGISTRATION
//! KINDLY ADD ALL ADAPTERS IN HERE.

class RegisterAdapters {
  static Future<void> registerAdapters() async {
    //! FETCH THE APP DOCUMENT PATH.
    final appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();

    //! INITIALIZE DB IN DOCUMENT PATH.
    Hive.init(appDocumentDirectory.path);

    //! OPEN STORAGE BOXES, INITIALIZE ADAPTERS & SAVE OBJECTS TO DB FOR SMOOTH RUNNING AND UPDATING.
    Hive.registerAdapter(UserTokenAdapter());
  }
}