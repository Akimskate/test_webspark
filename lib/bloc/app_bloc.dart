import 'package:bloc/bloc.dart';
import 'package:test_webspark/bloc/app_event.dart';
import 'package:test_webspark/bloc/app_state.dart';
import 'package:test_webspark/repository/app_repository/app_repository.dart';
import 'package:test_webspark/utils/url_validator/url_validator.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AppRepository appRepository,
  })  : _appRepository = appRepository,
        super(const AppState()) {
    on<OnGetRequestEvent>(_onGetRequested);
    on<OnEmailInputChangedEvent>(_onUrlChanged);
    on<OnPostRequestEvent>(_onPostRequested);
  }

  final AppRepository _appRepository;

  void _onGetRequested(
    OnGetRequestEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(state.copyWith(status: AppStatus.loading));

    try {
      final taskModel = await _appRepository.getTask(state.url);
      emit(state.copyWith(status: AppStatus.success, taskModel: taskModel));
    } catch (error) {
      emit(state.copyWith(status: AppStatus.failure, errorMessage: error.toString()));
    }
  }

  void _onPostRequested(
    OnPostRequestEvent event,
    Emitter<AppState> emit,
  ) async {
    try {
      await _appRepository.postTaskResult(state.url, state.resultModel);
      emit(state.copyWith(status: AppStatus.success));
    } catch (error) {
      emit(state.copyWith(status: AppStatus.failure, errorMessage: error.toString()));
    }
  }

  void _onUrlChanged(
    OnEmailInputChangedEvent event,
    Emitter<AppState> emit,
  ) {
    final isValid = UrlValidator.validateUrl(event.url) == null;
    if (isValid) {
      emit(state.copyWith(url: event.url, isValid: isValid));
    }
  }
}
