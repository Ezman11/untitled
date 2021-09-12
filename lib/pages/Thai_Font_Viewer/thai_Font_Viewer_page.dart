import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Thai_Font_Viewer extends StatefulWidget {
  const Thai_Font_Viewer({Key? key}) : super(key: key);

  @override
  _Thai_Font_ViewerState createState() => _Thai_Font_ViewerState();
}

class _Thai_Font_ViewerState extends State<Thai_Font_Viewer> {
  List<String> font_list = [
    'Prompt',
    'Mali',
    'Sriracha',
    'Charm',
    'Pattaya',
    'Kodchasan',
    'Charmonman',
    'Taviraj',
    'Sarabun',
    'Itim',
    'Athiti'
  ];
  String name_font = 'Prompt';

  Widget _midText() {
    return Container(
      child: Column(
        children: [
          Text(
            'การเดินทางขากลับคงจะเหงาน่าดู',
            style: GoogleFonts.getFont(name_font, fontSize: 50),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buttonFont(String font) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            name_font = font;
          });
        },
        style: ElevatedButton.styleFrom(primary: Color(0xFF009688)),
        child: Text(
          font,
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }

  Widget _font() {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        for (var item in font_list) _buttonFont(item.toString()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDCFBF4),
      appBar: AppBar(
        title: Text('THAI FONT VIEWER'),
        backgroundColor: Color(0xFF009688),
      ),
      body: Container(
        alignment: Alignment.center,
        //color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              heightFactor: 2,
              child: Column(
                //mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _midText(),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                children: [
                  Text('Font : ' + name_font, style: TextStyle(fontSize: 20)),
                  Card(
                    elevation: 5.0,
                    child: _font(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
