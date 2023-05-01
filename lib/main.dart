import 'package:flutter/material.dart';
import 'package:flutter_smarthome/services/adafruit_data_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './pages/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await dotenv.load();
  final String adafruitUsername = dotenv.env['ADAFRUIT_USERNAME']!;
  final String adafruitActiveKey = dotenv.env['ADAFRUIT_ACTIVE_KEY']!;
  var box = await Hive.openBox('my_smart_devices');
  // print(adafruitUsername);
  // final String feedName = 'fan';

  // https://io.adafruit.com/api/v2/Kietlun9302/feeds/fan
  // https://io.adafruit.com/api/v2/Kietlun9302/feeds/door
  // https://io.adafruit.com/api/v2/Kietlun9302/feeds/door

  // final url = Uri.parse(
  //     'https://io.adafruit.com/api/v2/$adafruitUsername/feeds/$feedName/data');

  // print(url);
  // final response = await http.post(
  //   url,
  //   headers: {
  //     'X-AIO-Key': adafruitActiveKey,
  //     'Content-Type': 'application/json',
  //   },
  //   body: jsonEncode({
  //     'value': 1, // Replace with the value you want to send to the feed
  //   }),
  // );

  // if (response.statusCode == 200) {
  //   print('Data sent successfully');
  // } else {
  //   print('Failed to send data: ${response.statusCode}');
  // }
  /*
  final url = Uri.parse(
      'https://io.adafruit.com/api/v2/$adafruitUsername/feeds/$feedName/data');

  final response = await http.get(
    url,
    headers: {
      'X-AIO-Key': adafruitActiveKey,
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print(data);
    // Do something with the data here
  } else {
    print('Failed to read feed data: ${response.statusCode}');
  }*/
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) =>
              AdafruitDataService(adafruitUsername, adafruitActiveKey))
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.grey,
            textTheme: GoogleFonts.openSansTextTheme()),
        debugShowCheckedModeBanner: false,
        home: HomePage());
  }
}
