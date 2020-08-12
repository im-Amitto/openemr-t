import 'package:json_store/json_store.dart';

class Store {
  JsonStore store = JsonStore();
  Store() {
    this.store = store;
  }

  void _setStoreState(String key, String value) async {
    await this.store.setItem(key, {'value': value});
    return;
  }

  dynamic _getStateStore(String key) async {
    Map<String, dynamic> jsonStore = await this.store.getItem(key);
    return jsonStore['value'];
  }
}
