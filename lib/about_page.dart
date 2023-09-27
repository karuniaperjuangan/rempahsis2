import 'package:flutter/material.dart';



class AboutPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Color(0xffF5F5F5),
    appBar:  AppBar(
      backgroundColor: Color(0xFFfdfdfd),
      elevation: 0,
      centerTitle: true,
      title: Image(image: AssetImage('images/LogoPKM.png'))
      ),
    body:  SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(25),
        child: 
            Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                Icon(Icons.info_outline, size: 16,),
                Text(" Tentang Kami", 
                style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w600),
              )
              ],
              ),

              SizedBox(height: 12,),
              Row(
                children: [Flexible(child: Text("Rempah SIS, \"Scanner of Indonesian Spices\", adalah aplikasi mengenai rempah yang dikembangkan tim PKM Rempah SIS dari UGM sebagai hasil keikutsertaan dari Program Kreativitas Mahasiswa (PKM) 2021 yang berfungsi sebagai scanner atau pemindai rempah yang dapat Anda gunakan mengetahui rempah-rempah di sekitar Anda melalui teknik pemindaian visual yang akurat. Selain itu, aplikasi ini juga menyediakan berbagai informasi tambahan mengenai rempah-rempah tersebut yang dapat memperkaya wawasan Anda. Kami harap aplikasi ini dapat bermanfaat bagi Anda serta mendukung usulan Jalur Rempah yang diajukan oleh Kemdikbudristek sebagai warisan budaya dunia kepada UNESCO."))],
                ),
              SizedBox(height: 12,),
              Row(
                children: [
                Icon(Icons.web, size: 16,),
                Text(" Situs Kami", 
                style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w600),
              )
              ],
              ),
              SizedBox(height: 12,),
              Row(
                children: [Flexible(child: Text("rempahsis.id "))],
                ),
              SizedBox(height: 12,),
              Row(
                children: [
                Icon(Icons.camera, size: 16,),
                Text(" Instagram Kami", 
                style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w600),
              )
              ],
              ),
              SizedBox(height: 12,),
              Row(
                children: [Flexible(child: Text("@rempah_sis "))],
                ),
              SizedBox(height: 12,),
              Row(
                children: [
                Icon(Icons.credit_card_outlined, size: 16,),
                Text(" Dukung Kami", 
                style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 12,),
              ],
              ),
              SizedBox(height: 12,),
              Row(
                children: [Flexible(child: Text("089618628853 (Gopay/OVO)"))],
                ),
            ],
          ),
          ),
    )
      );
}