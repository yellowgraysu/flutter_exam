import 'package:flutter/material.dart';
import 'package:flutter_exam/route.dart';
import 'package:flutter_exam/service/database.dart';
import 'package:vrouter/vrouter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dbService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return VRouter(
      routes: [MyRouteBuilder()],
    );
  }
}
