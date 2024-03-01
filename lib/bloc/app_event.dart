import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

final class OnGetRequestEvent extends AppEvent {}

final class OnPostRequestEvent extends AppEvent {}

final class OnCalculateEvent extends AppEvent {}

final class OnEmailInputChangedEvent extends AppEvent {
  final String url;

  const OnEmailInputChangedEvent(this.url);

  @override
  List<Object?> get props => [url];
}
