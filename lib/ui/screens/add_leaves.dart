import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawayo/core/blocs/bloc/leave_bloc.dart';
import 'package:sawayo/ui/designs/decorations.dart';
import 'package:sawayo/ui/widgets/profile_pic.dart';
import 'package:sawayo/ui/widgets/vertical_spacer.dart';

class AddLeaves extends StatelessWidget {
  final LeavesBloc bloc;
  AddLeaves(this.bloc, {Key? key}) : super(key: key);

  final List<Map<String, dynamic>> reasons = [
    {'title': 'Parental', 'icon': Icons.baby_changing_station},
    {'title': 'Medical', 'icon': Icons.medical_services},
    {'title': 'Unpaid', 'icon': Icons.monetization_on},
    {'title': 'Special', 'icon': Icons.fireplace},
  ];

  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();

  String _selectedType = '';
  DateTimeRange? _range;
  Widget leaveReasonWidget(Map<String, dynamic> reason) {
    bool isSelected = reason['title'] == _selectedType;
    return GestureDetector(
      onTap: () {
        _selectedType = reason['title'];
        bloc.add(UpdateLeaveEvent(selectedType: _selectedType, range: _range));
      },
      child: Container(
        margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            color: isSelected ? Colors.black87 : Colors.grey[200],
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: whiteContainer.copyWith(
                  borderRadius: BorderRadius.circular(90)),
              child: Icon(
                reason['icon'],
                color: Colors.yellow[600],
              ),
            ),
            const VerticalSpacer(10),
            Text(
              reason['title'],
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black54,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmButton() => Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          gradient:
              const LinearGradient(colors: [Colors.orange, Colors.yellow]),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shadowColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const Text(
            'Confirm',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          onPressed: () {
            bloc.add(AddLeaveEvent(selectedType: _selectedType, range: _range));
          },
        ),
      ));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider.value(
          value: bloc,
          child: BlocConsumer<LeavesBloc, LeaveState>(
            listener: (context, state) {
              if (state is LeaveUpdatedState) {
                fromController.text = state.from;
                toController.text = state.to;
                _selectedType = state.selectedType;
              }
              if (state is LeaveAddFailedState) {
                showErrorDialog(context, state.errorMsg);
              }
              if (state is LeaveAddedState) {
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return Container(
                  color: Colors.yellow[600],
                  padding: const EdgeInsets.all(5),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        top: 100,
                        child: Container(
                          decoration: whiteContainer,
                          padding: const EdgeInsets.symmetric(
                              vertical: 30, horizontal: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'New Request',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w600),
                              ),
                              const VerticalSpacer(20),
                              GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        // crossAxisSpacing: 3,
                                        // mainAxisExtent: 3,
                                        childAspectRatio: 1.6,
                                        crossAxisCount: 2),
                                itemBuilder: (context, index) =>
                                    leaveReasonWidget(reasons[index]),
                                itemCount: reasons.length,
                              ),
                              const VerticalSpacer(),
                              TextField(
                                controller: fromController,
                                readOnly: true,
                                onTap: () {
                                  pickDateRange(context);
                                },
                                decoration:
                                    const InputDecoration(labelText: 'From'),
                              ),
                              TextField(
                                controller: toController,
                                readOnly: true,
                                onTap: () {
                                  pickDateRange(context);
                                },
                                decoration:
                                    const InputDecoration(labelText: 'To'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      _buildConfirmButton(),
                      const ProfilePic(
                          'https://blog.herzing.ca/hubfs/iStock-1282402777.jpg')
                    ],
                  ));
            },
          ),
        ),
      ),
    );
  }

  Future pickDateRange(context) async {
    _range = await showDateRangePicker(
        context: context, firstDate: DateTime.now(), lastDate: DateTime(2023));
    bloc.add(UpdateLeaveEvent(selectedType: _selectedType, range: _range));
  }

  showErrorDialog(context, String msg) {
    showModalBottomSheet(
        context: context,
        builder: (_) => Container(
              height: 100,
              alignment: Alignment.center,
              decoration: whiteContainer,
              padding: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.warning,
                    color: Colors.red[800],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    msg,
                    style: TextStyle(
                        color: Colors.red[800],
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                ],
              ),
            ));
  }
}
