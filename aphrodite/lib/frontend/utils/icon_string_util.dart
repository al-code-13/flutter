import 'package:flutter/material.dart';

final _icons = <String, IconData>{
  'add_alert'     : Icons.add_alert,
  'accessibility' : Icons.accessibility,
  'folder_open'   : Icons.folder_open,
  'donut_large'   : Icons.donut_large,
  'input'         : Icons.input,
  'battery_std'   : Icons.battery_std,
  'list'          : Icons.list,
  'accepted'      : Icons.check_circle,
  'canceled'      : Icons.cancel,
  'shared'        : Icons.share,
};
Icon getIcon (String iconName){
  if(iconName == "accepted"){
    return Icon(_icons[iconName],color: Colors.green,size: 35,);
  }else if(iconName == "canceled"){
    return Icon(_icons[iconName],color: Colors.red,size: 35,);
  }
  return Icon(_icons[iconName],color: Colors.black,size: 35,);
}