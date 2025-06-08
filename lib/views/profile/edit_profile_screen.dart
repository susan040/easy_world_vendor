import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_world_vendor/controller/dashboard/profile_screen_controller.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/utils/image_path.dart';
import 'package:easy_world_vendor/utils/validator.dart';
import 'package:easy_world_vendor/widgets/custom/custom_textfield.dart';
import 'package:easy_world_vendor/widgets/custom/elevated_button.dart';
import 'package:easy_world_vendor/widgets/edit_document_widget.dart';
import 'package:easy_world_vendor/widgets/edit_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final c = Get.put(ProfileScreenController());
  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: CustomTextStyles.f16W600(
            color: isDark ? AppColors.extraWhite : AppColors.blackColor,
          ),
        ),
        centerTitle: true,
        backgroundColor:
            isDark ? AppColors.darkModeColor : AppColors.extraWhite,
        elevation: 0,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back,
            color: isDark ? AppColors.extraWhite : AppColors.blackColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 6,
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Obx(() {
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child:
                              c.selectedImage.value != null
                                  ? Image.file(
                                    c.selectedImage.value!,
                                    fit: BoxFit.cover,
                                    height: 120,
                                    width: 120,
                                  )
                                  : CachedNetworkImage(
                                    imageUrl: c.selectedImage.value.toString(),
                                    placeholder:
                                        (context, url) => const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                    errorWidget:
                                        (context, url, error) => Image.asset(
                                          ImagePath.blankProfile,
                                          height: 120,
                                          width: 120,
                                          fit: BoxFit.cover,
                                        ),
                                    fit: BoxFit.cover,
                                    height: 120,
                                    width: 120,
                                  ),
                        ),
                        Positioned(
                          bottom: 8,
                          right: 5,
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                ),
                                builder:
                                    (context) => EditProfileBottomSheetWidget(
                                      isDark: isDark,
                                      c: c,
                                    ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: AppColors.primaryColor,
                              child: SvgPicture.asset(
                                ImagePath.editProfile,
                                color: AppColors.extraWhite,
                                height: 18,
                                width: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                SizedBox(height: 25),
                Text(
                  "Store Name",
                  style: CustomTextStyles.f12W500(
                    color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                  ),
                ),
                SizedBox(height: 8),
                CustomTextField(
                  hint: "Store Name",
                  controller: c.fullNameController,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                ),
                SizedBox(height: 16),
                Text(
                  "Phone Number",
                  style: CustomTextStyles.f12W500(
                    color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                  ),
                ),
                SizedBox(height: 8),
                CustomTextField(
                  hint: "Phone number",
                  controller: c.phoneNumberController,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.phone,
                ),
                SizedBox(height: 16),
                Text(
                  "Select Gender",
                  style: CustomTextStyles.f12W500(
                    color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                  ),
                ),
                SizedBox(height: 8),
                Obx(
                  () => Container(
                    constraints: BoxConstraints(minHeight: 50),
                    child: DropdownButtonFormField<String>(
                      menuMaxHeight: 350,
                      dropdownColor: AppColors.extraWhite,
                      focusColor: AppColors.extraWhite,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      value:
                          c.selectGender.value.isEmpty
                              ? null
                              : c.selectGender.value,
                      hint: Text(
                        "Select Gender",
                        style: CustomTextStyles.f12W400(
                          color:
                              isDark
                                  ? AppColors.extraWhite
                                  : AppColors.secondaryTextColor,
                        ),
                      ),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(
                          bottom: 10,
                          left: 14,
                          right: 14,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.borderColor,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                            width: 1,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
                      ),
                      items:
                          c.genderList
                              .map(
                                (option) => DropdownMenuItem<String>(
                                  value: option,
                                  child: Text(
                                    option,
                                    style: CustomTextStyles.f12W400(),
                                  ),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        c.updateSelectedGender(value!);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Birthday",
                  style: CustomTextStyles.f12W500(
                    color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                  ),
                ),
                SizedBox(height: 8),
                CustomTextField(
                  readOnly: true,
                  onTap: () => c.chooseDate(context),
                  controller: c.selectBirthdayController,
                  validator: Validators.checkFieldEmpty,
                  suffixIconPath: Icons.calendar_month,
                  hint: "yyyy-mm-dd",
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.none,
                ),
                SizedBox(height: 16),
                Text(
                  "Document/Image",
                  style: CustomTextStyles.f12W500(
                    color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                  ),
                ),
                SizedBox(height: 8),
                EditDocumentWidget(c: c, isDark: isDark),
                SizedBox(height: 25),
                CustomElevatedButton(
                  title: "Update Details",
                  onTap: () {},
                  backGroundColor: AppColors.primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
