import 'package:collection/collection.dart';
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
                    return _cardData(context, state,
                        state.holidayModel.leaveRequests[index]);
                  }),
            );
          }

          return CircularProgressIndicator.adaptive();
        }),
      ],
    ));
  }

  _cardData(BuildContext context, state, LeaveRequest leaveRequest) {
    Intl.defaultLocale = 'en_US';
    var month = leaveRequest.requestList[0].date;
    final DateFormat formatter = DateFormat('dd MMM yyyy');
    final String frmtd = formatter.format(month);

    var firstDate = leaveRequest.requestList.first.date;
    var lastDate = leaveRequest.requestList.last.date;

    final DateFormat lastDayformatter = DateFormat('dd');
    final String lastDay = lastDayformatter.format(lastDate);

    final DateFormat firstDayformatter = DateFormat('dd MMM yyyy');
    final String firstDay = firstDayformatter.format(firstDate);

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
            if (leaveRequest.requestList[0].type == "remote" ||
                leaveRequest.requestList[0].type == "personal_leave" ||
                leaveRequest.requestList[0].type == "sick_leave") ...[
              TitleText(
                inputText: "Leave",
                color: MaqeColor.titleColor,
                size: 22,
              ),
            ] else if (leaveRequest.requestList[0].type ==
                "switch_holiday") ...[
              TitleText(
                inputText: "Switch",
                color: MaqeColor.titleColor,
                size: 22,
              ),
            ],
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
                          child: (() {
                            switch (leaveRequest.requestList[0].type) {
                              case 'remote':
                                return Icon(Icons.desktop_mac_sharp);
                              case 'personal_leave':
                                return RotatedBox(
                                  quarterTurns: 3,
                                  child: Icon(
                                    Icons.flight_outlined,
                                  ),
                                );
                              case 'switch_holiday':
                                return Icon(
                                  Icons.shuffle,
                                );
                              case 'sick_leave':
                                return Icon(Icons.medical_services);
                            }
                          }()),
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
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: (() {
                          switch (leaveRequest.status) {
                            case 'pending':
                              return Icon(
                                Icons.access_time_filled,
                                color: MaqeColor.orangeColor,
                              );
                            case 'approved':
                              return Icon(
                                Icons.check_circle,
                                color: MaqeColor.greenColor,
                              );
                            case 'canceled':
                              return Icon(
                                Icons.cancel_rounded,
                                color: MaqeColor.lightGreyColor,
                              );
                          }
                        }()),
                      )),
                      TextSpan(
                        text: '${leaveRequest.status.toCapitalized()}',
                        style: TextStyle(
                          color: MaqeColor.subTitleColor,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            if (leaveRequest.requestList.length > 1) ...[
              RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: RotatedBox(
                            quarterTurns: 1,
                            child: Icon(Icons.flight_outlined)),
                      ),
                    ),
                    TextSpan(
                      text: '$lastDay - $firstDay',
                      style: TextStyle(
                        color: MaqeColor.subTitleColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  _headBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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

extension StringCasingExtension on String {
  String toCapitalized() =>
      this.length > 0 ? '${this[0].toUpperCase()}${this.substring(1)}' : '';
  String get toTitleCase => this
      .replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str.toCapitalized())
      .join(" ");
}
