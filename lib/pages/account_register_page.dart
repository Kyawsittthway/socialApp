import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:untitled/blocs/register_bloc.dart';
import 'package:untitled/common_widgets/full_color_button.dart';
import 'package:provider/provider.dart';
import 'package:untitled/pages/login_page.dart';
import 'package:untitled/utils/extensions.dart';
import '../common_widgets/loading_view.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';

class AccountRegisterPage extends StatelessWidget {
  AccountRegisterPage({Key? key}) : super(key: key);
  List<String> day = ["01", "02", "03", "04"];
  Map<String, String> months = {
    "Jan": "01",
    "Feb": "02",
    "Mar": "03",
    "Apr": "04",
    "May": "05",
    "Jun": "06",
    "Jul": "07",
    "Aug": "08",
    "Sep": "09",
    "Oct": "10",
    "Nov": "11",
    "Dec": "12",
  };
  List<String> year = [
    "1990",
    "1992",
    "1993",
    "1994",
    "1995",
    "1996",
    "1997",
    "1998",
    "1999",
    "2000",
    "2001"
  ];
  List<String> genders = ["Male", "Female", "Other"];
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterBloc(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Selector<RegisterBloc, bool>(
            selector: (context, bloc) => bloc.isLoading,
            builder: (context, isLoading, child) => Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SafeArea(
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          size: BACK_BUTTON_SIZE,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(
                      height: MARGIN_LARGE,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: MARGIN_MEDIUM_3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            HI_TEXT,
                            style: TextStyle(
                                color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
                                fontSize: 30,
                                fontFamily: 'YorkieDemo',
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: MARGIN_SMALL,
                          ),
                          Text(
                            CREATE_A_NEW_ACCOUNT,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MARGIN_LARGE,
                    ),
                    FormBuilder(
                      key: _formKey,
                      child: Container(
                        padding: EdgeInsets.only(left: MARGIN_MEDIUM_3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Consumer<RegisterBloc>(
                              builder: (context, bloc, child) => Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                child: FormBuilderTextField(
                                  name: 'name',
                                  decoration: InputDecoration(
                                    label: Text("Name"),
                                  ),
                                  onSaved: (name) {
                                    bloc.onUsernameChanged(name ?? "");
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MARGIN_XXLARGE,
                            ),
                            Consumer<RegisterBloc>(
                              builder: (context, bloc, child) => Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                child: FormBuilderTextField(
                                  name: 'email',
                                  decoration: InputDecoration(
                                    label: Text("Email"),
                                  ),
                                  onSaved: (email) {
                                    bloc.onEmailChanged(email ?? "");
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MARGIN_XXLARGE,
                            ),
                            Consumer<RegisterBloc>(
                              builder: (context, bloc, child) => Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                      child: FormBuilderDropdown(
                                        hint: Text("Day"),
                                        name: 'day',
                                        items: day
                                            .map((e) => DropdownMenuItem(
                                                value: e, child: Text(e)))
                                            .toList(),
                                        onSaved: (day) {
                                          bloc.onDayChanged(
                                              day.toString() ?? "");
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: MARGIN_MEDIUM_3,
                                    ),
                                    Consumer<RegisterBloc>(
                                      builder: (context, bloc, builder) =>
                                          Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.25,
                                        child: FormBuilderDropdown(
                                          hint: Text("Month"),
                                          name: 'month',
                                          items: months.keys
                                              .toList()
                                              .map((e) => DropdownMenuItem(
                                                  value: e, child: Text(e)))
                                              .toList(),
                                          onSaved: (month) {

                                            bloc.onMonthChanged(
                                                months[month].toString() ?? "");
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MARGIN_MEDIUM_3,
                                    ),
                                    Consumer<RegisterBloc>(
                                      builder: (context, bloc, builder) =>
                                          Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.15,
                                        child: FormBuilderDropdown(
                                          hint: Text("Year"),
                                          name: 'year',
                                          items: year
                                              .map((e) => DropdownMenuItem(
                                                  value: e, child: Text(e)))
                                              .toList(),
                                          onSaved: (year) {
                                            bloc.onYearChanged(
                                                year.toString() ?? "");
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MARGIN_XXLARGE,
                            ),
                            Consumer<RegisterBloc>(
                              builder: (context, bloc, child) => Container(
                                child: FormBuilderRadioGroup(
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                  name: 'gender',
                                  activeColor:
                                      SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
                                  options: genders
                                      .map(
                                        (e) => FormBuilderFieldOption(
                                          value: e,
                                          child: Text(e),
                                        ),
                                      )
                                      .toList(),
                                  onSaved: (gender) {
                                    bloc.onGenderChanged(
                                        gender.toString() ?? "");
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MARGIN_XLARGE,
                            ),
                            Consumer<RegisterBloc>(
                              builder: (context, bloc, child) => Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                child: FormBuilderTextField(
                                  name: 'password',
                                  decoration: InputDecoration(
                                    label: Text("Password"),
                                  ),
                                  onSaved: (password) {
                                    bloc.onPasswordChanged(password ?? "");
                                    print(bloc.password);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MARGIN_XLARGE,
                            ),
                            Consumer<RegisterBloc>(
                              builder: (context, bloc, child) =>
                                  FormBuilderCheckbox(
                                name: 'agreement',
                                activeColor: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
                                title: Text("Agree to Term and Service"),
                                onSaved: (value) {
                                  bloc.onAgreeChanged(value ?? false);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MARGIN_XLARGE,
                    ),
                    Consumer<RegisterBloc>(
                      builder: (context, bloc, child) => Center(
                        child: FullColorButton(
                            onTapAction: () async {
                              _formKey.currentState!.save();
                              bloc.onTapRegister();
                              Timer(Duration(seconds: 3), () {
                               navigateToScreen(context,LoginPage());
                              });
                            },

                            //     () {
                            //   _formKey.currentState!.save();
                            // },
                            name: SPLASH_SCREEN_SIGN_UP_TEXT),
                      ),
                    )
                  ],
                ),
                Consumer<RegisterBloc>(
                  builder:(context,bloc,child)=> Positioned(
                    bottom: 0,
                    top: 0,
                    right: 0,
                    left: 0,
                    child: Visibility(
                      visible: bloc.isLoading,
                        child: Container(
                      padding: EdgeInsets.only(top: 100),
                      color: Colors.black45,
                      child: const Center(
                        child: LoadingView(),
                      ),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
