import 'package:flutter/material.dart';
import 'package:flutter_butailing/api/rest_client.dart';
import 'package:flutter_butailing/config/config.dart';
import 'package:flutter_butailing/config/oauth.dart';
import 'package:flutter_butailing/model/index.dart';
import 'package:flutter_butailing/widgets/login_view.dart';

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
        final info = await (await RestClient.client).getInfo();
        if (info.code == 200) {
          setState(() {
            userInfo = info.data;
          });
        }
      }
    });
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
                  // context.router.push(LoginRoute());
                  final userInfo = await (await RestClient.client).getInfo();
                  logger.d("user info is : $userInfo");
                  Future<void> showCustomDialog(BuildContext context) async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(child: LoginView());
                      },
                    );
                  }

                  // ignore: use_build_context_synchronously
                  await showCustomDialog(context);
                },
              ),
            ],
          )
        : Row(
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
          );
  }
}
