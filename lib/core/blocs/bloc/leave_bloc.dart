import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sawayo/core/data/dummyData/leave_dummy.dart';
import 'package:sawayo/core/data/models/leave.dart';
import 'package:sawayo/ui/utils/utils.dart';

part 'leave_event.dart';
part 'leave_state.dart';

class LeavesBloc extends Bloc<LeavesEvent, LeaveState> {
  /* In a real world scenario initial leaves data would have been fetched from the API for demo purpose 
  I am using my dummmy data class*/
  final Leave leave = LeaveDummy().leaveDumy;

  final List<DateTime> dateList = [];
  LeavesBloc() : super(LeaveLoadingState()) {
    on<FetchLeaveEvent>(fetchLeaveInfo);
    on<NavToAddLeave>(navToAddLeave);
    on<UpdateLeaveEvent>(updateLeaveInfo);
    on<AddLeaveEvent>(addLeave);
  }

  fetchLeaveInfo(FetchLeaveEvent event, Emitter emit) {
    emit(LeaveLoadedState(leave));
  }

  navToAddLeave(event, Emitter emit) {
    emit(NavToAddLeaveState());
  }

  updateLeaveInfo(UpdateLeaveEvent event, Emitter emit) {
    String fromDate = '';
    String toDate = '';
    if (event.range != null) {
      fromDate = Utils.formatDate(event.range!.start);
      toDate = Utils.formatDate(event.range!.end);
    }
    emit(LeaveUpdatedState(
        user: leave,
        from: fromDate,
        to: toDate,
        selectedType: event.selectedType));
  }

  addLeave(AddLeaveEvent event, Emitter emit) {
    if (event.selectedType.isEmpty) {
      emit(const LeaveAddFailedState(errorMsg: 'Please select a leave type'));
      return;
    }
    if (event.range == null) {
      emit(const LeaveAddFailedState(errorMsg: 'Please select dates of leave'));
      return;
    }
    DateTimeRange range = event.range!;
    int leaves = (range.duration.inDays + 1);
    if (leaves > leave.avaialableLeaves) {
      emit(const LeaveAddFailedState(
          errorMsg: 'You do not have enough leaves!'));
      return;
    }

    List<DateTime> days = [];
    for (int i = 0; i <= range.end.difference(range.start).inDays; i++) {
      DateTime dateTime = range.start.add(Duration(days: i));
      if (dateList.contains(dateTime)) {
        emit(LeaveAddFailedState(
            errorMsg:
                'You already have a leave on ${Utils.formatDate(dateTime)}'));
        return;
      }

      days.add(dateTime);
    }
    dateList.addAll(days);

    leave.avaialableLeaves -= leaves;
    leave.usedLeaves += leaves;

    emit(LeaveAddedState());
  }
}
