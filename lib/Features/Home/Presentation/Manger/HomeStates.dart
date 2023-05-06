abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeChangeThemeState extends HomeStates {}

class HomeChangeEmumMode extends HomeStates {}

class HomeDataSuccessfully extends HomeStates {}

class HomeDataFailer extends HomeStates {
  final String errormessage;

  HomeDataFailer(this.errormessage);
}

class HomeDataLoading extends HomeStates {}
