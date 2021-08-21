import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class AboutPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Color(0xffF5F5F5),
    appBar:  AppBar(
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
    body:  Container(
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
              children: [Flexible(child: Text("Aplikasi rempah SIS berfungsi sebagai scanner atau pemindai rempah yang dapat Anda gunakan mengetahui rempah-rempah di sekitar Anda melalui teknik pemindaian visual yang akurat."))],
              ),
            SizedBox(height: 12,),
            Row(
              children: [
              Icon(Icons.email_outlined, size: 16,),
              Text(" Kontak Kami", 
              style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w600),
            )
            ],
            ),
            SizedBox(height: 12,),
            Row(
              children: [Flexible(child: Text("adha.m.e@mail.ugm.ac.id "))],
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
            Image(image: AssetImage('./images/QRCode.png'), width: 150), 
          ],
        ),
        )
      );
}