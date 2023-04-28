import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/utils/services/list_order.dart';
import 'package:notes/utils/services/notes_list.dart';

import '../../constants/colors.dart';
import '../services/date_format.dart';

Future<dynamic> settingsDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final int listOrderValue = ref.watch(listOrderStateNotifierProvider);
          final int dateFormatValue = ref.watch(dateStateNotifierProvider);
          return AlertDialog(
            title: const Center(child: Text("Settings")),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  const Divider(),
                  const Text(
                    'List Order:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  DropdownButton(
                    dropdownColor: Constants().chocolate,
                    value: listOrderValue,
                    items: const [
                      DropdownMenuItem(
                        value: 0,
                        child: Text('Date'),
                      ),
                      DropdownMenuItem(
                        value: 1,
                        child: Text('Title'),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text('Body'),
                      ),
                    ],
                    onChanged: (value) {
                      ref.read(listOrderStateNotifierProvider.notifier).saveOrder(value!);
                      switch (value) {
                        case 0:
                          {
                            ref.read(noteStateNotifierProvider.notifier).reorderNotesByDate();
                          }
                          break;
                        case 1:
                          {
                            ref.read(noteStateNotifierProvider.notifier).reorderNotesByTitle();
                          }
                          break;
                        case 2:
                          {
                            ref.read(noteStateNotifierProvider.notifier).reorderNotesByBody();
                          }
                          break;
                      }
                    },
                  ),
                  const Divider(),
                  const Text(
                    'Date Format:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  DropdownButton(
                    dropdownColor: Constants().chocolate,
                    value: dateFormatValue,
                    items: const [
                      DropdownMenuItem(
                        value: 0,
                        child: Text('Month-Day-Year'),
                      ),
                      DropdownMenuItem(
                        value: 1,
                        child: Text('Day-Month-Year'),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text('Year-Month-Day'),
                      ),
                    ],
                    onChanged: (value) {
                      ref.read(dateStateNotifierProvider.notifier).saveFormat(value!);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
