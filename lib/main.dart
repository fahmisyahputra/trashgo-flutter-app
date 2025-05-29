import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';  // << penting
import 'package:provider/provider.dart';
import 'pages/home_page_wrapper.dart';
import 'pickup_request_provider.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

  runApp(
    ChangeNotifierProvider(
      create: (_) => PickupRequestProvider(),
      child: const TrashGoApp(),
    ),
  );
}

class TrashGoApp extends StatelessWidget {
  const TrashGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrashGo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ),
      locale: const Locale('id', 'ID'),
      supportedLocales: const [
        Locale('id', 'ID'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const HomePageWrapper(),
    );
  }
}
