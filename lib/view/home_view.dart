import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/bloc/weather_bloc_states.dart';
import 'package:weather_app/utils/weather_util.dart';
import 'package:weather_app/widgets/custom_widgets.dart';

import '../constant/constants.dart';
import '../utils/date_util.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

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

  Padding bodyBuildPadding(BuildContext context) {
    return Padding(
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
                if (state is WeatherSuccessState) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "City: ${state.weather.areaName.toString()}",
                          style: homeViewTextStyle(
                            Colors.white,
                            size: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          state.weather.date!.hour > 12 && state.weather.date!.hour < 18
                              ? Constants.goodAfternoonText
                              : (state.weather.date!.hour < 12 ? Constants.goodMorningText : Constants.goodEveningText),
                          style: homeViewTextStyle(
                            Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Image.asset(
                          'assets/${WeatherUtil.getAssetsInfo(state.weather)}',
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Text(
                            '${state.weather.temperature.toString().split('.')[0]}°C',
                            style: homeViewTextStyle(Colors.white, size: 55, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Text(
                            state.weather.weatherConditionCode.toString(),
                            style: homeViewTextStyle(Colors.white, size: 30, fontWeight: FontWeight.w400),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Text(
                            DateUtil.getDay(state.weather.date!.weekday),
                            style: homeViewTextStyle(Colors.white, size: 15, fontWeight: FontWeight.w200),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
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
                                      '${state.weather.sunrise!.hour}:${state.weather.sunrise!.minute.toString()} am',
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
                                      '${state.weather.sunset!.hour - 12}:${state.weather.sunset!.minute.toString()} pm',
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
                                      state.weather.tempMax!.celsius.toString().split('.')[0],
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
                                      state.weather.tempMin!.celsius.toString().split('.')[0],
                                      style: homeViewTextStyle(Colors.white, size: 14),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
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
}
