import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/bloc/weather_bloc_states.dart';
import 'package:weather_app/utils/random_city.dart';
import 'package:weather_app/utils/enum_view_status.dart';
import 'package:weather_app/utils/weather_util.dart';
import 'package:weather_app/widgets/custom_widgets.dart';

import '../constant/constants.dart';
import '../utils/date_util.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: bodyBuildPadding(context),
    );
  }

  Widget bodyBuildPadding(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 1.2 * kToolbarHeight, 40, 2),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(3, -0.3),
                child: buildContainer(Colors.deepPurple),
              ),
              Align(
                alignment: const AlignmentDirectional(-3, -0.3),
                child: buildContainer(Colors.deepPurple),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.2),
                child: buildContainer(
                  const Color(0xFFFFAB40),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              BlocBuilder<WeatherBloc, WeatherBlocStates>(
                builder: (context, state) {
                  return state.viewStatus == ViewStatus.success
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        (state.weather?.date?.hour ?? 0) > 12 && (state.weather?.date?.hour ?? 0) < 18
                                            ? Constants.goodAfternoonText
                                            : ((state.weather?.date?.hour ?? 0) < 12
                                                ? Constants.goodMorningText
                                                : Constants.goodEveningText),
                                        style: homeViewTextStyle(
                                          Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                      Text(
                                        "City: ${state.weather?.areaName.toString()}",
                                        style: homeViewTextStyle(
                                          Colors.white,
                                          size: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 80,
                                    width: 200,
                                    child: TextField(
                                      controller: controller,
                                      decoration: const InputDecoration(
                                        fillColor: Colors.black54,
                                        labelText: "Enter city name",
                                        labelStyle: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black54,
                                        ),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                      ),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              BlocSelector<WeatherBloc, WeatherBlocStates, Weather?>(
                                  selector: (state) => state.weather,
                                  builder: (context, weather) {
                                    return Column(
                                      children: [
                                        Image.asset(
                                          'assets/${WeatherUtil.getAssetsInfo(state.weather)}',
                                          scale: 2,
                                        ),
                                        Center(
                                          child: Text(
                                            '${state.weather?.temperature.toString().split('.')[0]}°C',
                                            style: homeViewTextStyle(Colors.white, size: 55, fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                              const SizedBox(
                                height: 4,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Center(
                                child: Text(
                                  state.weather?.weatherConditionCode.toString() ?? "",
                                  style: homeViewTextStyle(Colors.white, size: 30, fontWeight: FontWeight.w400),
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Center(
                                child: Text(
                                  DateUtil.getDay(state.weather?.date?.weekday ?? 0),
                                  style: homeViewTextStyle(Colors.white, size: 15, fontWeight: FontWeight.w200),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/day_time.png',
                                        scale: 8,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            Constants.sunRiseText,
                                            style: homeViewTextStyle(Colors.white, size: 20),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '${state.weather?.sunrise?.hour}:${state.weather?.sunrise?.minute.toString()} am',
                                            style: homeViewTextStyle(Colors.white, size: 16),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/day_time.png',
                                        scale: 8,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            Constants.sunSetText,
                                            style: homeViewTextStyle(Colors.white, size: 20),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '${state.weather?.sunset?.hour ?? 0 - 12}:${state.weather?.sunset?.minute.toString()} pm',
                                            style: homeViewTextStyle(Colors.white, size: 16),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Divider(
                                  height: 10,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/temp_max.png',
                                        scale: 8,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            Constants.tempMaxText,
                                            style: homeViewTextStyle(Colors.white, size: 18),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            state.weather?.tempMax?.celsius.toString().split('.')[0] ?? "",
                                            style: homeViewTextStyle(Colors.white, size: 14),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/temp_min.png',
                                        scale: 8,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            Constants.tempMinText,
                                            style: homeViewTextStyle(Colors.white, size: 18),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            state.weather?.tempMin?.celsius.toString().split('.')[0] ?? "",
                                            style: homeViewTextStyle(Colors.white, size: 14),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          RandomCity.randomCity.shuffle();
                                          context.read<WeatherBloc>().getByCityName(RandomCity.randomCity[0]);
                                        },
                                        child: const Text("Random City"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          context.read<WeatherBloc>().getByCityName(controller.text);
                                        },
                                        child: const Text("Entered City"),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      : state.viewStatus == ViewStatus.error
                          ? _dialog(context)
                          : const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildContainer(color) {
    return Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  Future<void> _showMyDialog(context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Weather Warning'),
            content: const Text('Typed city name is not exist'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/home'),
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  Widget _dialog(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context1) => AlertDialog(
            title: const Text('AlertDialog Title'),
            content: const Text('AlertDialog description'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pushNamed(context1, '/home'),
                child: const Text('OK'),
              ),
            ],
          ),
        ),
        child: const Text('Show Dialog'),
      ),
    );
  }
}
