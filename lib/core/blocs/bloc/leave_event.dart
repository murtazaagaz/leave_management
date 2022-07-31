part of 'leave_bloc.dart';

@immutable
abstract class LeavesEvent {
  const LeavesEvent();
}

class FetchLeaveEvent extends LeavesEvent {}

class UpdateLeaveEvent extends LeavesEvent {
  final DateTimeRange? range;
  final String selectedType;
  const UpdateLeaveEvent({
    this.range,
    required this.selectedType,
  });
}

class AddLeaveEvent extends LeavesEvent {
  final DateTimeRange? range;
  final String selectedType;
  const AddLeaveEvent({
    this.range,
    required this.selectedType,
  });
}

class NavToAddLeave extends LeavesEvent {}
