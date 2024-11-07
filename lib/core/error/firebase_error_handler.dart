

String getFirebaseAuthErrorMessage(String errorCode) {
  switch (errorCode) {
    case 'weak-password':
      return "The password is too weak. Please choose a stronger password.";
    case 'invalid-credential':
      return "Incorrect password provided.";
    case 'email-already-in-use':
      return "The email is already in use by another account.";
    case 'invalid-email':
      return "The email address is not valid.";
    case 'user-not-found':
      return "No user found with this email.";
    case 'wrong-password':
      return "Incorrect password provided.";
  // Add any other specific Firebase error codes you need
    default:
      return errorCode;
  }
}