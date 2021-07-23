import 'package:flutter/material.dart';
import 'package:rempahsis/RempahModel.dart';
import 'package:rempahsis/detail_rempah.dart';


class RempahListPage extends StatefulWidget{
  RempahListPage({Key? key}) : super(key: key);
  
  @override
  _RempahListPageState createState() => _RempahListPageState();
}



class _RempahListPageState extends State<RempahListPage>{
  
  final List<Rempah> _dataRempah = [
    Rempah(Nama: "Adas", NamaIlmiah: "Foeniculum vulgare"),
    Rempah(Nama: "Asam Jawa", NamaIlmiah: "Tamaricus indica"), 
    Rempah(Nama: "Asam Kandis", NamaIlmiah: "Garcinia xanthochymus"), 
    Rempah(Nama: "Cabe", NamaIlmiah: "Capsicum frutescens"), 
    Rempah(Nama: "Cengkih", NamaIlmiah: "Syzygium aromaticum") , 
    Rempah(Nama: "Jahe Gajah", NamaIlmiah: "Zingiber officinale Rosc."), 
    Rempah(Nama: "Jahe Merah", NamaIlmiah: "Zingiber officinale varietas rubrum") 
    ];
  List<Rempah> _dataFilter = [];
  @override
  void initState() {
    
    _dataFilter = _dataRempah;
    super.initState();
  }
  List<Rempah> hasil = [];
  
  void _filter(String kata) {
    if(kata.isEmpty){
      hasil =_dataRempah; 
    }
    else{
      hasil = _dataRempah.where((x) => x.nama.toLowerCase().contains(kata)).toList();
    }
    setState( (){
      _dataFilter = hasil;
    }); 
  }



  @override
  Widget build(BuildContext buildContext) => Scaffold(
    backgroundColor: Color(0xffE0E0E0),
    appBar:  AppBar(
      backgroundColor: Color(0xFFfdfdfd),
      elevation: 0,
      title: Container(
        height: 40,
        margin: EdgeInsets.all(50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffeaeaea),
        ),
        child: TextField(
        decoration: InputDecoration(
          fillColor: Colors.transparent,
          prefixIcon: Icon(Icons.search, size: 18,),
          hintText: "Search...",
          filled: true,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none),
        style: TextStyle(color: Colors.grey[800],),
        onChanged: (value) => _filter(value),
        textAlignVertical: TextAlignVertical.center,
      ),
      )


    ),
    body: Padding(padding: EdgeInsets.all(15),
    child: Column(children: [
      //SizedBox(height: 20,),
      Expanded(child: _dataFilter.length>0
      ?ListView.builder(
        itemCount: _dataFilter.length,
        itemBuilder: (context,index)
      => Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            spreadRadius: -2,
          )
        ]),
        child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
        margin: EdgeInsets.symmetric(vertical: 5),
        child: MaterialButton(
          onPressed:(){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => RempahDetailPage(id: '5')));
              },
            child: ListTile(
              title: Text(_dataFilter[index].nama,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
              subtitle: Text(_dataFilter[index].namaIlmiah,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300),),
              trailing: Icon(Icons.navigate_next, color: Colors.black,),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(image: AssetImage('./images/JaheMerahExample.jpg'), height: 45, width: 45, fit: BoxFit.fill,),
          )
        ),
       ) 
      ),
      )
      )
      :Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text("Rempah tidak ditemukan",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
          Text("☹",style: TextStyle(fontSize: 64),)]
        )
      )
      
      )
    ],
    ),
    )
  );
}

