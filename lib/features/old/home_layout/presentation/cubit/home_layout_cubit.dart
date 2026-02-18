import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../new/featuress/parent/profile/view/screen/parentprofile_screen.dart';

part 'home_layout_state.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutState> {
  HomeLayoutCubit() : super(HomeLayoutInitial());

  int currentIndex = 0;
  List<String> title = ["Home", "Location", "Message", "My Profile"];

  void changeScreen(int index) {
    switch (index) {
      case 0:
        currentIndex = 0;
        emit(HomeLayoutInitial());
        break;
      case 1:
        currentIndex = 1;
        emit(HomeLayoutLocationScreen());
        break;
      case 2:
        currentIndex = 2;
        emit(HomeLayoutMessageScreen());
        break;
      case 3:
        currentIndex = 3;
        emit(HomeLayoutProfileScreen());
      default:
        emit(HomeLayoutInitial());
    }
  }
}
