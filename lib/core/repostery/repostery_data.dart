abstract class ReposteryData {

  Future<Map<String, dynamic>> fetcheData (String source);
  Future<Map<String, dynamic>> stroeData (String source,Map<String,dynamic> data);
  Future<Map<String, dynamic>>  login (String source,Map<String,dynamic> data);

}