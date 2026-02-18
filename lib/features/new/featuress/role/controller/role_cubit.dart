import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'role_state.dart';

enum UserRole { none, PARENT, CHILD }

class RoleCubit extends Cubit<RoleState> {
  RoleCubit() : super(RoleInitial());
  static RoleCubit get(BuildContext context) => BlocProvider.of(context);

  int? currentType;
  UserRole userRole = UserRole.none;

  void onTypeChange(int index) {
    currentType = index;
    userRole = index == 0 ? UserRole.PARENT : UserRole.CHILD;
    log(userRole.name);
    emit(RoleTypeChanged());
  }

  // @override
  // Future<void> close() {
  //   onboardController.dispose();
  //   return super.close();
  // }
}
