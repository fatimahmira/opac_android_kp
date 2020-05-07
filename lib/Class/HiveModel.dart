import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

class HiveModel {

  void addCache(var data, String key) async{
    var pathDoc = await pathProvider.getApplicationDocumentsDirectory();
    Hive.init(pathDoc.path);
    var box = await Hive.openBox('cacheBox');

    
    print(data.runtimeType);
    box.put(key, data);
  }

  Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }

  Future getCache(String key) async{
    var pathDoc = await pathProvider.getApplicationDocumentsDirectory();
    Hive.init(pathDoc.path);
    var box = await Hive.openBox('cacheBox');
    print('halo get '+key);
    print(box.containsKey(key));
    Map<String, dynamic> data = Map();
    if(box.containsKey(key)){
       var data2 = box.get(key);

       data['cacheValidDuration'] = parseDuration(data2['cacheValidDuration']);
       data['lastFetchTime'] = data2['lastFetchTime'];
       data['data'] = jsonDecode(data2['data']);

    }else{
      data = null;
    }

    print('end get');
    return data;
  }
}