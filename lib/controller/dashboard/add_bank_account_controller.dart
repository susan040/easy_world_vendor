import 'package:easy_world_vendor/models/bank_details.dart';
import 'package:easy_world_vendor/repo/bank_details/add_bank_details_repo.dart';
import 'package:easy_world_vendor/repo/bank_details/edit_bank_details_repo.dart';
import 'package:easy_world_vendor/repo/bank_details/get_bank_details_repo.dart';
import 'package:easy_world_vendor/utils/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class AddBankAccountController extends GetxController {
  final bankAccountformKey = GlobalKey<FormState>();
  final editBankAccountFormKey = GlobalKey<FormState>();
  final accountHolderController = TextEditingController();
  final accountNumberController = TextEditingController();
  final branchNameController = TextEditingController();
  RxList<BankDetails> allBankDetailsLists = <BankDetails>[].obs;
  var isLoading = true.obs;
  @override
  void onInit() {
    super.onInit();
    getAllBankDetails();
  }

  getAllBankDetails() async {
    isLoading.value = true;
    await GetBankDetailsRepo.getBankDetailsRepo(
      onSuccess: (bank) {
        isLoading.value = false;
        allBankDetailsLists.assignAll(bank);
      },
      onError: (msg) {
        isLoading.value = false;
        print("Error: $msg");
      },
    );
  }

  RxString selectedBankName = ''.obs;

  final List<String> nepalInternationalBankList = [
    'Standard Chartered Bank Nepal Limited',
    'Nepal SBI Bank Limited',
    'Nabil Bank Limited',
    'Everest Bank Limited',
    'Himalayan Bank Limited',
    'Global IME Bank Limited',
    'Citizens Bank International Limited',
    'Nepal Investment Mega Bank Limited',
    'NMB Bank Limited',
    'Machhapuchchhre Bank Limited',
    'Agricultural Development Bank of Nepal',
    'Civil Bank Limited',
    'Prime Commercial Bank Limited',
    'Century Commercial Bank Limited',
    'Laxmi Bank Limited',
    'Sanima Bank Limited',
    'Nepal Bangladesh Bank Limited',
    'NIC Asia Bank Limited',
    'Kumari Bank Limited',
    'Siddhartha Bank Limited',
    'Jyoti Bikas Bank Limited',
    'NepaL Credit and Commerce Bank Limited',
    'Rastriya Banijya Bank',
    'Shivam Bank Limited',
    'Sana Kisan Bikas Bank Limited',
    'Kamana Sewa Bikas Bank Limited',
    'Lumbini Bikas Bank Limited',
    'Jyoti Bikash Bank Limited',
  ];

  void updateSelectedBankName(String bankName) {
    selectedBankName.value = bankName;
  }

  final loading = SimpleFontelicoProgressDialog(
    context: Get.context!,
    barrierDimisable: false,
  );

  void onSubmit() async {
    if (bankAccountformKey.currentState!.validate()) {
      loading.show(message: 'Loading...');
      await AddBankDetailsRepo.addBankDetailsRepo(
        accountHolderName: accountHolderController.text,
        accountNumber: accountNumberController.text,
        bankName: selectedBankName.value,
        branchName: branchNameController.text,
        onSuccess: (message) {
          loading.hide();
          // Get.offAll(() => DashScreen());
          Get.back();
          CustomSnackBar.success(title: "Bank Details", message: message);
        },
        onError: (message) {
          loading.hide();
          CustomSnackBar.error(title: "Bank Details", message: message);
        },
      );
    }
  }

  void editBankDetails(
    String accountHolderName,
    String accountNo,
    String branchName,
    String bankDetailsId,
  ) async {
    if (editBankAccountFormKey.currentState!.validate()) {
      loading.show(message: 'Loading...');
      await EditBankDetailsRepo.editBankDetailsRepo(
        bankDetailId: bankDetailsId,
        accountHolderName: accountHolderName,
        accountNumber: accountNo,
        bankName: selectedBankName.value,
        branchName: branchName,
        onSuccess: (message) {
          loading.hide();
          Get.back();
          CustomSnackBar.success(title: "Bank Details", message: message);
          allBankDetailsLists.clear();
          getAllBankDetails();
        },
        onError: (message) {
          loading.hide();
          CustomSnackBar.error(title: "Bank Details", message: message);
        },
      );
    }
  }
}
