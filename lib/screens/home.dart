import 'package:door_shop_admin/services/provider_data/addition_data.dart';
import 'package:door_shop_admin/services/admin_autherization/authorization.dart';
import 'package:door_shop_admin/services/provider_data/home_data.dart';
import 'package:door_shop_admin/services/utility.dart';
import 'package:door_shop_admin/widgets/addition_widgets/addition.dart';
import 'package:door_shop_admin/widgets/loading.dart';
import 'package:door_shop_admin/widgets/updation_widgets/updation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// TODO: make a add page for vegetables and update page to update the pricing


class Home extends StatelessWidget {
  final AuthorizationService _authorization = AuthorizationService();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AdditionData>(
      create: (context) => AdditionData(),
      child: Consumer<HomeData>(
        builder: (context, home, child){
          return home.pageloading ? Loading() : GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                currentFocus.focusedChild.unfocus();
              }
            },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Palette.primaryColor,
                elevation: 0,
                title: Text('Door Shop Admin'),
                actions: [
                  PopupMenuButton<int>(
                    itemBuilder: (context) => [
                      PopupMenuItem<int>(
                        value: 0,
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text('Logout')
                          ],
                        ),
                      )
                    ],
                    onSelected: (item) async {
                      if(item == 0){
                        home.pageLoading();
                        await _authorization.signOut();
                      }
                    },
                  ),
                ],
              ),
              body: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      tabs: [
                        Tab(
                          text: 'Addition',
                        ),
                        Tab(
                          text: 'Updation',
                        )
                      ],
                      indicatorColor: Palette.primaryColor,
                      labelColor: Palette.primaryColor,
                      unselectedLabelColor: Palette.primaryColor.withOpacity(0.5),
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Addition(),
                          Updation()
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
