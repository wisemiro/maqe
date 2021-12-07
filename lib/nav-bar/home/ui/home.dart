import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:maqe/nav-bar/home/blocs/bloc/read_json_bloc.dart';
import 'package:maqe/nav-bar/home/models/model.dart';
import 'package:maqe/nav-bar/home/ui/subs/top-data.dart';
import 'package:maqe/theme/colors.dart';
import 'package:maqe/theme/style.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        TopData(),
        _headBody(),
        BlocBuilder<ReadJsonBloc, ReadJsonState>(builder: (context, state) {
          if (state is ReadJsonLoading) {
            return CircularProgressIndicator();
          }
          if (state is ReadJsonError) {
            return Center(
              child: Text("$state.error"),
            );
          }
          if (state is ReadJsonSuccess) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: state.holidayModel.leaveRequests.length,
                  itemBuilder: (context, index) {
                    return _cardData(context, index,
                        state.holidayModel.leaveRequests[index]);
                  }),
            );
          }

          return CircularProgressIndicator.adaptive();
        }),
      ],
    ));
  }

  _cardData(BuildContext context, index, LeaveRequest leaveRequest) {
    Intl.defaultLocale = 'en_US';
    var month = leaveRequest.requestList[0].date;
    final DateFormat formatter = DateFormat('dd MMM yyyy');
    final String frmtd = formatter.format(month);
  
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
              inputText:
                  "${leaveRequest.requestList[0].type.replaceAll(RegExp(r'_'), '')}",
              color: MaqeColor.titleColor,
              size: 22,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Icon(Icons.desktop_mac_sharp),
                        ),
                      ),
                      TextSpan(
                        text: '$frmtd',
                        style: TextStyle(
                          color: MaqeColor.subTitleColor,
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            child: (() {
                              print(leaveRequest.status);
                              if (leaveRequest.status.toString() == 1) {
                                Icon(
                                  Icons.access_time_filled,
                                  color: MaqeColor.orangeColor,
                                );
                              } else if (leaveRequest.status == "approved") {
                                Icon(
                                  Icons.circle_sharp,
                                  color: MaqeColor.orangeColor,
                                );
                              }
                            }())),
                      ),
                      TextSpan(
                        text: '${leaveRequest.status}',
                        style: TextStyle(
                          color: MaqeColor.subTitleColor,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: RotatedBox(
                          quarterTurns: 1, child: Icon(Icons.flight_outlined)),
                    ),
                  ),
                  TextSpan(
                    text: ' 28-29 Mar 2021',
                    style: TextStyle(
                      color: MaqeColor.subTitleColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _headBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TitleText(
            inputText: "My request",
            color: MaqeColor.titleColor,
            size: 22,
            fontWeight: FontWeight.bold,
          ),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: MaqeColor.blueColor,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .01,
              ),
              SubTitleText(
                  inputText: "Public holidays",
                  color: MaqeColor.blueColor,
                  size: 20)
            ],
          ),
        ],
      ),
    );
  }
}
