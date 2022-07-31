import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawayo/core/blocs/bloc/leave_bloc.dart';

import 'package:sawayo/core/data/models/leave.dart';
import 'package:sawayo/ui/widgets/profile_pic.dart';
import 'package:sawayo/ui/widgets/vertical_spacer.dart';

import '../designs/decorations.dart';

class UserCard extends StatelessWidget {
  final Leave user;
  const UserCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  Widget _buildInfoCard(String title, String value) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Colors.black54,
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
          const VerticalSpacer(10),
          Text(
            value,
            style: const TextStyle(color: Colors.black87, fontSize: 14),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: 100,
        left: 0,
        right: 0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          decoration: whiteContainer,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Murtaza Agaz',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Flutter Developer',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      BlocProvider.of<LeavesBloc>(context).add(NavToAddLeave());
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(90)),
                      child: const Icon(
                        Icons.add,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              const VerticalSpacer(10),
              const Divider(
                height: .5,
              ),
              const VerticalSpacer(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildInfoCard('Available', '${user.avaialableLeaves}'),
                  Container(
                    color: Colors.grey[300],
                    height: 40,
                    width: .5,
                  ),
                  _buildInfoCard('All', '${user.totalLeaves}'),
                  Container(
                    color: Colors.grey[300],
                    height: 40,
                    width: .5,
                  ),
                  _buildInfoCard('Used', '${user.usedLeaves}'),
                ],
              )
            ],
          ),
        ),
      ),
      const ProfilePic('https://blog.herzing.ca/hubfs/iStock-1282402777.jpg'),
    ]);
  }
}
