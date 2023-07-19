import 'package:flutter/material.dart';

import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Storage extends GetxController {
  final box = GetStorage();

  Future<void> initStorage() async {
    await GetStorage.init();
  }

  void storeToken(String token) {
    box.write('token', token);
  }

  getStoreToken() {
    return box.read('token');
  }

  void storeLangKey(Locale language) {
    box.write('language', language);
  }

  getLangKey() {
    return box.read('language');
  }

  void storeSelectedLangKey(String language) {
    box.write('SelectedLang', language);
  }

  getSelectedLangKey() {
    return box.read('SelectedLang');
  }

  void storeEmail(String email) {
    box.write('email', email);
  }

  getStoreEmail() {
    return box.read('email');
  }
  void storeName(String name) {
    box.write('name', name);
  }

  getStoreName() {
    return box.read('name');
  }
  void storePassword(String password) {
    box.write('password', password);
  }

  getStorePassword() {
    return box.read('password');
  }

  void storeRememberMe(bool rememberMe) {
    box.write('remember_me', rememberMe);
  }

  getStoreRememberMe() {
    box.read('remember_me');
  }

  void storeUserId(int userId) {
    box.write('userId', userId);
  }

  getStoreUserId() {
    return box.read('userId');
  }


  void storeUserCategoryId(String catId) {
    box.write('catId', catId);
  }

  getUserCategoryId() {
    return box.read('catId');
  }



  getValue(String key) {
    return box.read(key);
  }

  void storeMode(String storeMode) {
    box.write('storeMode', storeMode);
  }

  getStoreStoreMode() {
    return box.read('storeMode');
  }



  void storeCategory(String categoryId) {
    box.write('categoryId', categoryId);
  }

  getStoreStoreCategoryId() {
    return box.read('categoryId');
  }


  clearLocalDB() async {
    return box.erase();
  }

}
