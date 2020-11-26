import 'package:cry/cry_root.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'routes/routes.dart';
import 'generated/l10n.dart';

void main() => runApp(MyApp());

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
