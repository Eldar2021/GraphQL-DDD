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
    ..registerLazySingleton<GetCharactersUsecase>(
      () => GetCharactersUsecase(sl<HomeReposiory>()),
    )
    ..registerLazySingleton<GetEpisodesUsecase>(
      () => GetEpisodesUsecase(sl<HomeReposiory>()),
    )
    ..registerLazySingleton<GetLocationsUsecase>(
      () => GetLocationsUsecase(sl<HomeReposiory>()),
    )
    ..registerFactory<HomeCubit>(
      () => HomeCubit(
        sl<GetCharactersUsecase>(),
        sl<GetEpisodesUsecase>(),
        sl<GetLocationsUsecase>(),
      ),
    )
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
    ..registerLazySingleton<GetUsersUsecase>(
      () => GetUsersUsecase(sl<TodoRepository>()),
    )
    ..registerLazySingleton<GetTodosUsecase>(
      () => GetTodosUsecase(sl<TodoRepository>()),
    )
    ..registerLazySingleton(
      () => AddTodoUsecase(sl<TodoRepository>()),
    )
    ..registerFactory<TodoCubit>(
      () => TodoCubit(sl<GetTodosUsecase>()),
    )
    ..registerFactory<UsersCubit>(
      () => UsersCubit(sl<GetUsersUsecase>()),
    )
    ..registerFactory<AddTodoCubit>(
      () => AddTodoCubit(sl<AddTodoUsecase>()),
    );
}
