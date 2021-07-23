import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RempahDetailPage extends StatefulWidget{
  RempahDetailPage({Key? key,required String id}) : super(key: key);
  @override
  State<StatefulWidget> createState(){
    return _RempahDetailPage();  
}
}
class _RempahDetailPage extends State<RempahDetailPage>{
  bool _expanded =false;
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Color(0xffF5F5F5),
    appBar: AppBar(
      backgroundColor: Color(0xFFfdfdfd),
      elevation: 0,
      centerTitle: true,
      title: Text("REMPAHSIS",
      style: GoogleFonts.oswald(
        textStyle: TextStyle(
          color: Color(0xffCE8D51),
          fontWeight: FontWeight.w500),
          fontSize: 25,
          letterSpacing: 6
          )),
      ),
    body: SingleChildScrollView(child:
    Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20),
        Text("Jahe Merah",
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 28)
        ),

        Text("Zingiber Officinale var. Rubrum",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        ),
        SizedBox(height: 15),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image(image: AssetImage('./images/JaheMerahExample.jpg'), width: 300,
        )
        ),
        Container(
          margin: EdgeInsets.fromLTRB(50, 20, 50, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(children: [Flexible(child: Text("Jahe merah adalah jahe yang memiliki kandungan minyak atsiri tinggi dan rasa paling pedas, sehingga cocok untuk bahan dasar farmasi dan jamu. Ukuran rimpangnya paling kecil dengan kulit warna merah, serat lebih besar dibanding jahe biasa.", textAlign: TextAlign.justify,)),          
              ],
              ),
              SizedBox(height: 10,),
              ExpandablePanel(
                header: Text("Morfologi"),
                collapsed: Text(""),
                expanded: Text("Isi\nIsi\nIsi\nIsi")),
              SizedBox(height: 10,),
              ExpandablePanel(
                header: Text("Ciri-ciri"),
                collapsed: Text(""),
                expanded: Text("Isi\nIsi\nIsi\nIsi")),
              SizedBox(height: 10,),
              ExpandablePanel(
                header: Text("Khasiat"),
                collapsed: Text(""),
                expanded: Text("Isi\nIsi\nIsi\nIsi")), 
              SizedBox(height: 10,),
              ExpandablePanel(
                header: Text("Kegunaan"),
                collapsed: Text(""),
                expanded: Text("Isi\nIsi\nIsi\nIsi")),
              SizedBox(height: 10,),
              ExpandablePanel(
                header: Text("Potensi"),
                collapsed: Text(""),
                expanded: Text("Isi\nIsi\nIsi\nIsi")),
            ],
          ),
        )
      ]
      )
    ),)
  );
}