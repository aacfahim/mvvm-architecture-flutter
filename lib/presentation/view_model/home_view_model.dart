import 'package:flutter/foundation.dart';
import 'package:mvvm_arch/data/model/movie_list_model.dart';
import 'package:mvvm_arch/data/response/api_response.dart';
import 'package:mvvm_arch/domain/repository/home_repo.dart';

class HomeViewModel with ChangeNotifier {
  final _homeRepo = HomeRepository();
  ApiResponse<MovieListModel> movieList = ApiResponse.loadiing();

  setMovieList(ApiResponse<MovieListModel> response) {
    movieList = response;
    notifyListeners();
  }

  Future<void> fetchMovieListApi() async {
    setMovieList(ApiResponse.loadiing());
    _homeRepo.getMovies().then((value) {
      setMovieList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setMovieList(ApiResponse.error(error.toString()));
    });
  }
}
