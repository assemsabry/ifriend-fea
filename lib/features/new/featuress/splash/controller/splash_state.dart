part of 'splash_cubit.dart';

abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashNavigate extends SplashState {}

class SplashForceUpdate extends SplashState {
  final String storeUrl;
  SplashForceUpdate(this.storeUrl);
}
