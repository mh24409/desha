import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_view_control_state.dart';

class MainViewControlCubit extends Cubit<MainControlViewState> {
  MainViewControlCubit() : super(AccountViewStates());

  int selectedIndexForBottomBar = 0;

  void changeSelectedIndexForBottomBar(int newIndex) {
    selectedIndexForBottomBar = newIndex;
    if (selectedIndexForBottomBar == 0) {
      emit(AccountViewStates());
    } else if (selectedIndexForBottomBar == 1) {
      emit(ProductViewStates());
    } else if (selectedIndexForBottomBar == 2) {
      emit(CustomersViewStates());
    } else if (selectedIndexForBottomBar == 3) {
      emit(MapViewStates());
    }
  }
}
