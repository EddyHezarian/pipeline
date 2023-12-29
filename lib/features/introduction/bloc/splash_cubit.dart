import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipeline/features/introduction/repository/splash_repo.dart';

part 'splash_states.dart';
part 'connection_status.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState(connectionStatus: InitialConnection()));
  SplashRepository repo = SplashRepository();

  eventConnectionChecker() async {
    emit(state.copyWith(newConnectionStatus: InitialConnection()));
    bool isConnection = await repo.checkConnectivity();
    if (isConnection) {
      emit(state.copyWith(newConnectionStatus: SuccessConnection()));
    } else {
      emit(state.copyWith(newConnectionStatus: FailedConnection()));
    }
  }
}
