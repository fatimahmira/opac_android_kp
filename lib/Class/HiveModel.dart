import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:opac_android_kp/Class/CacheModel.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

class HiveModel {

  void addCache(var cacheModel, String key) async{
    var pathDoc = await pathProvider.getApplicationDocumentsDirectory();
    Hive.init(pathDoc.path);
    var box = await Hive.openBox('cacheBox');

    print(cacheModelToJson(cacheModel));
    String data = jsonEncode(cacheModel);
    
    print(data.runtimeType);
    box.put(key, data);
  }

  Future getCache(String key) async{
    var pathDoc = await pathProvider.getApplicationDocumentsDirectory();
    Hive.init(pathDoc.path);
    var box = await Hive.openBox('cacheBox');
    print('halo get '+key);
    print(box.containsKey(key));
    CacheModel data = CacheModel();
    if(box.containsKey(key)){
       var data2 = box.get(key);
       var data3 = jsonDecode(data2);
       data.cacheValidDuration= data.parseDuration(data3['cacheValidDuration']);
       data.lastFetchTime = DateTime.parse(data3['lastFetchTime']);
       data.data = data3['data'];

       print(data3['data']);
    }else{
      data = null;
    }

    print('end get');
    return data;
  }
}