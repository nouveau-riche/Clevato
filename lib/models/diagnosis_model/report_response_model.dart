class ReportResponseModel {
  int status;
  String message;
  List<Reports> reports;

  ReportResponseModel({this.status, this.message, this.reports});

  ReportResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['reports'] != null) {
      reports = new List<Reports>();
      json['reports'].forEach((v) {
        reports.add(new Reports.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.reports != null) {
      data['reports'] = this.reports.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reports {
  int id;
  int orderId;
  int userId;
  int labId;
  String report;
  String createdAt;
  String updatedAt;
  int orderDetailId;

  Reports(
      {this.id,
        this.orderId,
        this.userId,
        this.labId,
        this.report,
        this.createdAt,
        this.updatedAt,
        this.orderDetailId});

  Reports.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    userId = json['user_id'];
    labId = json['lab_id'];
    report = json['report'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderDetailId = json['order_detail_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['user_id'] = this.userId;
    data['lab_id'] = this.labId;
    data['report'] = this.report;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['order_detail_id'] = this.orderDetailId;
    return data;
  }
}
