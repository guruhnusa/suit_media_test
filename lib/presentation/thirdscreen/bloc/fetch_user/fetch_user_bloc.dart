// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:suit_media_test/data/datasources/auth_remote_datasource.dart';
import 'package:suit_media_test/data/models/user_model.dart';

part 'fetch_user_bloc.freezed.dart';
part 'fetch_user_event.dart';
part 'fetch_user_state.dart';

class FetchUserBloc extends Bloc<FetchUserEvent, FetchUserState> {
  final AuthRemoteDataSource authRemoteDataSource;

  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  FetchUserBloc(
    this.authRemoteDataSource,
  ) : super(const _Initial()) {
    on<_FetchUser>(
      (event, emit) async {
        emit(const _Loading());
        final response = await authRemoteDataSource.fetchUser(
          event.page,
        );
        response.fold((error) {
          emit(_Error(error));
        }, (data) {
          emit(_Success(data));
        });
      },
    );
    //refresh
    on<_Refresh>(
      (event, emit) async {
        emit(const _Loading());
        final response = await authRemoteDataSource.fetchUser(
          event.page,
        );
        response.fold((error) {
          emit(_Error(error));
        }, (data) {
          print(data.toString());
          emit(_Success(data));
        });
      },
    );

    on<_loadMore>(
      (event, emit) async {
        final response = await authRemoteDataSource.fetchUser(
          event.page,
        );
        response.fold((error) {
          emit(_Error(error));
        }, (data) {
          print(data.toString());
          emit(_Success(data));
        });
      },
    );
  }
}
