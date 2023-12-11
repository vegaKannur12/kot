class CustomerModel {
  String? accId;
  String? accName;
  String? accPlace;
  String? accAdd1;
  String? accAdd2;
  String? accPhone;
  String? gstNo;

  CustomerModel(
      {this.accId,
      this.accName,
      this.accPlace,
      this.accAdd1,
      this.accAdd2,
      this.accPhone,
      this.gstNo});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    accId = json['Acc_Id'];
    accName = json['Acc_Name'];
    accPlace = json['Acc_Place'];
    accAdd1 = json['Acc_add1'];
    accAdd2 = json['Acc_Add2'];
    accPhone = json['Acc_Phone'];
    gstNo = json['Gst_No'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Acc_Id'] = this.accId;
    data['Acc_Name'] = this.accName;
    data['Acc_Place'] = this.accPlace;
    data['Acc_add1'] = this.accAdd1;
    data['Acc_Add2'] = this.accAdd2;
    data['Acc_Phone'] = this.accPhone;
    data['Gst_No'] = this.gstNo;
    return data;
  }
}
