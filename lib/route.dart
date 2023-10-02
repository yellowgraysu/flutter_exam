import 'package:flutter/material.dart';
import 'package:flutter_exam/model/user.dart';
import 'package:flutter_exam/screen/login.dart';
import 'package:flutter_exam/screen/student.dart';
import 'package:flutter_exam/screen/teacher.dart';
import 'package:flutter_exam/service/auth.dart';
import 'package:vrouter/vrouter.dart';

class MyRouteBuilder extends VRouteElementBuilder {
  @override
  List<VRouteElement> buildRoutes() {
    return [
      VNester(
        path: null,
        widgetBuilder: (child) => LoginGuard(child: child),
        nestedRoutes: [
          VWidget(path: LoginScreen.path, widget: const LoginScreen()),
          VWidget(path: StudentScreen.path, widget: const StudentScreen()),
          VWidget(path: TeacherScreen.path, widget: const TeacherScreen()),
        ],
      ),
      VRouteRedirector(path: '*', redirectTo: LoginScreen.path),
    ];
  }
}

class LoginGuard extends StatelessWidget {
  const LoginGuard({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final path = context.vRouter.path;

    return StreamBuilder<User?>(
      stream: authService.streamUserId,
      builder: (context, snapshot) {
        final user = snapshot.data;

        if (path == LoginScreen.path && user != null) {
          if (user is Teacher) {
            context.vRouter.to(TeacherScreen.path);
          } else if (user is Student) {
            context.vRouter.to(StudentScreen.path);
          }
        } else if (path != LoginScreen.path && user == null) {
          context.vRouter.to(LoginScreen.path);
        }

        return child;
      },
    );
  }
}
