import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'create_task_states.dart';

class CreateTaskCubit extends Cubit<CreateTaskStates> {
  CreateTaskCubit() : super(CreateTaskInitialState());

  static CreateTaskCubit get(context) => BlocProvider.of(context);

  List title = ["Development","Research","Design","Backend","Playing",];
  TextEditingController dateCtrl = TextEditingController();
  TextEditingController startCtrl = TextEditingController();
  TextEditingController endCtrl = TextEditingController();
  int selectedIndex=0;
  onSelected(int index) {
    selectedIndex = index;
    emit(SwitchState());
  }
  /// Select start date
  void selectDate(value) {
    dateCtrl.text = DateFormat.yMMMMEEEEd().format(value!);
    emit(DateState());
  }

  /// Select start time
  void selectStartTime(newValue) {
    startCtrl.text = newValue;
    emit(GetStartState());
  }
  /// Select End time
  void selectEndTime(newValue) {
    endCtrl.text = newValue;
    emit(GetEndState());
  }
}
