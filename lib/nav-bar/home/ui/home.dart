import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:maqe/nav-bar/home/blocs/bloc/read_json_bloc.dart';
import 'package:maqe/nav-bar/home/models/model.dart';
import 'package:maqe/theme/colors.dart';
import 'package:maqe/theme/style.dart';
import 'package:maqe/extension/extension.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'en_US';
    return BlocBuilder<ReadJsonBloc, ReadJsonState>(builder: (context, state) {
      if (state is ReadJsonLoading) {
        return CircularProgressIndicator();
      }
      if (state is ReadJsonError) {
        return Center(
          child: Text("error reading from json err:$state.error"),
        );
      }
      if (state is ReadJsonSuccess) {
        return Column(
          children: [
            _topData(state.holidayModel),
            _headBody(),
            Flexible(
              flex: 1,
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: state.holidayModel.leaveRequests.length,
                    itemBuilder: (context, index) {
                      return _cardData(context, state,
                          state.holidayModel.leaveRequests[index]);
                    }),
              ),
            ),
          ],
        );
      }
      return CircularProgressIndicator.adaptive();
    });
  }

  _headBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
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

  _topData(HolidayModel holidayModel) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  stops: [0.5, 0.5],
                  colors: [MaqeColor.lightblueColor, Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                //card title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitleText(
                      inputText: "My holiday",
                      color: MaqeColor.titleColor,
                      size: 22,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //total data
                      Column(
                        children: [
                          TitleText(
                            inputText: '${holidayModel.totalDay}',
                            color: MaqeColor.titleColor,
                            size: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          SubTitleText(
                            inputText: "Total",
                            color: MaqeColor.subTitleColor,
                            size: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ],
                      ),
                      //used data
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .05,
                        ),
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * .05),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: MaqeColor.lightGreyColor,
                            ),
                            left: BorderSide(
                              color: MaqeColor.lightGreyColor,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            TitleText(
                              inputText: '${holidayModel.totalDayUsed}',
                              color: MaqeColor.blueColor,
                              size: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            SubTitleText(
                              inputText: "Used",
                              color: MaqeColor.subTitleColor,
                              size: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ],
                        ),
                      ),
                      //left data
                      Column(
                        children: [
                          TitleText(
                            inputText: '${holidayModel.totalDayLeft}',
                            color: MaqeColor.orangeColor,
                            size: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          SubTitleText(
                            inputText: "Left",
                            color: MaqeColor.subTitleColor,
                            size: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(MaqeColor.blueColor),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                        ),
                      ),
                      icon: Icon(
                        Icons.add,
                        color: MaqeColor.whiteColor,
                      ),
                      label: RegularText(
                        inputText: "Leave",
                        size: 16,
                        color: MaqeColor.whiteColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .02,
                    ),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.shuffle, //font awesome pro random icon - nil
                        color: MaqeColor.blueColor,
                      ),
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(color: MaqeColor.blueColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          )),
                      label: RegularText(
                        inputText: "Switch",
                        color: MaqeColor.blueColor,
                        size: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  _cardData(BuildContext context, state, LeaveRequest leaveRequest) {
    var month = leaveRequest.requestList[0].date;
    final DateFormat formatter = DateFormat('dd MMM yyyy');
    final String frmtd = formatter.format(month);

    var lastDate = leaveRequest.requestList.last.date;
    final DateFormat lastDayformatter = DateFormat('dd');
    final String lastDay = lastDayformatter.format(lastDate);

    var firstDate = leaveRequest.requestList[0].date;
    final DateFormat firstDayformatter = DateFormat('dd MMM yyyy');
    final String firstDay = firstDayformatter.format(firstDate);

    //var newMap = groupBy(leaveRequest.requestList, (obj) => obj['type']);

    //Change the card color if the status is "cancled"
    var cardColor = Colors.white;
    if (leaveRequest.status == "canceled") {
      MaqeColor.titleColor = MaqeColor.subTitleColor;
      cardColor = MaqeColor.lightGreyColor;
    }

    return Card(
      color: cardColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (leaveRequest.requestList[0].type == "remote" ||
              leaveRequest.requestList[0].type == "personal_leave" ||
              leaveRequest.requestList[0].type == "sick_leave") ...[
            TitleText(
              inputText: "Leave",
              color: MaqeColor.titleColor,
              size: 22,
            ),
          ] else if (leaveRequest.requestList[0].type == "switch_holiday") ...[
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
                              return Icon(Icons.medical_services,
                                  color: MaqeColor.subTitleColor);
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
                              color: MaqeColor.subTitleColor,
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
          leaveRequest.requestList.length > 1
              ? RichText(
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
                )
              //

              : Text("data")
        ]),
      ),
    );
  }
} //end
