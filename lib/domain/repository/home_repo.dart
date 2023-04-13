import 'package:mvvm_arch/data/model/movie_list_model.dart';
import 'package:mvvm_arch/data/network/base_api_services.dart';
import 'package:mvvm_arch/data/network/network_api_services.dart';
import 'package:mvvm_arch/utils/app_url.dart';

class HomeRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<MovieListModel> getMovies() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.moviesListEndPoint);
      return response = MovieListModel.fromJson(response);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
