import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_butailing/api/rest_client.dart';
import 'package:flutter_butailing/config/config.dart';
import 'package:flutter_butailing/model/index.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String userName = "";
  String password = "";
  String code = "";
  bool _isObscure = false;
  Color _eyeColor = Colors.grey;
  Captcha? captcha;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _refresh();
    });
  }

  Future<void> _refresh() async {
    setState(() {
      _isLoading = true;
    });
    final captchaResult = await (await RestClient.client).getCaptcha();
    setState(() {
      _isLoading = false;
      captcha = captchaResult.data;
    });
    logger.d("login captcha : $captcha");
  }

  @override
  Widget build(BuildContext context) {
    Uint8List? img;
    String? imageBase64 = captcha?.img.split('data:image/jpeg;base64,').last;
    if (imageBase64?.isNotEmpty ?? false) {
      img = base64Decode(imageBase64!);
    }

    return IntrinsicHeight(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: userNameController,
                  decoration: const InputDecoration(labelText: '用户名/邮箱'),
                  // validator: (v) {
                  //   var emailReg = RegExp(
                  //     r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?",
                  //   );
                  //   if (!emailReg.hasMatch(v!)) {
                  //     return '请输入正确的邮箱地址';
                  //   }
                  // },
                  onSaved: (v) => userName = v!,
                ),

                TextFormField(
                  controller: passwordController,
                  obscureText: _isObscure,
                  onSaved: (v) => password = v!,
                  // validator: (v) {
                  //   if (v!.isEmpty) {
                  //     return '请输入密码';
                  //   }
                  // },
                  decoration: InputDecoration(
                    labelText: "密码",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.remove_red_eye, color: _eyeColor),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                          _eyeColor = (_isObscure
                              ? Colors.grey
                              : Theme.of(context).iconTheme.color)!;
                        });
                      },
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: codeController,
                        decoration: const InputDecoration(labelText: '图形验证码'),
                        validator: (v) {
                          if (v?.isEmpty ?? true) {
                            return "请输入正确的验证结果";
                          }
                          return null;
                        },
                        onSaved: (v) => code = v!,
                      ),
                    ),
                    if (img != null)
                      Flexible(
                        child: Image.memory(
                          img,
                          width: 194, // 设置宽度
                          height: 48, // 设置高度
                          fit: BoxFit.contain, // 填充方式
                          gaplessPlayback: true, // 防止重绘
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    final loginResult = await (await RestClient.client).login(
                      userName: userNameController.text,
                      password: passwordController.text,
                      code: codeController.text,
                      key: captcha?.key ?? '',
                    );
                    if (context.mounted) {
                      if (loginResult.code != 200) {
                        await _refresh();
                      } else {
                        await Fluttertoast.showToast(
                          msg: loginResult.message,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        final userInfo = await (await RestClient.client)
                            .getInfo();
                        logger.d("user info is : $userInfo");
                        if (context.mounted) {
                          Navigator.of(context).pop(true);
                        }
                      }
                    }
                  },
                  child: Text("登录"),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
