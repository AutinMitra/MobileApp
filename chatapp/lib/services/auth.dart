import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> login({email, password, onSuccess}) async {
  try {
    var userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    onSuccess();
  } on FirebaseAuthException catch (e) {
    return getMessageFromErrorCode(e.code);
  } catch (e) {
    print(e);
    return "An error occurred.";
  }
  return "";
}

Future<String> register({email, password, firstName, lastName, onSuccess}) async {
  try {
    var result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    var user = result.user;

    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'firstName': firstName,
      'lastName': lastName,
    });

    onSuccess();
  } on FirebaseAuthException catch (e) {
    return getMessageFromErrorCode(e.code);
  } catch (e) {
    print(e);
    return "An error occurred.";
  }
  return "";
}

String getMessageFromErrorCode(String errorCode) {
  switch (errorCode) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
    case "account-exists-with-different-credential":
    case "email-already-in-use":
      return "Email already used.";
      break;
    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return "Invalid email/password.";
      break;
    case "ERROR_USER_NOT_FOUND":
    case "user-not-found":
      return "Invalid email/password.";
      break;
    case "ERROR_USER_DISABLED":
    case "user-disabled":
      return "User disabled.";
      break;
    case "ERROR_TOO_MANY_REQUESTS":
    case "operation-not-allowed":
      return "Too many requests to log into this account.";
      break;
    case "ERROR_OPERATION_NOT_ALLOWED":
    case "operation-not-allowed":
      return "Server error, please try again later.";
      break;
    case "ERROR_INVALID_EMAIL":
    case "invalid-email":
      return "Email address is invalid.";
      break;
    case "ERROR_USER_NOT_FOUND":
    case "user-not-found":
      return "No account found with this email";
      break;
    default:
      return "Login failed. Please try again.";
      break;
  }
}