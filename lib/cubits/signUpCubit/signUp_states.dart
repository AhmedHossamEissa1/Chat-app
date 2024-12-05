abstract class SignUpStates {}

class InitailSignUp extends SignUpStates {}

class LoadingSignUp extends SignUpStates {}

class SuccessSignUp extends SignUpStates {}

class FailSignUp extends SignUpStates {
 final String msg;
  FailSignUp({required this.msg});
}
