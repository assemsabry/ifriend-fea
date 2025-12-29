part of 'home_layout_cubit.dart';

@immutable
sealed class HomeLayoutState {
  Widget getWidget();
}

final class HomeLayoutInitial extends HomeLayoutState {
  @override
  Widget getWidget() {
    return Center(child: Text('Home Screen'));
  }
}

final class HomeLayoutLocationScreen extends HomeLayoutState {
  @override
  Widget getWidget() {
    return Center(child: Text("Location Screen"));
  }
}

final class HomeLayoutMessageScreen extends HomeLayoutState {
  @override
  Widget getWidget() {
    return Center(child: Text("Message Screen"));
  }
}

final class HomeLayoutProfileScreen extends HomeLayoutState {
  @override
  Widget getWidget() {
    return ProfileScreen();
  }
}
