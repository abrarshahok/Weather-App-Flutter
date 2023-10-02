import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/no_data_found.dart';
import '/model/weather.dart';
import '/provider/weather_api_client.dart';
import 'weather_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final cityController = TextEditingController();

  InputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
  );

  Widget loadingSpinner = const CircularProgressIndicator();

  Future<Weather> weatherProvider(String info) {
    return Provider.of<WeatherApiClient>(context, listen: false)
        .getWeather(info);
  }

  Weather? futureWeather;
  bool isLoading = false;
  void getWeather(String city) async {
    setState(() => isLoading = true);
    try {
      futureWeather = await weatherProvider(city);
    } catch (_) {
      setState(() => isLoading = false);
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Wheather App',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        elevation: 1,
        centerTitle: true,
        // backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Search by City',
                        labelStyle: Theme.of(context).textTheme.bodySmall,
                        enabledBorder: border,
                        focusedBorder: border,
                      ),
                      controller: cityController,
                      onSubmitted: (info) {
                        if (info.trim().isEmpty) {
                          return;
                        }
                        setState(() {
                          getWeather(info);
                        });
                      },
                      onTapOutside: (_) =>
                          FocusManager.instance.primaryFocus!.unfocus(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      minimumSize: const Size(80, 58),
                    ),
                    onPressed: () => getWeather(cityController.text),
                    child: const Icon(Icons.search),
                  ),
                ],
              ),
            ),
            if (isLoading)
              loadingSpinner
            else if (futureWeather != null)
              WeatherScreen(futureWeather: futureWeather)
            else
              NoDataFound(),
          ],
        ),
      ),
    );
  }
}
