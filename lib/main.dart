import 'package:flutter/material.dart';
import 'package:wheather_app/api.dart';
import 'package:wheather_app/forcast.dart';
import 'package:wheather_app/theme.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  final String cityName = "Beirut";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: GlobalTheme.darkThemeData,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});
  String cityName = "beirut";
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wheather(
          cityName: widget.cityName,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Weather Today',
                style: GoogleFonts.roboto().copyWith(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: const Text('Beirut'),
              onTap: () {
                setState(() {
                  widget.cityName = "Beirut";
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('London'),
              onTap: () {
                setState(() {
                  widget.cityName = "London";
                });

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('New York'),
              onTap: () {
                setState(() {
                  widget.cityName = "New York";
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Paris'),
              onTap: () {
                setState(() {
                  widget.cityName = "Paris";
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Wheather extends StatefulWidget {
  const Wheather({super.key, required this.cityName});
  final String cityName;
  @override
  State<Wheather> createState() => _WheatherState();
}

class _WheatherState extends State<Wheather> {
  late Future<Forcast> forcast;

  @override
  void initState() {
    super.initState();
    forcast = Api.fetchForcast(widget.cityName);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Api.fetchForcast(widget.cityName),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.only(left: 13.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                    Text(
                      snapshot.data!.city,
                      style: GoogleFonts.roboto()
                          .copyWith(fontSize: 25, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Image.network(
                      snapshot.data!.iconLink,
                      height: 60,
                      width: 60,
                      alignment: Alignment.bottomCenter,
                    ),
                    Text(
                      " ${snapshot.data!.currentTemp}°",
                      style: GoogleFonts.roboto().copyWith(fontSize: 45),
                    ),
                  ],
                ),
                Text(
                  '  ${snapshot.data!.condition}',
                  style: GoogleFonts.roboto().copyWith(fontSize: 18),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.arrow_drop_up_sharp,
                      color: Colors.greenAccent,
                    ),
                    Text(
                      "${snapshot.data!.maxTemp}",
                      style: GoogleFonts.roboto().copyWith(fontSize: 15),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.arrow_drop_down_sharp,
                      color: Colors.redAccent,
                    ),
                    Text(
                      "${snapshot.data!.minTemp}",
                      style: GoogleFonts.roboto().copyWith(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
