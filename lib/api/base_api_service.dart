
import 'package:http/http.dart';

abstract class BaseApiService {

  final String baseUrl = "https://gutandhealth.com/";

  Future<dynamic> getResponse(String url);

  Future<dynamic> postResponse(String url,Map<String, String> jsonBody);

  Future<dynamic> getResponseWithHeader(String url);

  Future<dynamic> postResponseWithHeader(String url,Map<String, String>? jsonBody);

  Future<dynamic> postAttachmentResponse(String url,Map<String, String> jsonBody, List<MultipartFile> attachments);

}