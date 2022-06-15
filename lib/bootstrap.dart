import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql/client.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'src/src.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  final dr = await getApplicationDocumentsDirectory();
  Hive.init(dr.path);
  final box = await Hive.openBox<String>('data');

  final homeClient = GraphQLClient(
    cache: GraphQLCache(),
    link: HttpLink('https://rickandmortyapi.com/graphql'),
  );

  final todoClient = GraphQLClient(
    cache: GraphQLCache(),
    link: HttpLink('https://graphqlzero.almansi.me/api'),
  );

  setup(box, homeClient, todoClient);

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async => runApp(await builder()),
        blocObserver: AppBlocObserver(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
