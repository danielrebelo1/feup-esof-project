import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';
import 'steps/loginTest_steps.dart';
import 'steps/signUpTest_steps.dart';
import 'steps/signOutTest_steps.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [Glob(r"test_driver/features/signOut.feature")]
    ..reporters = [ProgressReporter()]
    ..stepDefinitions = [LogInStep(),EnterEmail(),EnterPassword(),ClickLoginButton(), VerifyHomePage(),
    CheckSignUpPage(),WidgetCheckSignUp(),EnterText(),ClickSignUpButton(),CheckGivenWidgetsLG(),
    ProfilePageCheck(),CheckLogOutButton(),VerifyLoginPage()]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test_driver/app.dart";
  return GherkinRunner().execute(config);
}