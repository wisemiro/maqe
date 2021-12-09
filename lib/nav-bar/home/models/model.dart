import 'dart:convert';

HolidayModel holidayModelFromJson(String str) =>
    HolidayModel.fromJson(json.decode(str));

String holidayModelToJson(HolidayModel data) => json.encode(data.toJson());

class HolidayModel {
  HolidayModel({
    required this.totalDay,
    required this.totalDayLeft,
    required this.totalDayUsed,
    required this.leaveRequests,
  });

  final int totalDay;
  final int totalDayLeft;
  final int totalDayUsed;
  final List<LeaveRequest> leaveRequests;

  factory HolidayModel.fromJson(Map<String, dynamic> json) => HolidayModel(
        totalDay: json["total_day"],
        totalDayLeft: json["total_day_left"],
        totalDayUsed: json["total_day_used"],
        leaveRequests: List<LeaveRequest>.from(
            json["leave_requests"].map((x) => LeaveRequest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_day": totalDay,
        "total_day_left": totalDayLeft,
        "total_day_used": totalDayUsed,
        "leave_requests":
            List<dynamic>.from(leaveRequests.map((x) => x.toJson())),
      };
}

class LeaveRequest {
  LeaveRequest({
    required this.status,
    required this.requestList,
  });

  final String status;
  final List<RequestList> requestList;

  factory LeaveRequest.fromJson(Map<String, dynamic> json) => LeaveRequest(
        status: json["status"],
        requestList: List<RequestList>.from(
            json["request_list"].map((x) => RequestList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "request_list": List<dynamic>.from(requestList.map((x) => x.toJson())),
      };
}

class RequestList {
  RequestList({
    required this.date,
    required this.type,
  });

  final DateTime date;
  final String type;

  factory RequestList.fromJson(Map<String, dynamic> json) => RequestList(
        date: DateTime.parse(json["date"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "type": type,
      };
}

