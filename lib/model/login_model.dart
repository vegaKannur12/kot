class LoginModel {
  String? sm_id;
  String? sm_nm;
  String? us_nm;
  String? pwd;
 

  LoginModel(
      {this.sm_id,
      this.sm_nm,
      this.us_nm,
      this.pwd,
      });

  LoginModel.fromJson(Map<String, dynamic> json) {
    sm_id = json['Sm_id'];
    sm_nm = json['Sm_Name'];
    us_nm = json['Us_Name'];
    pwd = json['PWD'];
   
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Sm_id'] = sm_id;
    data['Sm_Name'] = sm_nm;
    data['Us_Name'] = us_nm;
    data['PWD'] = pwd;
    return data;
  }
}
