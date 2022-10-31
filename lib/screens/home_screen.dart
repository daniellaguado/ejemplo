import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies-provider.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(
        context); //hay que espeficar cual tipo o provider tiene que buscar, en este caso en el arbol de widgets va a buscar MoviesProvider

    // print(moviesProvider.onDisplayMovies);

    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Peliculas en cine')),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.search_outlined))
          ],
        ),
        body: SingleChildScrollView(
            //Permite hacer scroll
            child: Column(
          children: [
            //Tarjetas principales
            CardSwiper(
              movies: moviesProvider.onDisplayMovies,
            ),
            //Slider de peliculas
            MovieSlider(
                movies: moviesProvider.popularMovies,
                onNextPage: () => moviesProvider.getPopularMovies(),
                title: 'Populares'),
            MovieSlider(
                movies: moviesProvider.popularMovies,
                onNextPage: () => moviesProvider.getPopularMovies(),
                title: 'Populares'),
          ],
        )));
  }
}
