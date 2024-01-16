import 'package:flutter_sms/flutter_sms.dart';
import 'package:pipeline/core/model/order_model.dart';

void smsSender(OrderModel model) async {
  String message = '''  مشتری عزیز سفارش شما حاضر شده
  کد تحویل شما : ${model.id}
  جهت تحویل سفارش  به آدرسی که سفارش را ثبت کردید مراجعه کنید.''';

  String phone = '+98${model.customerPhone.substring(1)}';
  await sendSMS(message: message, recipients: [phone]);
}
