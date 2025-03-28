class GameHistoryModel {
  int? status;
  String? message;
  List<Data>? data;

  GameHistoryModel({this.status, this.message, this.data});

  GameHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic uid;
  dynamic gameId;
  dynamic amount;
  dynamic stopMultiplier;
  dynamic totalAmount;
  dynamic number;
  dynamic color;
  dynamic gamesno;
  dynamic winAmount;
  dynamic multiplier;
  dynamic commission;
  dynamic status;
  dynamic resultStatus;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic crashPoint;
  dynamic cashOutAmount;

  Data(
      {this.id,
        this.uid,
        this.gameId,
        this.amount,
        this.stopMultiplier,
        this.totalAmount,
        this.number,
        this.color,
        this.gamesno,
        this.winAmount,
        this.multiplier,
        this.commission,
        this.status,
        this.resultStatus,
        this.createdAt,
        this.updatedAt,
        this.crashPoint,
        this.cashOutAmount,
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    gameId = json['game_id'];
    amount = json['amount'];
    stopMultiplier = json['stop_multiplier'];
    totalAmount = json['totalamount'];
    number = json['number'];
    color = json['color'];
    gamesno = json['game_sr_num'];
    winAmount = json['win'];
    multiplier = json['multiplier'];
    commission = json['commission'];
    status = json['status'];
    resultStatus = json['result_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    crashPoint = json['crash_point'];
    cashOutAmount = json['cashout_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['uid'] = uid;
    data['game_id'] = gameId;
    data['amount'] = amount;
    data['stop_multiplier'] = stopMultiplier;
    data['total_amount'] = totalAmount;
    data['number'] = number;
    data['color'] = color;
    data['gamesno'] = gamesno;
    data['win_amount'] = winAmount;
    data['multiplier'] = multiplier;
    data['commission'] = commission;
    data['status'] = status;
    data['result_status'] = resultStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['crash_point'] = crashPoint;
    data['cashout_amount'] = cashOutAmount;
    return data;
  }
}
