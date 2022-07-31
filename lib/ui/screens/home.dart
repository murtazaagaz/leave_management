import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawayo/core/blocs/bloc/leave_bloc.dart';
import 'package:sawayo/ui/designs/decorations.dart';
import 'package:sawayo/ui/screens/add_leaves.dart';
import 'package:sawayo/ui/widgets/user_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final LeavesBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = LeavesBloc()..add(FetchLeaveEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => _bloc,
          child: Container(
            color: Colors.yellow[600],
            padding: const EdgeInsets.all(5),
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    flex: 2,
                    child: BlocConsumer<LeavesBloc, LeaveState>(
                      listener: (context, state) {
                        if (state is NavToAddLeaveState) {
                          navToAddLeave();
                        }
                      },
                      builder: (context, state) {
                        if (state is LeaveLoadedState) {
                          return UserCard(user: state.user);
                        }
                        return Container();
                      },
                    )),
                Expanded(
                    flex: 3,
                    child: Container(
                      decoration: whiteContainer,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> navToAddLeave() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => AddLeaves(_bloc)));
    _bloc.add(FetchLeaveEvent());
  }
}
