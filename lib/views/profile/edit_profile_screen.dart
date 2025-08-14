import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_world_vendor/controller/dashboard/profile_screen_controller.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/utils/image_path.dart';
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
          key: c.editProfileFormKey,
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
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 1,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child:
                                c.selectedImage.value != null
                                    ? Image.file(
                                      c.selectedImage.value!,
                                      fit: BoxFit.cover,
                                      height: 120,
                                      width: 120,
                                    )
                                    : CachedNetworkImage(
                                      imageUrl:
                                          c.profileImageUrl.value.toString(),
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
                  controller: c.storeNameController,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                ),
                SizedBox(height: 12),
                Text(
                  "Country Code",
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
                      dropdownColor:
                          isDark ? AppColors.blackColor : AppColors.extraWhite,
                      focusColor:
                          isDark ? AppColors.blackColor : AppColors.extraWhite,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      value:
                          c.selectCountryCode.value.isEmpty
                              ? null
                              : c.selectCountryCode.value,
                      hint: Text(
                        "Select country code",
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
                          c.countryCodeList
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
                        c.updateSelectedCountryCode(value!);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 12),
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
                SizedBox(height: 12),
                Text(
                  "Description",
                  style: CustomTextStyles.f12W500(
                    color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  style: CustomTextStyles.f12W400(
                    color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                  ),

                  maxLines: 4,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: "Store Description..",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        width: 1,
                        color: AppColors.borderColor,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        width: 1,
                        color: AppColors.errorColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        width: 1,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        width: 1,
                        color: AppColors.errorColor,
                      ),
                    ),
                    hintStyle: CustomTextStyles.f12W400(
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                  controller: c.storeDescriptionController,
                ),

                SizedBox(height: 12),
                Text(
                  "Document/Image",
                  style: CustomTextStyles.f12W500(
                    color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                  ),
                ),
                SizedBox(height: 8),
                EditDocumentWidget(c: c, isDark: isDark),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 12,
            top: 10,
          ),
          child: CustomElevatedButton(
            title: "Update Details",
            onTap: () {
              c.editProfile();
            },
            backGroundColor: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
