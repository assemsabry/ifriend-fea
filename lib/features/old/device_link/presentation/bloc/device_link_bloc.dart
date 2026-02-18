import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/generate_child_qr_use_case.dart';
import 'device_link_event.dart';
import 'device_link_state.dart';

class DeviceLinkBloc extends Bloc<DeviceLinkEvent, DeviceLinkState> {
  final GenerateChildQrUseCase _generateChildQrUseCase;

  DeviceLinkBloc(this._generateChildQrUseCase) : super(DeviceLinkInitial()) {
    on<GenerateQrToken>(_onGenerateQrToken);
  }

  Future<void> _onGenerateQrToken(
    GenerateQrToken event,
    Emitter<DeviceLinkState> emit,
  ) async {
    emit(DeviceLinkLoading());
    final result = await _generateChildQrUseCase();
    result.fold(
      (failure) => emit(
        DeviceLinkError(message: failure.message ?? 'An error occurred'),
      ),
      (qrCode) => emit(DeviceLinkQrLoaded(qrCode: qrCode)),
    );
  }
}
