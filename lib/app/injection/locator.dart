import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:good_app/app/injection/locator.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();
