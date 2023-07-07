import 'package:gwc_cet/repository/cet_team_data_repo/cet_team_data_repo_vm.dart';
import '../../api/api_response.dart';
import '../../repository/cet_team_data_repo/cet_team_data_repo.dart';
import 'package:flutter/cupertino.dart';

class CetTeamDataController extends ChangeNotifier{
  CetTeamDataRepo _cetTeamDataRepo = CetTeamDataRempVm();

  ApiResponse cetTeamDataResponse = ApiResponse.idle();

  void _setResponseMain(ApiResponse response) {
    print("Cet Get data Response :: $response");
    cetTeamDataResponse = response;
    Future.delayed(Duration.zero).then((value) {
      notifyListeners();
    });
  }

  getCetTeamListData() async{
    _setResponseMain(ApiResponse.loading());
    await _cetTeamDataRepo.getCetTeamData()
        .then((value) => _setResponseMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) => _setResponseMain(ApiResponse.error(error.toString())));
  }

  sendMarkAsCompleted(String userId){
    _setResponseMain(ApiResponse.loading());
    _cetTeamDataRepo.sendMarkAsCompleted(userId)
        .then((value) {
      // ApiResponse.completed(value);
      getCetTeamListData();
    })
        .onError((error, stackTrace) {
      ApiResponse.error(error.toString());
    });
  }



}