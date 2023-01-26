import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/pages/add_new_moment_page.dart';
import 'package:untitled/resources/colors.dart';
import 'package:untitled/utils/extensions.dart';
import 'package:untitled/view_items/moments_view.dart';

import '../blocs/moment_bloc.dart';
import '../common_widgets/bottom_navigator.dart';
import '../resources/dimens.dart';

class MomentsPage extends StatelessWidget {
  const MomentsPage({Key? key, int? index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MomentBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: PRIMARY_BACKGROUND_COLOR,
          centerTitle: false,
          elevation: 0.5,
          title: Text(
            "Moments",
            style: TextStyle(
              color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
              fontWeight: FontWeight.w600,
              fontSize: 34,
            ),
          ),
          actions: [
            Container(
              padding: EdgeInsets.all(MARGIN_MEDIUM),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () {
                  navigateToScreen(context, AddNewMomentPage());
                },
                style: ElevatedButton.styleFrom(
                    primary: SPLASH_SCREEN_BUTTONS_BORDER_COLOR),
                child: Icon(Icons.post_add),
              ),
            )
          ],
        ),
        body: Consumer<MomentBloc>(
          builder: (context, bloc, child) => Container(
            color: PRIMARY_BACKGROUND_COLOR,
            child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                    vertical: MARGIN_LARGE, horizontal: MARGIN_LARGE),
                itemBuilder: (context, index) {
                  return MomentView(
                    profileImage: bloc.moments[index].profilePicture ?? "",
                    userName: bloc.moments[index].userName ?? "",
                    description: bloc.moments[index].description ?? "",
                    postImages: bloc.moments[index].postImages ?? [],
                    onTapDelete: (momentId) {
                     bloc.onTapDeletePost(momentId);
                    },
                    onTapEdit: (momentId) {
                      Future.delayed(const Duration(milliseconds: 1000))
                          .then((value) {
                        _navigatreToEditPostPag(context, momentId);
                      });
                    }, momentId: bloc.moments[index].id ?? 0,
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: MARGIN_XLARGE,
                  );
                },
                itemCount: bloc.moments.length),
          ),
        ),
        bottomNavigationBar: BottomNavigator(
          currentIndex: 0,
        ),
      ),
    );
  }

  void _navigatreToEditPostPag(BuildContext context, int momentId) {
    print("moment id form navigate :: $momentId");
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddNewMomentPage(
          momentId: momentId,
        ),
      ),
    );
  }
}
