import 'package:flutter/material.dart';

import '../data/vo/user_vo.dart';
import 'contact_view_section.dart';

class ContactsAZListView extends StatelessWidget {
  ContactsAZListView({
    required this.isCreateGroupPage,
    required this.contactLists,
    Key? key,
  }) : super(key: key);
  final bool isCreateGroupPage;
  final List<UserVO> contactLists;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          ContactViewSection(isCreatePage: isCreateGroupPage, contactList: contactLists,),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.only(left: 400),
              child: ListView.builder(
                  itemCount: 26,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Text('A'),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}