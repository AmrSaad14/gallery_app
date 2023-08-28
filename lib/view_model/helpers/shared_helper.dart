import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

//this abstract class is used to initial enum with T unknown type i will be known after the initialization
abstract class Enum<T> {
  final T _value;

  const Enum(this._value);

  T get value => _value;
}

// caching key class for shared preferences keys it extends enum with string type to initialize key with string
class CachingKey extends Enum<String> {
  const CachingKey(String val) : super(val);
  static const CachingKey download = CachingKey('download');
  static const CachingKey favorite = CachingKey('favorite');
}

class SharedHelper {

    static SharedPreferences ?shared;
  Future<bool> saveUid(String key,String value)async
  {
    return await shared!.setString(key, value);
  }
  static init()async
  {
    shared=await SharedPreferences.getInstance();
  }
    getUid(String key)
  {
  return shared!.getString(key) ;

  }

// this method will be used to save favorite photos to shared preferences in list of strings
  writeFavorites(CachingKey key, value) async {
    shared = await SharedPreferences.getInstance();
    List<String> values = shared?.getStringList(key.value) ?? [];
    if (!values.contains(value)) {
      values.add(value);
      print("Saving >>> $value local >>> with key ${key.value}");
      Fluttertoast.showToast(msg: 'Added to favorites');
    } else {
      print('already exists');
      values.remove(value);
      Fluttertoast.showToast(msg: 'Removed from favorites');
    }

    shared!.setStringList(key.value, values);
  }

  // this method will be used to get favorite photos from shared preferences in list of strings
  readFavorites(CachingKey key) async {
    shared = await SharedPreferences.getInstance();
    List<String> values = shared?.getStringList(key.value) ?? [];
    print("Reading >>> $values local >>> with key ${key.value}");
    return values;
  }
}
