import 'package:flutter/material.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}
List comidaImg = [
  'https://chefmenu.co//restaurantes/bogota/FogondeLena/logo.png',
  'https://images.deliveryhero.io/image/pedidosya/products/841918-bcb04bf3-cf79-40ef-9b97-6cc7fee29215.jpg?quality=80',
  'https://images.deliveryhero.io/image/pedidosya/products/925070-a7515b47-7fc0-4248-8255-68fc05f8383a.jpg?quality=80',
  'https://images.deliveryhero.io/image/pedidosya/products/913429-f13eda90-fbe4-49a2-b082-133dbf1728cb.jpg?quality=80'
];
class _FavoritosPageState extends State<FavoritosPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
                    //decoration: BoxDecoration(color: Colors.black12),
                    margin: EdgeInsets.only(top: 16.0),
                    height: 124.0,
                    child: ListView.builder(
                      itemCount: comidaImg.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    padding: EdgeInsets.all(0),
                                    child: Card(
                                      elevation: 0,
                                      child: Image.network(
                                        comidaImg[0],
                                        width: 112,
                                        height: 112,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Fogón de leña',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                                Text(
                                  'Comida Colombiana',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black38, fontSize: 16),
                                ),
                                Text(
                                  '30.500  -  4.9 ⭐',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black38, fontSize: 16),
                                ),
                                Text(
                                  'ABIERTO',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Divider(color: Colors.red,),
                              ],
                            ),
                            //if(index!=comidaImg.length-1){
                            
                            //}
                          ],
                        );
                      },
                    ),
                  );
  }
}