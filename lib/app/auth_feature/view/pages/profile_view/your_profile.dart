import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snap_deals/app/auth_feature/data/models/basic_user_model.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:snap_deals/app/auth_feature/view/pages/auth_view/login_view.dart';
import 'package:snap_deals/app/auth_feature/view/pages/profile_view/about_us.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_primary_button.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/app/home_feature/view/pages/home_view.dart';
import 'package:snap_deals/app/home_feature/view/pages/main_home.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';
import 'package:snap_deals/core/utils/hive_helper.dart';
import 'package:snap_deals/core/utils/validators.dart';

class YourProfileView extends StatefulWidget {
  const YourProfileView({super.key});

  static const String routeName = '/your_profile_route';

  @override
  State<YourProfileView> createState() => _YourProfileViewState();
}

class _YourProfileViewState extends State<YourProfileView> {
  final formKey = GlobalKey<FormState>();
  XFile? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _numberController;

  @override
  void initState() {
    super.initState();
    final user = ProfileCubit.instance.state.profile;
    _nameController = TextEditingController(text: user.name);
    _numberController = TextEditingController(text: user.phone);
    _emailController = TextEditingController(text: user.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _pickedImage = image);
    }
  }

  void _onSave() {
    if (formKey.currentState?.validate() ?? false) {
      final updatedUser = UserModel(
        id: ProfileCubit.instance.state.profile.id,
        name: _nameController.text,
        email: ProfileCubit.instance.state.profile.email,
        role: ProfileCubit.instance.state.profile.role,
        active: ProfileCubit.instance.state.profile.active,
        createdAt: ProfileCubit.instance.state.profile.createdAt,
        updatedAt: DateTime.now(),
        phone: _numberController.text,
        profileImg: _pickedImage?.path,
      );
      ProfileCubit.instance.updateUser(updatedUser, _pickedImage);
    }
  }

  void _deleteAccount() {
    final password = HiveHelper.instance.getItem("password");
    if (password != null) {
      ProfileCubit.instance.deleteUser(password: password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: context.tr.yourProfileLabel),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 18,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      12.ph,
                      _buildProfileSection(),
                      24.ph,
                      _buildFormFields(context),
                      24.ph,
                      _buildContactSection(context),
                      57.ph,
                      BlocListener<ProfileCubit, ProfileStates>(
                        bloc: ProfileCubit.instance,
                        listener: (context, state) {
                          if (state is ProfileError) {
                            context.showErrorSnackBar(
                                message: context.tr.update_profile_error);

                            Navigator.of(context).pop();
                          } else if (state is ProfileSuccess) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              context.showSuccessSnackBar(
                                message: context.tr.update_profile_success,
                              );
                              while (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                            });
                          } else if (state is ProfileLoading) {
                            context.showLoadingDialog();
                          }
                        },
                        child: CustomPrimaryButton(
                          title: context.tr.saveButton,
                          onTap: _onSave,
                        ),
                      ),
                      24.ph,
                      BlocListener<ProfileCubit, ProfileStates>(
                        bloc: ProfileCubit.instance,
                        listener: (context, state) {
                          if (state is DeleteUserError) {
                            context.showErrorSnackBar(
                                message: context.tr.delete_account_error);

                            Navigator.of(context).pop();
                          } else if (state is DeleteUserSuccess) {
                            Navigator.of(context).pop();
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              context.showSuccessSnackBar(
                                message: context.tr.delete_account_success,
                              );
                              GoRouter.of(context).pushReplacement(
                                   LoginScreen.routeName,
                                    extra: LoginViewArgs());
                            });
                          } else if (state is DeleteUserLoading) {
                            context.showLoadingDialog();
                          }
                        },
                        child: CustomPrimaryButton(
                          title: context.tr.deleteAccount,
                          buttonColor: ColorsBox.brightRed,
                          onTap: _deleteAccount,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Column(
      children: [
        Stack(
          children: [
            ClipOval(
              child: _pickedImage != null
                  ? Image.file(
                      File(_pickedImage!.path),
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl:
                          ProfileCubit.instance.state.profile.profileImg ?? "https://static.vecteezy.com/system/resources/previews/009/292/244/non_2x/default-avatar-icon-of-social-media-user-vector.jpg",
                      placeholder: (context, url) => SvgPicture.asset(
                        AppImageAssets.defaultProfile,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) => SvgPicture.asset(
                        AppImageAssets.defaultProfile,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: _pickImage,
                child: const CircleAvatar(
                  radius: 18,
                  backgroundColor: ColorsBox.brightBlue,
                  child: Icon(EvaIcons.cameraOutline, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        24.ph,
        CustomTextFormField(
          controller: _nameController,
          hintText: context.tr.yourName,
          labelText: context.tr.Name,
          validator: Validators.validateName,
        ),
      ],
    );
  }

  Widget _buildFormFields(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          controller: _emailController,
          hintText: context.tr.hintEmail,
          labelText: context.tr.emailLabel,
          validator: Validators.validateEmail,
          keyboardType: TextInputType.emailAddress,
        ),
        // 24.ph,
        // CustomTextFormField(
        //   controller: _addressController,
        //   hintText: context.tr.yourAddress,
        //   labelText: context.tr.Address,
        //   validator: Validators.validateAddress,
        // ),
      ],
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFormField(
          controller: _numberController,
          hintText: context.tr.yourNumber,
          labelText: context.tr.Number,
          validator: Validators.validateNumber,
          keyboardType: TextInputType.number,
        ),
        8.ph,
        Text(context.tr.contactNumber, style: AppTextStyles.regular12()),
        18.ph,
      ],
    );
  }
}
