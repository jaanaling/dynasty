import 'package:dynasty_dive/src/feature/home/presentation/screens/facts_screen.dart';
import 'package:dynasty_dive/src/feature/lesson/bloc/lesson_bloc.dart';
import 'package:dynasty_dive/src/feature/notions/bloc/notion_bloc.dart';
import 'package:dynasty_dive/src/feature/notions/models/notion.dart';
import 'package:dynasty_dive/ui_kit/app_tile.dart';
import 'package:dynasty_dive/ui_kit/cupertino_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:latlong2/latlong.dart';

class NotionsScreen extends StatefulWidget {
  const NotionsScreen({super.key});

  @override
  State<NotionsScreen> createState() => _NotionsScreenState();
}

class _NotionsScreenState extends State<NotionsScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 120),
      child: SafeArea(
        child: Column(
          children: [
            Row(children: [
              CupertinoButton(
                child: Icon(
                  CupertinoIcons.add,
                  color: Colors.white,
                  size: 36,
                ),
                onPressed: () => showEditLessonDialog(
                  context,
                  "",
                  "",
                  "",
                  false,
                ),
              ),
              Gap(5),
              SizedBox(
                height: 53,
                child: VerticalDivider(
                  width: 2,
                  color: Color(0xFF6D6D6D),
                  thickness: 2,
                ),
              ),
              Gap(15),
              SizedBox(
                height: 66,
                width: MediaQuery.of(context).size.width * 0.7,
                child: CupertinoTextField(
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  controller: searchController,
                  placeholder: 'Enter Text ...',
                  placeholderStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w300),
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.done,
                  decoration: BoxDecoration(
                    color: Color(0xFF222222),
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(
                        width: 0.30, color: const Color(0xFFC2C2C2)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x14000000),
                        blurRadius: 5,
                        offset: Offset(0, 1),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                  suffix: Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: IconButton(
                      icon: Icon(CupertinoIcons.search),
                      color: Color(0xFFACACAC),
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                    ),
                  ),
                ),
              )
            ]),
            Gap(23),
            BlocBuilder<LessonBloc, LessonState>(
              builder: (context, state1) {
                return BlocBuilder<NotionBloc, NotionState>(
                  builder: (context, state) {
                    if (state is NotionLoaded && state1 is LessonLoadedState) {
                      if (state.notions.isNotEmpty) {
                        final list = state.notions
                            .where((f) => f.notion!
                                .toLowerCase()
                                .contains(searchController.text.toLowerCase()))
                            .toList();
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 14),
                          itemCount: list.length,
                          separatorBuilder: (_, __) => Gap(13),
                          itemBuilder: (context, index) => AppTile(
                            title: list[index].notion ?? "",
                            id: index,
                            color: Color(0xFFDF3E3E),
                            trailing: Row(
                              children: [
                                CupertinoButton(
                                  child: Icon(
                                    CupertinoIcons.delete_simple,
                                    size: 30,
                                  ),
                                  onPressed: () => context
                                      .read<NotionBloc>()
                                      .add(RemoveNotion(list[index])),
                                ),
                                CupertinoButton(
                                  child: Icon(
                                    CupertinoIcons.pencil,
                                    size: 30,
                                  ),
                                  onPressed: () => showEditLessonDialog(
                                    context,
                                    list[index].notion,
                                    list[index].text,
                                    list[index].id,
                                    true,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              String? description = list[index].text;
                              String? image;
                              LatLng? mapLocation;
                              if (state1.place.indexWhere((element) =>
                                      element.name == list[index].notion) !=
                                  -1) {
                                mapLocation = LatLng(
                                    double.parse(state1.place
                                        .firstWhere(
                                          (test) =>
                                              test.name == list[index].notion,
                                        )
                                        .mapLocation!
                                        .split(",")[0]),
                                    double.parse(state1.place
                                        .firstWhere(
                                          (test) =>
                                              test.name == list[index].notion,
                                        )
                                        .mapLocation!
                                        .split(",")[1]));
                              }
                              if (state1.figure.indexWhere((element) =>
                                      element.name == list[index].notion) !=
                                  -1) {
                                image = state1.figure
                                    .firstWhere(
                                      (element) =>
                                          element.name == list[index].notion,
                                    )
                                    .image;
                              }

                              showLessonDialog(
                                  context,
                                  list[index].notion ?? "",
                                  description ?? '',
                                  image,
                                  mapLocation,
                                  false);
                            },
                            subtitle: Text(
                              list[index].text ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                height: 0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: Text(
                            "You don't have any saved notes!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                        );
                      }
                    } else {
                      return Center(
                        child: CupertinoActivityIndicator(
                          color: Color(0xFFDF3E3E),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void showEditLessonDialog(BuildContext context, String? title,
      String? description, String id, bool isEdit) {
    TextEditingController titleController = TextEditingController(text: title);
    TextEditingController descriptionController =
        TextEditingController(text: description);
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(isEdit ? "Edit Lesson" : "Create Lesson"),
          content: Column(
            children: [
              _buildInput(context, titleController, "title"),
              Gap(8),
              _buildInput(context, descriptionController, "description"),
            ],
          ),
          actions: [
            if (isEdit)
              CupertinoDialogAction(
                child: Text(
                  'Edit Notions',
                  style: TextStyle(color: CupertinoColors.activeBlue),
                ),
                onPressed: () {
                  context.read<NotionBloc>().add(
                        UpdateNotion(
                          Notion(
                              id: id,
                              notion: titleController.text,
                              text: descriptionController.text),
                        ),
                      );
                  Navigator.of(context).pop();
                },
              )
            else
              CupertinoDialogAction(
                child: Text(
                  'Add to Notions',
                  style: TextStyle(color: CupertinoColors.activeBlue),
                ),
                onPressed: () {
                  if (titleController.text.isEmpty ||
                      descriptionController.text.isEmpty) {
                    showCupertinoSnackBar(context, "Please fill all fields");
                    return;
                  }
                  context.read<NotionBloc>().add(
                        SaveNotion(
                          Notion(
                              id: DateTime.now().microsecond.toString(),
                              notion: titleController.text,
                              text: descriptionController.text),
                        ),
                      );
                  Navigator.of(context).pop();
                },
              ),
            CupertinoDialogAction(
              child: Text('Close',
                  style: TextStyle(color: CupertinoColors.systemRed)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildInput(
    BuildContext context,
    TextEditingController controller,
    String title,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
        const Gap(5),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          margin: EdgeInsets.only(right: 8),
          child: CupertinoTextField(
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
            controller: controller,
            textAlignVertical: TextAlignVertical.top,
            style: TextStyle(color: Colors.black),
            textInputAction: TextInputAction.newline,
            minLines: title == "title" ? 1 : 5,
            maxLines: title == "title" ? 1 : 5,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFE3E3E3), Color(0xFFD8D8D8)],
              ),
              borderRadius: BorderRadius.circular(9),
              border: Border.all(width: 0.30, color: const Color(0xFFC2C2C2)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 5,
                  offset: Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
