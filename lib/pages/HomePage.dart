import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            _swiperTarjetas()
          ],
        ),
      )
    );
  }

  Widget _swiperTarjetas(){
    return Container(
      width: double.infinity,
      height: 300.0,
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          return new Image.network("https://elluchador.info/web/wp-content/uploads/2019/12/lo-emjor-del-cine.jpg",fit: BoxFit.fill);
        },
        itemCount: 3,
        itemWidth: 300.0,
        itemHeight: 400.0,
        layout: SwiperLayout.TINDER,
      ),
    );
  }




}
