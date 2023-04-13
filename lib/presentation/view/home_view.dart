import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mvvm_arch/data/response/status.dart';
import 'package:mvvm_arch/presentation/view_model/home_view_model.dart';
import 'package:mvvm_arch/presentation/view_model/user_view_model.dart';
import 'package:mvvm_arch/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewModel homeViewModel = HomeViewModel();
  @override
  void initState() {
    homeViewModel.fetchMovieListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 18),
              child: InkWell(
                onTap: () {
                  userPreference.remove().then((value) {
                    Navigator.pushReplacementNamed(context, RoutesName.login);
                  });
                },
                child: const Text("Logout"),
              ),
            )
          ],
        ),
        body: ChangeNotifierProvider<HomeViewModel>(
          create: (context) => homeViewModel,
          child: Consumer<HomeViewModel>(
            builder: (context, value, child) {
              switch (value.movieList.status) {
                case Status.LOADING:
                  return CircularProgressIndicator();
                case Status.ERROR:
                  return Text(value.movieList.message.toString());
                case Status.COMPLETED:
                  return const Text("Data Recieved");
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                      child: Text(value.movieList.data!.movies![index].title
                          .toString()));
                },
                itemCount: value.movieList.data!.movies!.length,
              );
            },
          ),
        ));
  }
}
