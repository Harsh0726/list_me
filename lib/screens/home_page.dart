import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:list_me/components/colors.dart';
import 'package:list_me/data/menu_items.dart';
import 'package:list_me/model/button_model.dart';
import 'package:list_me/model/menu_item.dart';
import 'package:list_me/screens/Settings_page.dart';
import 'package:list_me/screens/Share_page.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../components/buttons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem<MenuItem>(
      value: item,
      child: Row(
        children: [
          Icon(
            item.icon,
            color: Colors.black,
            size: 20,
          ),
          const SizedBox(
            width: 12,
          ),
          Text(item.text),
        ],
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [tc4, tc3, tc2, tc1])),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          // voice enable
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // const Text("Voice enable"),
                ToggleSwitch(
                  
                  borderColor: [tc3],
                  minWidth: 70.0,
                  minHeight: 20,
                  cornerRadius: 20.0,
                  activeBgColors: [
                    [tc1],
                    [tc3]
                  ],
                  activeFgColor: ttc1,
                  inactiveBgColor: tc4,
                  inactiveFgColor: tc1,
                  initialLabelIndex: 1,
                  totalSwitches: 2,
                  labels: ['Voice', ' enable'],
                  radiusStyle: true,
                  onToggle: (index) {
                    print('switched to: $index');
                  },
                ),

                // menu button
                PopupMenuButton<MenuItem>(
                    icon: Icon(
                      Icons.menu_rounded,
                      color: tc1,
                      size: 36,
                    ),
                    onSelected: (item) => onSelected(context, item),
                    itemBuilder: (context) => [
                          ...MenuItems.itemsFirst.map(buildItem).toList(),
                          PopupMenuDivider(),
                          ...MenuItems.itemsSecond.map(buildItem).toList(),
                        ])
              ],
            ),
          ),
          // title
          Padding(
            padding: EdgeInsets.only(top: 60.0),
            child: Stack(
              children: <Widget>[
                // Stroked text as border.
                Text(
                  'List Me',
                  style: GoogleFonts.castoro(
                    fontSize: 40,
                    shadows: [
                      Shadow(
                          blurRadius: 10.0,
                          color: Colors.black,
                          offset: Offset(2, -2))
                    ],
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 5
                      ..color = tc5,
                  ),
                ),
                // Solid text as fill.
                Text(
                  'List Me',
                  style: GoogleFonts.castoro(
                    fontSize: 40,
                    color: tc6,
                  ),
                ),
              ],
            ),
          ),
          // grid
          Container(
            child: Expanded(child: Consumer<ButtonModel>(
              builder: (context, value, child) {
                return GridView.builder(
                    itemCount: value.buttonTypes.length,
                    padding: EdgeInsets.all(36.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return ButtonItemTile(
                        btnName: value.buttonTypes[index][0],
                        imgPath: value.buttonTypes[index][1],
                      );
                    });
              },
            )),
          ),
          // horizontal line
          const Padding(
            padding: EdgeInsets.all(25.0),
            child: Divider(
              thickness: 1,
              color: Color.fromRGBO(188, 253, 250, 1),
            ),
          ),
          // child: Color.fromRGBO(188, 253, 250, 1),

          // help button
          const Text("help"),
        ]),
      )),
    );
  }

  onSelected(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.itemSettings:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SettingsPage()),
        );
        break;
      case MenuItems.itemShare:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SharePage()),
        );
        break;
      default:
    }
  }
}
