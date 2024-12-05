abstract class SignInStates {}

class InitailSignIn extends SignInStates {}

class LoadingSignIn extends SignInStates {}

class SuccessSignIn extends SignInStates {}

class FailSignIn extends SignInStates {
 final String msg;
  FailSignIn({required this.msg});
}
