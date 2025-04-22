import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    errorMethodCount: 2,
    methodCount: 2,
    lineLength: 400
  ),
);