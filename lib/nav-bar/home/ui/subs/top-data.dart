import 'package:flutter/material.dart';
import 'package:maqe/theme/colors.dart';
import 'package:maqe/theme/style.dart';

class TopData extends StatefulWidget {
  const TopData({Key? key}) : super(key: key);

  @override
  _TopDataState createState() => _TopDataState();
}

class _TopDataState extends State<TopData> {
  @override
  Widget build(BuildContext context) {
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
                      _totalData(),
                      //used data
                      _usedData(),
                      //left data
                      _leftData()
                    ],
                  ),
                ),

                //buttons
                _buttonSection(),
              ],
            ),
          ),
        )
      ],
    );
  }

  _totalData() {
    return Column(
      children: [
        TitleText(
          inputText: "15",
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
    );
  }

  _usedData() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * .05,
      ),
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .05),
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
            inputText: "8",
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
    );
  }

  _leftData() {
    return Column(
      children: [
        TitleText(
          inputText: "7",
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
    );
  }

  _buttonSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton.icon(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(MaqeColor.blueColor),
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
    );
  }
}
