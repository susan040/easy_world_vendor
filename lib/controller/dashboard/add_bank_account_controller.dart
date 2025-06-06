import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBankAccountController extends GetxController {
  final bankAccountformKey = GlobalKey<FormState>();

  final accountHolderController = TextEditingController();
  final bankNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final ifscController = TextEditingController();
  final branchNameController = TextEditingController();
}
