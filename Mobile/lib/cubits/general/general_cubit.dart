import 'package:altcointrader/core/extensions/master_state.dart';
import 'package:altcointrader/cubits/general/models/error_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:simple_icons/simple_icons.dart';

part 'general_state.dart';

class GeneralCubit extends Cubit<MasterState<GeneralState>> {
  GeneralCubit() : super(const Initial(GeneralState()));

  void reset() {
    emit(const Initial(GeneralState()));
  }

  Future<void> log(ErrorModel log) async {
    try {
      emit(Loaded(state.main, message: log.error));
    } catch (error, stackTrace) {
      emit(Error(state.main, message: error.toString(), stackTrace: stackTrace.toString()));
    }
  }

  Future<void> launchUrl(String url) async {
    try {
      await url_launcher.launchUrl(Uri.parse(url));
    } catch (error, stackTrace) {
      emit(Error(state.main, message: error.toString(), stackTrace: stackTrace.toString()));
    }
  }
}
