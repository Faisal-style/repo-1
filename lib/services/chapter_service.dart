import 'dart:convert';

// import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:repo/core/routes/api_routes.dart';
import 'package:repo/core/routes/routes.dart';
import 'package:repo/services/course_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/chapter/chapter_model.dart';

class ChapterService {
  static final client = InterceptedClient.build(
    interceptors: [AuthorizationInterceptor()],
    retryPolicy: ExpiredTokenRetryPolicy(),
  );
  Future<List<ChapterResponse>> getAllChapter(int idCourse) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var accesToken = sharedPreferences.getString('access-token');
    Uri url = Uri.parse(ApiRoutesRepo.chapter(idCourse));
    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accesToken',
      },
    );
    if (response.statusCode == 200) {
      // print(response.body);
      List data = json.decode(response.body)['data'];
      return data.map((e) => ChapterResponse.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load chapter');
    }
  }

  Future<List<ChapterAndArticleResponse>> getAllChapterAndTitle(
      int idCourse) async {
    List data = [];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var accesToken = sharedPreferences.getString('access-token');
    Uri url = Uri.parse(ApiRoutesRepo.fetchAllChapterAndTitleById(idCourse));
    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accesToken',
      },
    );
    if (response.statusCode == 200) {
      data = json.decode(response.body)['data'];
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        getAllChapterAndTitle(idCourse);
      });
      throw Exception('Failed to load chapter');
    }
    return data.map((e) => ChapterAndArticleResponse.fromJson(e)).toList();
  }

  Future getArticleByIdChapterAndIdArticle(
      int idCourse, int idChapter, int idArticle) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var accesToken = sharedPreferences.getString('access-token');
    Uri url = Uri.parse(ApiRoutesRepo.fetchArticleByIdChapterAndIdArticle(
        idCourse, idChapter, idArticle));
    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accesToken',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      Future.delayed(const Duration(seconds: 0), () {
        getArticleByIdChapterAndIdArticle(idCourse, idChapter, idArticle);
      });
      throw Exception('Failed to load article');
    }
  }

  Future getArticle(int idCourse, int idChapter) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var accesToken = sharedPreferences.getString('access-token');

    Uri url = Uri.parse(ApiRoutesRepo.getArticle(idCourse, idChapter));

    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accesToken',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      Future.delayed(const Duration(seconds: 0), () {
        getArticle(idCourse, idChapter);
      });
      throw Exception('Failed to load article');
    }
  }
}
