class LoginModel {
  String? userId;
  String? staffName;
  String? branchId;
  String? branchName;
  String? branchPrefix;
  String? qtPre;
  String? mobileMenuType;
  String? usergroup;
  String? pass;

  LoginModel(
      {this.userId,
      this.staffName,
      this.branchId,
      this.branchName,
      this.branchPrefix,
      this.qtPre,
      this.mobileMenuType,
      this.usergroup,
      this.pass});

  LoginModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    staffName = json['staff_name'];
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    branchPrefix = json['branch_prefix'];
    qtPre = json['qtPre'];
    mobileMenuType = json['mobileMenuType'];
    usergroup = json['usergroup'];
    pass = json['pass'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = userId;
    data['staff_name'] = staffName;
    data['branch_id'] = branchId;
    data['branch_name'] = branchName;
    data['branch_prefix'] = branchPrefix;
    data['qtPre'] = qtPre;
    data['mobileMenuType'] = mobileMenuType;
    data['usergroup'] = usergroup;
    data['pass'] = pass;
    return data;
  }
}
