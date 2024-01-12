import 'package:flutter/material.dart';
import 'package:pipeline/core/database/supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<bool> signInWithPasswordAndEmail(
    {required String email,
    required String password,
    required BuildContext context}) async {
  bool result = true;
  try {
    await supabase.auth.signInWithPassword(password: password, email: email);
  } on AuthException catch (e) {
    debugPrint(e.toString());
    result = false;
  } catch (e) {
    result = false;
  }
  return result;
}
