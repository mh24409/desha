abstract class TrackCheckingStates {}

class TrackCheckingInitState extends TrackCheckingStates {}

class TrackCheckingLoadingState extends TrackCheckingStates {}

class TrackCheckingSuccessState extends TrackCheckingStates {
  final bool isCheckIn;
  TrackCheckingSuccessState(this.isCheckIn);
}

class TrackCheckingFailedState extends TrackCheckingStates {}
