import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpower_flutter_test/config/app_locator.dart' as di;
import 'package:mpower_flutter_test/presentation/screens/login/bloc/login_bloc.dart';
import 'package:mpower_flutter_test/presentation/screens/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // primaryColor: Color(0xffE7014C),
        backgroundColor: Colors.white,
      ),
      title: "mPower Test App",
      // onGenerateRoute: AppRouter.generateRoute,
      // initialRoute: RoutePath.allPosts,
      home: BlocProvider(
        create: (context) => LoginBloc(),
        child: LoginScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
