import 'package:dynasty_dive/src/core/utils/icon_provider.dart';
import 'package:dynasty_dive/ui_kit/app_icon/widget/app_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SelectionWidget extends StatefulWidget {
  final double width;
  final String title;
  final String? iconPath;
  final List<String> fullList;
  final List<String> recommendedList;
  final Function(String) onSelect;
  final String initValue;

  const SelectionWidget({
    super.key,
    required this.width,
    required this.fullList,
    required this.recommendedList,
    required this.title,
    this.iconPath,
    required this.onSelect,
    required this.initValue,
  });

  @override
  _SelectionWidgetState createState() => _SelectionWidgetState();
}

class _SelectionWidgetState extends State<SelectionWidget> {
  bool showAll = false;
  late String selectedItem;
  int selectedIndex = 0;
  late String initValue;


  void toggleList() {
    setState(() {
      showAll = !showAll;
      selectedIndex = 0;
    });
  }

  void selectItem(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void confirmSelection() {
    setState(() {
      selectedItem = showAll
          ? widget.fullList[selectedIndex]
          : widget.recommendedList[selectedIndex];
      widget.onSelect(selectedItem);
    });
  }

  void reset() {
    setState(() {
      selectedItem = initValue;
      widget.onSelect(selectedItem);
    });
  }

  @override
  void initState() {
    super.initState();
    selectedItem = widget.initValue;
    initValue = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontFamily: 'Poppins',
                height: 0,
              ),
            ),
            if (widget.iconPath != null)
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: AppIcon(asset: widget.iconPath ?? ''),
              )
          ],
        ),
        const Gap(5),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (_) {
                return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    List<String> itemsToShow =
                        showAll ? widget.fullList : widget.recommendedList;
                    return Container(
                      height: 300,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Spacer(
                                flex: 2,
                              ),
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  toggleList();
                                  setState(() {});
                                },
                                child: Text(
                                  showAll
                                      ? 'Show only recommended'
                                      : 'Show all',
                                  style: TextStyle(
                                    color: CupertinoColors.activeBlue,
                                    fontSize: 20,
                                    fontFamily: 'Poppins',
                                    height: 0,
                                  ),
                                ),
                              ),
                              Spacer(),
                              CupertinoButton(
                                onPressed: () {
                                  reset();
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Reset',
                                  style: TextStyle(
                                    color: CupertinoColors.activeBlue,
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: CupertinoPicker(
                              backgroundColor: Colors.white,
                              itemExtent: 32.0,
                              onSelectedItemChanged: selectItem,
                              children: itemsToShow.map((item) {
                                return Center(
                                    child: Text(
                                  item,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontFamily: 'Poppins',
                                    height: 0,
                                  ),
                                ));
                              }).toList(),
                            ),
                          ),
                          CupertinoButton(
                            onPressed: () {
                              confirmSelection();
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Select',
                              style: TextStyle(
                                color: CupertinoColors.activeBlue,
                                fontSize: 24,
                                fontFamily: 'Poppins',
                                height: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ).then((_) {
              setState(() {});
            });
          },
          child: Container(
            width: widget.width,
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
                  spreadRadius: 0,
                ),
              ],
            ),
            child: SizedBox(
              height: 46,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: widget.width - 50,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            selectedItem,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontFamily: 'Poppins',
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
