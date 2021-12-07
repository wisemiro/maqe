import 'package:bloc/bloc.dart';
import 'package:maqe/nav-bar/home/models/model.dart';
import 'package:maqe/nav-bar/home/repository/read_json.dart';
import 'package:maqe/nav-bar/home/service_locator.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'read_json_event.dart';
part 'read_json_state.dart';

class ReadJsonBloc extends Bloc<ReadJsonEvent, ReadJsonState> {
  ReadJsonBloc() : super(ReadJsonInitial()) {
    on<ReadJson>((event, emit) async {
      emit(ReadJsonLoading());
      try {
        final HolidayModel holidayModel =
            await locator.get<ReadJsonRepository>().ReadJ();
        emit(ReadJsonSuccess( holidayModel: holidayModel));
      } catch (e, s) {
        print(s);
        emit(ReadJsonError(error: "error"));
      }
    });
  }
}
