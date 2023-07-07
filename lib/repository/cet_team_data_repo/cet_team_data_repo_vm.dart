
import '../../api/api_urls.dart';
import '../../api/base_api_service.dart';
import '../../controller/api_service.dart';
import '../../model/cet_data_model/get_cet_data_model.dart';
import '../../model/normal_message_model/normal_model.dart';
import 'cet_team_data_repo.dart';

class CetTeamDataRempVm extends CetTeamDataRepo{

  BaseApiService _apiService = ApiService();

  @override
  Future getCetTeamData() async{
    try{
      dynamic response = await _apiService.getResponseWithHeader(
          getCetTeamDataUrl);
      print("$response");
      final jsonData = GetCetDataModel.fromJson(response);
      return jsonData;
    }
    catch(e){
      print("Error : $e}");
      throw e;
    }
  }

  @override
  Future sendMarkAsCompleted(String userId) async{
    Map<String, String> m = {
      "user_id": userId
    };
    try {
      dynamic response = await _apiService.postResponseWithHeader(
          markAsCompleteUrl, Map.from(m));
      print("$response");
      final jsonData = NormalModel.fromJson(response);
      return jsonData;
    } catch (e) {
      print("Error : $e}");
      throw e;
    }
  }

}
