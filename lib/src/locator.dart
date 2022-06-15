import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';

import 'src.dart';

final sl = GetIt.I;

void setup(
  Box<String> box,
  GraphQLClient homeClient,
  GraphQLClient todoClient,
) {
  sl
    ..registerLazySingleton<Connectivity>(Connectivity.new)
    ..registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(homeClient),
    )
    ..registerLazySingleton<HomeLocalDataSource>(
      () => HomeLocalDataSourceImpl(box),
    )
    ..registerLazySingleton<NetworkInfo>(
      () => NetworkInfo(sl<Connectivity>()),
    )
    ..registerLazySingleton<HomeReposiory>(
      () => HomeRepoImpl(
        sl<HomeLocalDataSource>(),
        sl<HomeRemoteDataSource>(),
        sl<NetworkInfo>(),
      ),
    )
    ..registerFactory<HomeCubit>(() => HomeCubit(sl<HomeReposiory>()))
    ..registerLazySingleton<TodoRemoteDataSource>(
      () => TodoRemoteImpl(todoClient),
    )
    ..registerLazySingleton<TodoLocalDataSource>(
      () => TodoLocalRepoImpl(box),
    )
    ..registerLazySingleton<AddTodoRemoteDataSource>(
      () => AddTodoRemoteDataSource(todoClient),
    )
    ..registerLazySingleton<TodoRepository>(
      () => TodoRepoImpl(
        sl<NetworkInfo>(),
        sl<TodoLocalDataSource>(),
        sl<TodoRemoteDataSource>(),
        sl<AddTodoRemoteDataSource>(),
      ),
    )
    ..registerFactory<TodoCubit>(
      () => TodoCubit(sl<TodoRepository>()),
    )
    ..registerFactory<UsersCubit>(
      () => UsersCubit(sl<TodoRepository>()),
    )
    ..registerFactory<AddTodoCubit>(
      () => AddTodoCubit(sl<TodoRepository>()),
    );
}
