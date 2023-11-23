/// This class used to send status of filter in [TeamJp] and [TeamAttendance]
class StatusTeamJPModel {
  int statusId;
  String statusValue;
  StatusTeamJPModel({
    required this.statusId,
    required this.statusValue,
  });

  static List<StatusTeamJPModel> statusList = [
    StatusTeamJPModel(statusId: 1, statusValue: 'Not Started'),
    StatusTeamJPModel(statusId: 2, statusValue: 'In Progress'),
    StatusTeamJPModel(statusId: 3, statusValue: 'Finished'),
    StatusTeamJPModel(statusId: 4, statusValue: 'All'),
  ];
}

class StatusTeamAttendanceModel {
  int statusId;
  String statusValue;
  StatusTeamAttendanceModel({
    required this.statusId,
    required this.statusValue,
  });

  static List<StatusTeamAttendanceModel> statusList = [
    StatusTeamAttendanceModel(statusId: 0, statusValue: 'All'),
    StatusTeamAttendanceModel(statusId: 1, statusValue: 'Present'),
    StatusTeamAttendanceModel(statusId: 2, statusValue: 'Absent'),
  ];
}
