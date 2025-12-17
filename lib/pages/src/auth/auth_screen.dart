import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_butailing/config/app_inject.dart';
import 'package:flutter_butailing/config/config.dart';
import 'package:flutter_butailing/config/oauth.dart';
import 'package:flutter_butailing/route/app_router.gr.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

@RoutePage()
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with AppInject {
  InAppWebViewController? webViewController;
  CookieManager cookieManager = CookieManager.instance();
  // JavaScript 拦截器代码
  String interceptorJS = """
(function() {
  // 拦截 fetch
  const originalFetch = window.fetch;
  window.fetch = function(...args) {
    const url = args[0];
    const options = args[1] || {};
    
    console.log('拦截 fetch:', url);
    
    // 发送消息到 Flutter
    window.flutter_inappwebview.callHandler('fetchIntercepted', {
      url: url,
      method: options.method || 'GET',
      headers: options.headers,
      body: options.body
    });
    
    return originalFetch.apply(this, args)
      .then(response => {
        window.flutter_inappwebview.callHandler('fetchResponse', {
          url: url,
          status: response.status,
          statusText: response.statusText
        });
        return response;
      });
  };
  
  // 拦截 XMLHttpRequest
  const originalOpen = XMLHttpRequest.prototype.open;
  const originalSend = XMLHttpRequest.prototype.send;
  
  XMLHttpRequest.prototype.open = function(method, url, async, user, password) {
    this._method = method;
    this._url = url;
    return originalOpen.apply(this, arguments);
  };
  
  XMLHttpRequest.prototype.send = function(data) {
    window.flutter_inappwebview.callHandler('xhrIntercepted', {
      url: this._url,
      method: this._method,
      data: data
    });
    
    this.addEventListener('load', function() {
      window.flutter_inappwebview.callHandler('xhrResponse', {
        url: this._url,
        status: this.status,
        response: this.response
      });
    });
    
    return originalSend.apply(this, arguments);
  };
})();
""";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await webViewController?.setSettings(settings: InAppWebViewSettings());
    });
  }

  Future<void> _parseAppIdAndIdetity(
    BuildContext? context,
    Map queryParameters,
  ) async {
    final appId = queryParameters["app_id"];
    final identity = queryParameters['identity'];
    if ((appId != null && (appId.trim().isNotEmpty)) &&
        (identity != null && (identity.trim().isNotEmpty))) {
      await Future.wait([Oauth.setAppId(appId), Oauth.setIdentity(identity)]);
    }
    if (await Oauth.oauthed) {
      if (context?.mounted ?? false) {
        context?.router.replace(HomeRoute());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          InAppWebView(
            shouldInterceptRequest: (controller, request) async {
              logger.d('拦截请求: ${request.url}');
              // 在这里处理网络层级的拦截
              final url = request.url;
              await _parseAppIdAndIdetity(context, url.queryParameters);
              return null;
            },
            onLoadResource: (controller, resource) async {
              logger.d('onLoadResource ${resource.url}');
              final queryParameters = resource.url?.queryParameters ?? {};
              await _parseAppIdAndIdetity(context, queryParameters);
            },
            onConsoleMessage: (controller, consoleMessage) {
              logger.d('WebView 控制台: ${consoleMessage.toString()}');
            },
            onLoadStart: (controller, url) async {
              logger.d("onLoadStart ${url.toString()}");
              if (url != null) {
                List<Cookie> cookies = await cookieManager.getCookies(url: url);
                for (var cookie in cookies) {
                  logger.d("onLoadStart cookie ${cookie.toJson()}");
                }
              }
              // 注入拦截器脚本
              try {
                await controller.evaluateJavascript(source: interceptorJS);
              } catch (e) {
                logger.d('注入拦截器脚本异常:$e');
              }
            },
            onWebViewCreated: (controller) {
              webViewController = controller;
              controller.addJavaScriptHandler(
                handlerName: "xhrIntercepted",
                callback: (args) async {
                  final arguments = args.first as Map? ?? {};
                  final query = arguments["url"] as String? ?? "";
                  if (query.isNotEmpty) {
                    final uri = Uri.parse('${getIt<Config>().webHost}$query');
                    final queryParameters = uri.queryParameters;
                    await _parseAppIdAndIdetity(context, queryParameters);
                  }
                  logger.d('xhrIntercepted args: $args');
                },
              );
              controller.addJavaScriptHandler(
                handlerName: 'xhrResponse',
                callback: (args) {
                  logger.d('xhrResponse args: $args');
                },
              );
              controller.addJavaScriptHandler(
                handlerName: 'fetchIntercepted',
                callback: (args) {
                  logger.d('fetchIntercepted args: $args');
                },
              );
              controller.addJavaScriptHandler(
                handlerName: 'fetchResponse',
                callback: (args) => logger.d('fetchResponse args: $args'),
              );
            },
            initialUrlRequest: URLRequest(url: WebUri(getIt<Config>().webHost)),
            initialSettings: InAppWebViewSettings(),
          ),
          Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
