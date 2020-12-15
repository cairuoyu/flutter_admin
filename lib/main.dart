import 'package:cry/common/application_context.dart';
import 'package:cry/constants/cry_constant.dart';
import 'package:cry/cry_root.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_admin/common/cry_dio_interceptors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'common/routes.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApplicationContext.instance.init();
  loadBean();

  runApp(MyApp());
}

loadBean() {
  ApplicationContext.instance.addBean(CryConstant.KEY_DIO_INTERCEPTORS, [CryDioInterceptors()]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CryRoot(
      Builder(
        builder: (context) {
          return MaterialApp(
            title: 'FLUTTER_ADMIN',
            builder: BotToastInit(),
            navigatorObservers: [BotToastNavigatorObserver()],
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            localizationsDelegates: [
              S.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: Locale(CryRootScope.of(context).state.configuration.locale),
            onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
          );
        },
      ),
    );
  }
}
