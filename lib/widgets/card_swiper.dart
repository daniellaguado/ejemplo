import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({Key? key, required this.movies}) : super(key: key);

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context)
        .size; //Es para trabajar con las dimensiones de la aplicacion

    if (movies.length == 0) {
      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
          itemCount: movies.length,
          layout: SwiperLayout.STACK,
          itemWidth: size.width * 0.6,
          itemHeight: size.height * 0.45,
          itemBuilder: (_, int index) {
            final movie = movies[index];
            //Fernando creó una nueva variable llamda movie en la posicion index para despues usar esa misma variable
            // mas abajo en la parte de NetworkImage y despues que esta en la posicion index de <movie> le digo a la clase
            // que quiero es el index de fullPosterImg... pero podría utilizar simplemente (movies[index].fullPosterImg)

            // print(movie.posterPath); aqui consigo ver como es que esta viniendo ese index en base al builder
            // print(movie.fullPosterImg); este es el segundo paso despues de crear un metodo get
            return GestureDetector(
              //navegacion de swiper
              onTap: () =>
                  Navigator.pushNamed(context, 'details', arguments: movie),
              child: ClipRRect(
                //es para redondear el swiper
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage(
                      'assets/no-image.jpg'), //es la imagen que aparece cuando no carga
                  image: NetworkImage(movie.fullPosterImg), // imagen real
                  fit: BoxFit.cover, //para ajustar la imagen al container
                ),
              ),
            );
          }),
    );
  }
}
