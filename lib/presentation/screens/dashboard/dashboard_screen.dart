import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mpower_flutter_test/config/constant_config.dart';
import 'package:mpower_flutter_test/data/model/my_app.dart';
import 'package:mpower_flutter_test/presentation/screens/dashboard/bloc/app_list_bloc.dart';
import 'package:mpower_flutter_test/presentation/widgets/app_bar.widget.dart';
import 'package:mpower_flutter_test/presentation/widgets/empty_state.widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appListBloc = BlocProvider.of<AppListBloc>(context);
    appListBloc.stream.listen((state) {
      if (state is AppListErrorState) {
        Fluttertoast.showToast(msg: state.message);
      }
    });
    return Scaffold(
      appBar: MyAppbar(
        title: 'mPower App List',
        backButton: false,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            appListBloc.add(ReloadAllApps());
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              color: ConstantConfig.backgroundColor.withOpacity(0.4),
              height: MediaQuery.of(context).size.height,
              child: BlocBuilder<AppListBloc, AppListState>(
                builder: (context, state) {
                  if (state is AppListLoadingState) {
                    appListBloc.add(FetchAppList());
                    return const Center(
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is AppListSuccessState) {
                    if (state.myApps.isEmpty) {
                      return const EmptyStateWidget(
                        errMsg1: 'Oops! No Apps found!',
                        height: 300,
                        width: 300,
                      );
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.appTypeNameList.length,
                        itemBuilder: (context, index) {
                          List<MyApp> myAppList = state.appTypeNameList[index];
                          return Container(
                            height: 210,
                            color: Colors.white.withOpacity(0.5),
                            padding: const EdgeInsets.only(top: 10, left: 20),
                            margin: const EdgeInsets.only(top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  myAppList.isNotEmpty
                                      ? myAppList[0].applicationTypeName!
                                      : '',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1,
                                    color: ConstantConfig.backgroundColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 170,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: myAppList.length,
                                    itemBuilder: (context, index) {
                                      MyApp myApp = myAppList[index];
                                      return InkWell(
                                        onTap: () async {
                                          if (myApp.packageName!.isNotEmpty) {
                                            bool isInstalled =
                                                await DeviceApps.isAppInstalled(
                                                    myApp.packageName!);
                                            if (isInstalled) {
                                              DeviceApps.openApp(
                                                  myApp.packageName!);
                                            }
                                          } else {
                                            if (myApp.weblink!.isNotEmpty) {
                                              if (await canLaunch(
                                                  myApp.weblink!)) {
                                                await launch(myApp.weblink!);
                                              } else {
                                                throw 'Could not launch $myApp.weblink!';
                                              }
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      'No web link or package name found');
                                            }
                                          }
                                        },
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          margin: const EdgeInsets.only(
                                              top: 20, right: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 100,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(8),
                                                  ),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        'http://heal.dev.mpower-social.com${myApp.logoImg}',
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              Text(
                                                myApp.applicantName ?? "",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 0.4,
                                                  color: ConstantConfig
                                                      .backgroundColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  } else if (state is AppListErrorState) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
