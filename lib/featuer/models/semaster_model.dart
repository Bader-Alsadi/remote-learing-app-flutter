class Semaster {
  String? name;
  String? stratDate;
  String? endDate;

  Semaster({this.name, this.stratDate, this.endDate});

  Semaster.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    stratDate = json['strat_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['strat_date'] = this.stratDate;
    data['end_date'] = this.endDate;
    return data;
  }
}