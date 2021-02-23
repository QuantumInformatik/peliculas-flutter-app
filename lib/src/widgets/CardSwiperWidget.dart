import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<dynamic> peliculas;

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
            child: Image.network("https://elluchador.info/web/wp-content/uploads/2019/12/lo-emjor-del-cine.jpg",fit: BoxFit.cover),
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
