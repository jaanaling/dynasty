import 'package:dynasty_dive/src/feature/lesson/bloc/lesson_bloc.dart';
import 'package:dynasty_dive/src/feature/lesson/models/date.dart';
import 'package:dynasty_dive/src/feature/lesson/models/event.dart';
import 'package:dynasty_dive/src/feature/lesson/models/figure.dart';
import 'package:dynasty_dive/src/feature/lesson/models/place.dart';
import 'package:dynasty_dive/src/feature/notions/bloc/notion_bloc.dart';
import 'package:dynasty_dive/src/feature/notions/models/notion.dart';
import 'package:dynasty_dive/ui_kit/app_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class FactsScreen extends StatelessWidget {
  final String type;
  const FactsScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(17, 33, 17, 120),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                CupertinoButton(
                  child: Icon(CupertinoIcons.back),
                  onPressed: () => context.pop(),
                ),
                Gap(5),
                SizedBox(
                  height: 53,
                  child: VerticalDivider(
                    width: 1,
                    color: Color(0xFF6D6D6D),
                    thickness: 1,
                  ),
                ),
                Gap(15),
                Text(type,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      height: 0,
                    ))
              ],
            ),
            Gap(23),
            BlocBuilder<LessonBloc, LessonState>(
              builder: (context, state) {
                if (state is LessonLoadedState) {
                  final list = getList(type, state);

                  return ListView.separated(
                    itemCount: list.length,
                    separatorBuilder: (_, __) => Gap(8),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final el = list[index];
                      String title = "";
                      String description = "";
                      String? image;
                      LatLng? mapLocation;
                      if (el is HistoricalDate) {
                        title = el.date!;
                        description = el.description!;
                      }
                      if (el is HistoricalFigure) {
                        title = el.name;
                        description = el.description!;
                        image = el.image;
                      }
                      if (el is HistoricalPlace) {
                        title = el.name;
                        description = el.description;
                        if (el.mapLocation != null) {
                          mapLocation = LatLng(
                              double.parse(el.mapLocation!.split(",")[0]),
                              double.parse(el.mapLocation!.split(",")[1]));
                        }
                      }
                      if (el is HistoricalEvent) {
                        title = el.title;
                        description = el.description;
                      }
                      return AppTile(
                        title: title,
                        id: index,
                        onTap: () => showLessonDialog(
                            context, title, description, image, mapLocation),
                      );
                    },
                  );
                }
                ;
                return Center(
                  child: CupertinoActivityIndicator(
                    color: Color(0xFFDF3E3E),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  List getList(String title, LessonLoadedState state) {
    switch (type) {
      case "Dates":
        return state.date;
      case "Events":
        return state.event;
      case "Historical\nfigures":
        return state.figure;
      case "Places":
        return state.place;
      default:
        return [];
    }
  }
}

void showLessonDialog(BuildContext context, String title, String description,
    String? image, LatLng? mapLocation, [bool addNotion = true]) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Column(
          children: [
            Text(description),
            Gap(8),
            image == null ? Container() : Image.asset(image),
          mapLocation == null ? Container() :  SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.4,
              child: FlutterMap(
                options: MapOptions(
                 
                  initialZoom: 5,
                  initialCenter : mapLocation!,
                  minZoom: 5,
                    maxZoom: 18, // Используем точку как границы
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: mapLocation,
                        child: Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
         addNotion ? CupertinoDialogAction(
            child: Text(
              'Add to Notions',
              style: TextStyle(color: CupertinoColors.activeBlue),
            ),
            onPressed: () {
              context.read<NotionBloc>().add(
                    SaveNotion(
                      Notion(
                          id: DateTime.now().microsecond.toString(),
                          notion: title,
                          text: description),
                    ),
                  );
              Navigator.of(context).pop();
            },
          ) : Container(),
          CupertinoDialogAction(
            child:
                Text('OK', style: TextStyle(color: CupertinoColors.activeBlue)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
