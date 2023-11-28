// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Products on CommonStore, Store {
  late final _$dataListAtom =
      Atom(name: 'CommonStore.dataList', context: context);

  @override
  ObservableList<ProductModel> get dataList {
    _$dataListAtom.reportRead();
    return super.dataList;
  }

  @override
  set dataList(ObservableList<ProductModel> value) {
    _$dataListAtom.reportWrite(value, super.dataList, () {
      super.dataList = value;
    });
  }

  late final _$fetchDataAsyncAction =
      AsyncAction('CommonStore.fetchData', context: context);

  @override
  Future<void> fetchData() {
    return _$fetchDataAsyncAction.run(() => super.fetchData());
  }

  late final _$sortDateAsyncAction =
      AsyncAction('CommonStore.sortDate', context: context);

  @override
  Future<void> sortDate() {
    return _$sortDateAsyncAction.run(() => super.sortDate());
  }

  late final _$sortRatingAsyncAction =
      AsyncAction('CommonStore.sortRating', context: context);

  @override
  Future<void> sortRating() {
    return _$sortRatingAsyncAction.run(() => super.sortRating());
  }

  late final _$addDataAsyncAction =
      AsyncAction('CommonStore.addData', context: context);

  @override
  Future<void> addData(ProductModel data, BuildContext context) {
    return _$addDataAsyncAction.run(() => super.addData(data, context));
  }

  late final _$updateDataAsyncAction =
      AsyncAction('CommonStore.updateData', context: context);

  @override
  Future<void> updateData(int? index, ProductModel data) {
    return _$updateDataAsyncAction.run(() => super.updateData(index, data));
  }

  late final _$deleteAtAsyncAction =
      AsyncAction('CommonStore.deleteAt', context: context);

  @override
  Future<void> deleteAt(int index) {
    return _$deleteAtAsyncAction.run(() => super.deleteAt(index));
  }

  late final _$clearDataAsyncAction =
      AsyncAction('CommonStore.clearData', context: context);

  @override
  Future<void> clearData() {
    return _$clearDataAsyncAction.run(() => super.clearData());
  }

  @override
  String toString() {
    return '''
dataList: ${dataList}
    ''';
  }
}
