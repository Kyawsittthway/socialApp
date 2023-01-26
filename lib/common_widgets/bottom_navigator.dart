import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/pages/contact_page.dart';
import 'package:untitled/pages/moments_page.dart';
import 'package:untitled/pages/profile_page.dart';
import 'package:untitled/resources/colors.dart';
import 'package:untitled/utils/extensions.dart';

import '../blocs/bottom_navigator_bloc.dart';
import '../pages/chat_page.dart';

class BottomNavigator extends StatelessWidget {
   BottomNavigator({ this.currentIndex,Key? key}) : super(key: key);
   int? currentIndex;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BottomNavigatorBloc(currentIndex),
      child: Consumer<BottomNavigatorBloc>(
        builder: (context, bloc, child) => BottomNavigationBar(
            currentIndex: bloc.getCurrentScreenIndex ?? 0,
            showUnselectedLabels: true,
            unselectedItemColor: Colors.grey,
            selectedItemColor: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
            unselectedLabelStyle: TextStyle(color:Colors.grey),
            // selectedLabelStyle: TextStyle(
            //   color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
            //   backgroundColor: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
            // ),
            elevation: 1.5,
            onTap: (value) {
              if(value != bloc.getCurrentScreenIndex) {
                bloc.updateIndex(value);
                switch (value) {
                  case 0 :
                    navigateToScreenWithRemove(context, MomentsPage(index: 0,));
                    break;
                  case 1:
                    navigateToScreenWithRemove(context, ChatPage(index: 1,));
                    break;
                  case 2:
                    navigateToScreenWithRemove(context, ContactPage(index: 2,));
                    break;
                  case 3:
                    navigateToScreenWithRemove(context, ProfilePage(index: 3,));
                    break;
                  case 4:
                    break;
                  default:
                    break;
                }
              }
            },
            items: [
              BottomNavigationBarItem(
                  label: 'Moments',
                  tooltip: "Hi",
                  // activeIcon: Icon(
                  //   Icons.ac_unit_outlined,
                  //   color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
                  // ),
                  icon:Icon(
                          Icons.ac_unit_outlined,

                        ),),
              BottomNavigationBarItem(
                label: 'Chats',
                // activeIcon:  Icon(
                //   Icons.chat_bubble,
                //   color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
                // ),
                icon: Icon(
                  Icons.chat_bubble,

                ),
              ),
              BottomNavigationBarItem(
                label: 'Contacts',
                // activeIcon:  Icon(
                //   Icons.perm_contact_calendar_rounded,
                //   color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
                // ),
                icon:  Icon(
                  Icons.perm_contact_calendar_rounded,

                ),
              ),
              BottomNavigationBarItem(
                label: 'Me',
                // activeIcon:  Icon(
                //   Icons.person,
                //   color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
                // ),
                icon:  Icon(
                  Icons.person,

                ),
              ),
              BottomNavigationBarItem(
                label: 'Setting',
                // activeIcon:  Icon(
                //   Icons.settings,
                //   color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
                // ),
                icon:  Icon(
                  Icons.settings,

                ),
              ),
            ]),
      ),
    );
  }
}
