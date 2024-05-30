import 'package:flutter/material.dart';

import 'app/app.dart';
import 'data/local/storage_repository.dart';

void main() async{
  runApp( App());
  await StorageRepository.init();
}




