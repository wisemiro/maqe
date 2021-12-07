part of 'read_json_bloc.dart';

class ReadJsonState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ReadJsonInitial extends ReadJsonState {
  List<Object?> get props => [];
}

class ReadJsonError extends ReadJsonState {
  final String error;

  ReadJsonError({required this.error});

  List<Object?> get props => [error];
}

class ReadJsonLoading extends ReadJsonState {}

class ReadJsonSuccess extends ReadJsonState {
  final HolidayModel holidayModel;

  ReadJsonSuccess({required this.holidayModel});
  List<Object?> get props => [HolidayModel];
}
