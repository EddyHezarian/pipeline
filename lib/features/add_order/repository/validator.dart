bool validateOrderParameters(Map<String, dynamic> params) {
  bool response = true;
  params.forEach((key, value) {
    if (value == null) {
      response = false;
    }
  });
  if (params['phone'] != null) {
    String phone = params['phone'];
    if (phone[0] != '0') {
      response = false;
    }
    if (phone[1] != '9') {
      response = false;
    }
    if (phone.length != 11) {
      response = false;
    }
  }
  return response;
}
