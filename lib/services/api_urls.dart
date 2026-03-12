class ApiUrls {
  static const String baseUrl = "https://dummyjson.com";


  static const String login = "/auth/login";
  static  String posts({int limit = 10, skip = 0}) => "/posts?limit=$limit&skip=$skip";
  static  String products({int limit = 10, skip = 0}) => "/products?limit=$limit&skip=$skip";

}