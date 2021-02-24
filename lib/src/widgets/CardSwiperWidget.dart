import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/Pelicula.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screeSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(peliculas[index].getPosterImg()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              fit: BoxFit.cover,
            ),
          );

        },
        itemCount: peliculas.length,
        itemWidth: _screeSize.width*0.7,
        itemHeight: _screeSize.height*0.5,
        layout: SwiperLayout.STACK,
      ),
    );
  }



}
