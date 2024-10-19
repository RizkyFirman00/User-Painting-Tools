import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_painting_tools/models/users.dart';
import 'package:user_painting_tools/models/view%20model/users_provider.dart';
import 'package:user_painting_tools/view/pages/admin/add_users_admin.dart';
import 'package:user_painting_tools/view/pages/admin/profile_admin.dart';
import 'package:user_painting_tools/view/widgets/admin/top_app_bar_admin.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final Color _lightBlue = const Color(0xff0099FF);
  final List<Users> listUsers = [];

  @override
  void initState() {
    Future.microtask(() =>
        Provider.of<UsersProvider>(context, listen: false).fetchAllUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TopAppBarAdmin(title: "Halaman Pengguna"),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 10, right: 10),
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _lightBlue,
            ),
            child: Expanded(
              child: IconButton(
                onPressed: () {
                  Get.to(() => AddUsersAdmin());
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        body: Consumer<UsersProvider>(
            builder: (BuildContext context, userProvider, child) {
          final listUsers = userProvider.listUsers;
          return Padding(
            padding: const EdgeInsets.all(25.0),
            child: GridView.builder(
                itemCount: listUsers.length,
                physics: AlwaysScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 2),
                itemBuilder: (BuildContext context, int index) {
                  final userData = listUsers[index];
                  return listUsers.isNotEmpty
                      ? Card(
                          child: Container(
                            width: 176,
                            height: 110,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  userData.emailUser,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  userData.namaLengkap ?? "Belum mengisi",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  userData.npkUser,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Center(child: CircularProgressIndicator());
                }),
          );
        }),
      ),
    );
  }
}
