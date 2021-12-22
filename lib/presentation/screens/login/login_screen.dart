import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mpower_flutter_test/config/constant_config.dart';
import 'package:mpower_flutter_test/data/local/login_model.dart';
import 'package:mpower_flutter_test/presentation/screens/dashboard/bloc/app_list_bloc.dart';
import 'package:mpower_flutter_test/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:mpower_flutter_test/presentation/screens/login/bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController? nameController;
  TextEditingController? passController;

  LoginScreen({Key? key}) : super(key: key) {
    nameController = TextEditingController(text: "mob_user");
    passController = TextEditingController(text: "giz@1234");
  }

  @override
  Widget build(BuildContext context) {
    var createPostBloc = BlocProvider.of<LoginBloc>(context);
    createPostBloc.stream.listen((state) {
      if (state is LoginSuccessState) {
        Fluttertoast.showToast(msg: state.message);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => AppListBloc(),
              child: DashboardScreen(),
            ),
          ),
        );
      } else if (state is LoginErrorState) {
        Fluttertoast.showToast(msg: state.message);
      }
    });
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: ConstantConfig.backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 100),
              child: const Text(
                'Hey there...',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: TextField(
                style: const TextStyle(
                  fontSize: 15,
                  letterSpacing: 1,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your username',
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
                cursorHeight: 25,
                cursorWidth: 2,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              margin: const EdgeInsets.only(bottom: 50),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: TextField(
                style: const TextStyle(
                  fontSize: 15,
                  letterSpacing: 1,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                controller: passController,
                keyboardType: TextInputType.multiline,
                maxLines: 1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
                cursorHeight: 25,
                cursorWidth: 2,
              ),
            ),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginLoadingState) {
                  createPostBloc.add(DoLogin(
                    model: LoginModel(
                      userName: nameController!.text,
                      password: passController!.text,
                    ),
                  ));
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: const SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.yellow,
                      ),
                    ),
                  );
                } else {
                  return InkWell(
                    onTap: () {
                      createPostBloc.add(LoginLoading(
                          nameController!.text, passController!.text));
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: const Text(
                        'SIGN IN',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                          letterSpacing: 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
