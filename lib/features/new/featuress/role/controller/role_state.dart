part of 'role_cubit.dart';

@immutable
abstract class RoleState {}

class RoleInitial extends RoleState {}

class RolePageChanged extends RoleState {}

class RoleTypeChanged extends RoleState {}
