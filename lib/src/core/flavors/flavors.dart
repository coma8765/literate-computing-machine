import 'package:flutter/services.dart';

bool get isTesting => appFlavor == 'testing';

bool get isProduction => appFlavor == 'production';
