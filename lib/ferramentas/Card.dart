import 'package:flutter/material.dart';

class CardHome extends StatelessWidget {
  const CardHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 190,
      width: double.infinity,
     // color: Colors.red,
      child:  ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Card(
            elevation: 4,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, 'descricao');
                  } ,
                  child: Container(
                    height: 125,
                    width: 140,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/images/fundologin.jpg"), fit: BoxFit.cover),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                     // color: Colors.yellowAccent,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: Text("SOYO", style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.only( left: 8.0),
                  child: Text("Conheça O Soyo",
                    style:
                    TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          //========= Cards a serem Removidos ============0
          Card(
            elevation: 4,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 125,
                  width: 140,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/fundologin.jpg"), fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                   // color: Colors.yellowAccent,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: Text("SOYO", style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.only( left: 8.0),
                  child: Text("Conheça O Soyo",
                    style:
                    TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),

          Card(
            elevation: 4,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 125,
                  width: 140,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/fundologin.jpg"), fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                  //  color: Colors.yellowAccent,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: Text("SOYO", style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.only( left: 8.0),
                  child: Text("Conheça O Soyo",
                    style:
                    TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),

          Card(
            elevation: 4,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 125,
                  width: 140,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/fundologin.jpg"), fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                //    color: Colors.yellowAccent,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: Text("SOYO", style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.only( left: 8.0),
                  child: Text("Conheça O Soyo",
                    style:
                    TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),

          Card(
            elevation: 4,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 125,
                  width: 140,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/fundologin.jpg"), fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                  //  color: Colors.yellowAccent,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: Text("SOYO", style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.only( left: 8.0),
                  child: Text("Conheça O Soyo",
                    style:
                    TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),

          Card(
            elevation: 4,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 125,
                  width: 140,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/fundologin.jpg"), fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                  //  color: Colors.yellowAccent,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: Text("SOYO", style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.only( left: 8.0),
                  child: Text("Conheça O Soyo",
                    style:
                    TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),

          // =========Fim Card a serem Removidos ============
        ],
      ),
    );
  }
}
