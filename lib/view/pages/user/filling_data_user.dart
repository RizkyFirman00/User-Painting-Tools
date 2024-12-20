import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:user_painting_tools/helper/shared_preferences.dart';
import 'package:user_painting_tools/models/view%20model/tools_provider.dart';
import 'package:user_painting_tools/models/view%20model/users_provider.dart';
import 'package:user_painting_tools/models/view%20model/loans_provider.dart';
import 'package:user_painting_tools/view/pages/user/home_user.dart';
import '../../../models/loans.dart';

class FillingDataUser extends StatefulWidget {
  const FillingDataUser({super.key});

  @override
  State<FillingDataUser> createState() => _FillingDataUserState();
}

class _FillingDataUserState extends State<FillingDataUser> {
  final idToolsFromQr = Get.arguments['idBarang'];

  // Controllers
  final TextEditingController toolsNameController = TextEditingController();
  final TextEditingController toolsIdController = TextEditingController();
  final TextEditingController toolsQtyController = TextEditingController();
  final TextEditingController usersNameController = TextEditingController();
  final TextEditingController userNpkController = TextEditingController();
  final TextEditingController loanDateController = TextEditingController();
  final TextEditingController loanDateReturnController =
      TextEditingController();

  Future<void> _loadData() async {
    final toolsProvider = Provider.of<ToolsProvider>(context, listen: false);
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);

    print("Loading user data...");
    String? npk = await SharedPreferencesUsers.getNpk();

    if (npk != null) {
      await usersProvider.fetchUserDataWithNpk(npk);
      final userData = usersProvider.currentUser;
      print('USER: $userData');
      if (userData == null) {
        print("User data is null after fetching");
      }
    }

    print("Loading tool data...");
    await toolsProvider.fetchToolDataWithId(idToolsFromQr);
    final toolData = toolsProvider.selectedTool;
    print('TOOL: $toolData');
    if (toolData == null) {
      print("Tool data is null after fetching");
    }

    if (toolData != null && usersProvider.currentUser != null) {
      setState(() {
        toolsNameController.text = toolData.namaAlat;
        toolsIdController.text = toolData.idAlat;
        usersNameController.text =
            usersProvider.currentUser!.namaLengkap ?? "Belum Mengisi";
        userNpkController.text = usersProvider.currentUser!.npkUser;
      });
    } else {
      print("Tool or User data is still null");
    }
  }

  Future<void> _submitLoan() async {
    final toolsProvider = Provider.of<ToolsProvider>(context, listen: false);
    final loansProvider = Provider.of<LoansProvider>(context, listen: false);

    final toolsId = toolsIdController.text;
    final toolsQty = int.tryParse(toolsQtyController.text) ?? 0;
    final loanDate = loanDateController.text;
    final returnDate = loanDateReturnController.text;

    if (toolsQty > 0 && loanDate.isNotEmpty && returnDate.isNotEmpty) {
      try {
        DateTime parsedLoanDate = DateFormat('dd-MM-yyyy | HH:mm').parse(loanDate);
        DateTime parsedReturnDate = DateFormat('dd-MM-yyyy | HH:mm').parse(returnDate);

        final loan = Loans(
          toolId: toolsId,
          toolName: toolsNameController.text,
          userName: usersNameController.text,
          userNpk: userNpkController.text,
          toolsQty: toolsQty,
          loanDate: parsedLoanDate,
          loanDateReturn: parsedReturnDate,
          status: "Dipinjam",
        );

        await loansProvider.addLoan(loan);
        await toolsProvider.updateTool(
            toolsId, toolsNameController.text, toolsQty);

        Get.snackbar(
          "Berhasil",
          "Peminjaman alat berhasil dilakukan!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAll(() => const HomeUser());
      } catch (e) {
        Get.snackbar(
          "Gagal",
          "Format tanggal tidak valid!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        "Gagal",
        "Pastikan semua data diisi dengan benar!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLoadingUser =
        Provider.of<UsersProvider>(context, listen: true).isLoading;
    final isLoadingTool =
        Provider.of<ToolsProvider>(context, listen: true).isLoading;
    final isLoadingLoan =
        Provider.of<LoansProvider>(context, listen: true).isLoading;

    final loading = isLoadingUser || isLoadingTool || isLoadingLoan;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFFDF042C),
        centerTitle: true,
        title: const Text(
          "Form Peminjaman Barang",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  TextFormField(
                    enabled: false,
                    controller: toolsNameController,
                    decoration: const InputDecoration(
                      labelText: "Nama Alat",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: toolsIdController,
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: "ID Alat",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: toolsQtyController,
                    enabled: !loading,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kuantitas tidak boleh kosong';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Harus berupa angka';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Kuantitas Alat",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: usersNameController,
                    enabled: false,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person, color: Color(0xffDF042C)),
                      labelText: "Nama Peminjam",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: userNpkController,
                    enabled: false,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.numbers, color: Color(0xffDF042C)),
                      labelText: "NPK Peminjam",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: loanDateController,
                    readOnly: true,
                    enabled: !loading,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (pickedTime != null) {
                          DateTime finalDateTime = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );

                          String formattedDateTime =
                              DateFormat('dd-MM-yyyy | HH:mm')
                                  .format(finalDateTime);

                          setState(() {
                            loanDateController.text = formattedDateTime;
                          });
                        }
                      }
                    },
                    decoration: const InputDecoration(
                      icon: Icon(Icons.date_range, color: Color(0xffDF042C)),
                      labelText: "Tanggal Pinjam",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: loanDateReturnController,
                    enabled: !loading,
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (pickedTime != null) {
                          DateTime finalDateTime = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );

                          String formattedDateTime =
                              DateFormat('dd-MM-yyyy | HH:mm')
                                  .format(finalDateTime);

                          setState(() {
                            loanDateReturnController.text = formattedDateTime;
                          });
                        }
                      }
                    },
                    decoration: const InputDecoration(
                      icon: Icon(Icons.loop, color: Color(0xffDF042C)),
                      labelText: "Tanggal Pengembalian",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ],
              ),
              Container(
                width: 200,
                child: ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      backgroundColor: loading ? WidgetStateProperty.all(Colors.grey) : WidgetStateProperty.all(Color(0xffDF042C)),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    onPressed: loading
                        ? null
                        : _submitLoan,
                    child: loading
                        ? Container(
                            height: 20,
                            width: 20,
                            child:
                                CircularProgressIndicator(color: Colors.white))
                        : Text(
                            "Submit Data",
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                          )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
