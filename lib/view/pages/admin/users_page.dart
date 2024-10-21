import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_painting_tools/models/view%20model/users_provider.dart';
import 'package:user_painting_tools/view/pages/admin/add_users_admin.dart';
import 'package:user_painting_tools/view/widgets/admin/card_users.dart';
import 'package:user_painting_tools/view/widgets/admin/top_app_bar_admin.dart';
import 'package:user_painting_tools/view/widgets/confirmation_box.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final Color _lightBlue = const Color(0xff0099FF);

  @override
  void initState() {
    super.initState();
    Provider.of<UsersProvider>(context, listen: false).fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TopAppBarAdmin(
          title: "Halaman Pengguna",
          onSearchChanged: (query) {
            Provider.of<UsersProvider>(context, listen: false).filterUsers(query);
          },
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 10, right: 10),
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _lightBlue,
            ),
            child: IconButton(
              onPressed: () async {
                await Get.to(() => AddUsersAdmin());
                Provider.of<UsersProvider>(context, listen: false)
                    .fetchUsers();
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: Consumer<UsersProvider>(
            builder: (BuildContext context, userProvider, child) {
          final listUsers = userProvider.listUsers;
          bool isThereQuery = userProvider.filteredUser.isEmpty;
          return isThereQuery
              ? Center(
                  child: Text("User tersebut tidak ada"),
                )
              : Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: listUsers.isEmpty && userProvider.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : GridView.builder(
                          itemCount: listUsers.length,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 1.2),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            final userData = listUsers[index];
                            return CardUsers(
                              emailUser: userData!.emailUser,
                              longNameUser:
                                  userData.namaLengkap ?? "Belum Mengisi",
                              npkUser: userData.npkUser,
                              onPressedDelete: () {
                                return showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return ConfirmationBox(
                                      textTitle: "Hapus Akun",
                                      textDescription:
                                          "Apakah kamu yakin ingin menghapus akun ${userData.emailUser}?",
                                      textConfirm: "Iya",
                                      textCancel: "Tidak",
                                      onConfirm: () async {
                                        await userProvider.deleteUserOnAuth(
                                            userData.emailUser,
                                            userData.npkUser);
                                        await userProvider.fetchUsers();
                                        Get.snackbar('Berhasil',
                                            'Akun ${userData.emailUser} berhasil dihapus');
                                        Navigator.pop(context);
                                      },
                                      onCancel: () {
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          }),
                );
        }),
      ),
    );
  }
}
