//import 'dart:async';
//
//import 'package:pageloader/objects.dart';
//
//
//class MasterDetailPage {
//  @inject
//  PageLoader loader;
//
//  @FirstByCss('[skawa-master]')
//  PageLoaderElement skawaMaster;
//
//  Future<SkawaDetailElement> get skawaDetail => loader.getInstance(SkawaDetailElement, loader.globalContext);
//}
//
//
//@FirstByCss('[skawa-detail]')
//class SkawaDetailElement {
//  @root
//  PageLoaderElement rootElement;
//
//  Future<bool> get displayed => rootElement.displayed;
//}