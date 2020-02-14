
import 'package:flutter/material.dart';

final _icons = <String, IconData>{
  'add_alert'     : Icons.add_alert,
  'accessibility' : Icons.accessibility,
  'folder_open'   : Icons.folder_open,
  'donut_large'   : Icons.donut_large,
  'input'         : Icons.input,
  'battery_std'   : Icons.battery_std,
  'bug_report'   : Icons.bug_report
};
Icon getIcon (String iconName){
  return Icon(_icons[iconName],size: 48);
}