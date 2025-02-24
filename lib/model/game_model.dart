class GameModel {
  int? betTime;
  int? status;
  int? period;
  String? timer;

  GameModel({this.betTime, this.status, this.period, this.timer});

  GameModel.fromJson(Map<String, dynamic> json) {
    betTime = json['betTime'];
    status = json['status'];
    period = json['period'];
    timer = json['timer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['betTime'] = this.betTime;
    data['status'] = this.status;
    data['period'] = this.period;
    data['timer'] = this.timer;
    return data;
  }
}
