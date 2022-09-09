

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeCubitStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  TextEditingController newPass = TextEditingController();
  TextEditingController confirmNewPass = TextEditingController();
  List days = ["01","02","03","04","05","06","07"];
  List title = ["S","S","M","T","W","T","F"];
  List taskName = ["Team Meeting","Call the staylish","Check mail","Go to gym"];
  List subTitle = ["Discuss all questions about new projects","Agree on an evening look","Write the message","play sports"];
  List taskImage = ["assets/images/meeting.png","assets/images/phone.png","assets/images/mail.png","assets/images/gym.png",];
  List taskTime = ["10:00 Am","11:00 Am","12:00 Pm","01:00 pm"];
  int selectedIndex=0;
  onSelected(int index) {
    selectedIndex = index;
    emit(SwitchState());
  }
}
