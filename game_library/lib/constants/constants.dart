import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class ConstantsStyles {
  static const Color appBarColor = Color.fromARGB(255, 0, 51, 153);

  static final TextStyle titleStyle = GoogleFonts.sansitaSwashed(
      fontSize: 30, fontWeight: FontWeight.w900, color: Colors.green.shade100);

  static final TextStyle newsTitle = GoogleFonts.bebasNeue(
      fontSize: 30, fontWeight: FontWeight.w900, color: Colors.blue);

  static final TextStyle textStyle = GoogleFonts.indieFlower(
      fontSize: 17, fontWeight: FontWeight.w900, color: Colors.blueGrey[800]);

  static final Color textFormColor = Colors.blue.shade900.withOpacity(0.2);
}
