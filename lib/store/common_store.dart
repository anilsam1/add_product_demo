import 'package:add_product_demo/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:mobx/mobx.dart';

part 'common_store.g.dart';

class Products = CommonStore with _$Products;

abstract class CommonStore with Store {
  @observable
  ObservableList<ProductModel> dataList = ObservableList<ProductModel>();

  Box<ProductModel> get box => Hive.box('abc');

  @action
  Future<void> fetchData() async {
    dataList = box.values.toList().cast<ProductModel>().asObservable();
    print("................fetch Data.............");
  }

  Future<void> sortProductName() async {
    List<ProductModel> item = box.values.toList();
    item.sort(
          (a, b) {
        return a.productName.compareTo(b.productName);
      },
    );
    await box.clear();
    await box.addAll(item);
    fetchData();
  }

  Future<void> sortLaunchSite() async {
    var item = box.values.toList();
    item.sort(
          (a, b) {
        return a.launchSite.compareTo(b.launchSite);
      },
    );
    await box.clear();
    await box.addAll(item);
    fetchData();
  }

  @action
  Future<void> sortDate() async {
    var item = box.values.toList();
    item.sort(
          (b, a) {
        return a.launchAt.compareTo(b.launchAt);
      },
    );
    await box.clear();
    await box.addAll(item);
    fetchData();
  }

  @action
  Future<void> sortRating() async {
    var item = box.values.toList();
    item.sort(
          (b, a) {
        return a.stars.compareTo(b.stars);
      },
    );
    await box.clear();
    await box.addAll(item);
    fetchData();
  }

  @action
  Future<void> addData(ProductModel data, BuildContext context) async {
    if (!dataList.any((item) => item.productName.toUpperCase() == data.productName.toUpperCase())) {
      box.add(data);
      fetchData();
    } else {
      _showAlert(context, 'Already added', 'This product has already added please add unique product');
    }
  }

  @action
  Future<void> updateData(int? index, ProductModel data) async {
    print(".................$index");
    box.putAt(index ?? 0, data);
    fetchData();
  }

  @action
  Future<void> deleteAt(int index) async {
    box.deleteAt(index);

    fetchData();
    print("delete completed");
  }


  @action
  Future<void> clearData() async {
    box.clear();
    fetchData();
  }


  void _showAlert(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    print('$title: $message');
  }
}