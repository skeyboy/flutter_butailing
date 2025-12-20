import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_butailing/api/rest_client.dart';
import 'package:flutter_butailing/config/oauth.dart';
import 'package:flutter_butailing/model/index.dart';
import 'package:flutter_butailing/route/app_router.gr.dart';

class UserInfoView extends StatefulWidget {
  const UserInfoView({super.key});

  @override
  State<UserInfoView> createState() => _UserInfoViewState();
}

class _UserInfoViewState extends State<UserInfoView> {
  bool isLogined = false;
  UserInfo? userInfo;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      isLogined = await Oauth.isLogined;
      setState(() {});
      if (isLogined) {
        await _refreshUserInfo();
      }
    });
  }

  Future<void> _refreshUserInfo() async {
    final info = await (await RestClient.client).getInfo();
    if (info.code == 200) {
      setState(() {
        userInfo = info.data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return !isLogined
        ? Row(
            children: [
              Text("登录"),
              Spacer(),
              InkWell(
                child: Icon(Icons.login),
                onTap: () async {
                  final result =
                      await context.router.push(LoginRoute()) as bool? ?? false;
                  if (result) {
                    isLogined = true;
                    await _refreshUserInfo();
                  }
                  // Future<void> showCustomDialog(BuildContext context) async {
                  //   final result =
                  //       (await showDialog(
                  //             context: context,
                  //             builder: (context) {
                  //               return Dialog(child: LoginView());
                  //             },
                  //           ))
                  //           as bool? ??
                  //       false;
                  //   if (result) {
                  //     isLogined = true;
                  //     await _refreshUserInfo();
                  //   }
                  // }
                  // // ignore: use_build_context_synchronously
                  // await showCustomDialog(context);
                },
              ),
            ],
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(Icons.person_2_rounded),
                  SizedBox(width: 8),
                  Text(userInfo?.user.nickname ?? ''),
                  Spacer(),
                  InkWell(
                    child: Icon(Icons.logout),
                    onTap: () {
                      Oauth.logout();
                      setState(() {
                        isLogined = false;
                      });
                    },
                  ),
                ],
              ),
              InkWell(
                onTap: () => context.router.push(CollectionRoute()),
                child: Row(
                  children: [
                    Text("个人收藏"),
                    Spacer(),
                    Icon(
                      Icons.favorite_border_outlined,
                      color: Colors.red[300],
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
