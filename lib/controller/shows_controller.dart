import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/model/seasondetail_model.dart';
import 'package:testapp/model/showdetailmodel.dart';
import '../constants.dart';
import '../model/allshowsmodel.dart';
import '../services/remote_services.dart';

class showsController extends GetxController {
  RxBool isloading = true.obs;
  RxBool isloadingdetailPage = true.obs;
  RxBool isloadingseasonDetail = true.obs;
  RxInt showstotallength = 0.obs;
  RxInt showsdisplaylength = 6.obs;
  RxInt showsrecordedlengthApi = 0.obs;
  AllShowsModel? allshows;
  ShowDetailModel? showdetail;
  SeasonDetailModel? seasondetail;
  RxBool isusersearchedShowsPage = true.obs;
  RxString assignString = "".obs;
  RxBool isrelatedActive = false.obs;
  RxBool iserrorseasonDetail = false.obs;

  RxInt showpagesliderpoint = 0.obs;

  final showPageController = TextEditingController().obs;

  // Fetch all Shows

  Future<AllShowsModel?> Fetchallshows() async {
    try {
      isloading(true);
      allshows = await RemoteServices.allshowsFetchdata();
      if (allshows!.videoStreamingApp.isNotEmpty) {
        showstotallength.value = allshows!.videoStreamingApp.length;
        showsrecordedlengthApi.value = allshows!.videoStreamingApp.length;
      } else {
        showstotallength.value = 0;
      }
      isloading(false);
      return allshows;
    } on SocketException {
      throw ErrorSnackBar("Network Error");
    } catch (e) {
      throw ErrorSnackBar("Sorry we are facing some issues at the moment");
    }
  }

  // Fetch Show Detail
  Future<ShowDetailModel?> Fetchshowdetail(String seriesId) async {
    try {
      isloadingdetailPage(true);
      showdetail = await RemoteServices.showdetailFetchdata(seriesId);
      if (allshows!.videoStreamingApp.isNotEmpty) {
        showstotallength.value = allshows!.videoStreamingApp.length;
        update();
      } else {
        showstotallength.value = 0;
      }
      isloadingdetailPage(false);
      return showdetail;
    } on SocketException {
      throw ErrorSnackBar("Network Error");
    } catch (e) {
      throw ErrorSnackBar("Sorry we are facing some issues at the moment");
    }
  }

  // Fetch Season Detail
  Future<SeasonDetailModel?> Fetchseasondetail(String seasonId) async {
    try {
      isloadingseasonDetail(true);
      seasondetail = await RemoteServices.seasondetailFetchdata(seasonId);
      episodeName = seasondetail!.videoStreamingApp.first.episodeTitle;
      episodevideoUrl = seasondetail!.videoStreamingApp.first.videoUrl;
      subtitleUrl = seasondetail!.videoStreamingApp.first.episodeSubtitle.first
          .toString();
      isloadingseasonDetail(false);
      update();
      return seasondetail;
    } on SocketException {
      throw ErrorSnackBar("Network Error");
    } catch (e) {
      throw ErrorSnackBar("Sorry we are facing some issues at the moment");
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await Fetchallshows();
  }
}
