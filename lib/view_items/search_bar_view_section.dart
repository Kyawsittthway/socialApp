import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';

class SearchBarViewSection extends StatelessWidget {
  const SearchBarViewSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM_2, vertical: MARGIN_MEDIUM),
      child: TextFormField(
        decoration: InputDecoration(
            fillColor: CONTACT_PAGE_SEARCH_BAR_COLOR,
            filled: true,
            hintText: "Search",
            border: InputBorder.none,
            hintStyle: TextStyle(
                fontFamily: GoogleFonts.notoSansMyanmar().fontFamily,
                fontSize: 18,
                fontWeight: FontWeight.w400),
            prefixIcon: Icon(
              Icons.search,
              color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.close,
                color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
              ),
              onPressed: () {},
            )),
      ),
    );
  }
}