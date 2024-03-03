import 'package:bloc/bloc.dart';
import 'package:test_webspark/bloc/app_event.dart';
import 'package:test_webspark/bloc/app_state.dart';
import 'package:test_webspark/repository/app_repository/app_repository.dart';
import 'package:test_webspark/utils/dijkstra_algorithm/dijkstra_algorithm.dart';
import 'package:test_webspark/utils/url_validator/url_validator.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AppRepository appRepository,
  })  : _appRepository = appRepository,
        super(const AppState()) {
    on<OnGetRequestEvent>(_onGetRequested);
    on<OnEmailInputChangedEvent>(_onUrlChanged);
    on<OnPostRequestEvent>(_onPostRequested);
    on<OnCalculateEvent>(_onCalculate);
  }

  final AppRepository _appRepository;

  void _onGetRequested(
    OnGetRequestEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(state.copyWith(getRequestStatus: GetRequestStatus.loading));

    try {
      final taskModel = await _appRepository.getTask(state.url);

      emit(state.copyWith(getRequestStatus: GetRequestStatus.success, errorMessage: '', taskModel: taskModel));
    } catch (error) {
      emit(state.copyWith(getRequestStatus: GetRequestStatus.failure, errorMessage: error.toString()));
    }
  }

  void _onPostRequested(
    OnPostRequestEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(state.copyWith(postRequestStatus: PostRequestStatus.loading));
    try {
      final responseModel = await _appRepository.postTaskResult(state.url, state.resultModel);
      emit(
          state.copyWith(postRequestStatus: PostRequestStatus.success, errorMessage: '', responseModel: responseModel));
    } catch (error) {
      emit(state.copyWith(postRequestStatus: PostRequestStatus.failure, errorMessage: error.toString()));
    }
  }

  void _onCalculate(
    OnCalculateEvent event,
    Emitter<AppState> emit,
  ) {
    final resultModel = solveAllTasks(state.taskModel);
    emit(state.copyWith(resultModel: resultModel));
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
