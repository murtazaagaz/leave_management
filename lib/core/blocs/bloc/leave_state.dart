part of 'leave_bloc.dart';

@immutable
abstract class LeaveState {
  const LeaveState();
}

class LeaveLoadingState extends LeaveState {}

class NavToAddLeaveState extends LeaveState {}

class LeaveLoadedState extends LeaveState {
  final Leave user;
  const LeaveLoadedState(
    this.user,
  );
}

class LeaveUpdatedState extends LeaveState {
  final Leave user;
  final String from;
  final String to;
  final String selectedType;
  const LeaveUpdatedState({
    required this.user,
    this.from = '',
    this.to = '',
    this.selectedType = '',
  });
}

class LeaveAddedState extends LeaveState {}

class LeaveAddFailedState extends LeaveState {
  final String errorMsg;
  const LeaveAddFailedState({
    required this.errorMsg,
  });
}
