import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:snap_deals/app/auth_feature/view/pages/profile_view/about_us.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_primary_button.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/app/home_feature/view/pages/main_home.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_add_details_title.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_add_image.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_add_lesson.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_add_text_field.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_header_add_view.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_tobic.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/model_view/courses/create_course_cubit/create_course_cubit.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:uuid/uuid.dart';

class AddCourseDetailsArgs {
  final Category? category;

  AddCourseDetailsArgs(this.category);
}

class AddCourseDetails extends StatefulWidget {
  const AddCourseDetails({super.key, this.args});

  static const String routeName = '/add_course_details_route';
  final AddCourseDetailsArgs? args;

  @override
  State<AddCourseDetails> createState() => _AddCourseDetailsState();
}

class _AddCourseDetailsState extends State<AddCourseDetails> {
  final GlobalKey<CustomTobicState> topicsKey = GlobalKey<CustomTobicState>();
  final GlobalKey<CustomAddLessonState> lessonKey =
      GlobalKey<CustomAddLessonState>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  // Category? category;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    priceController.dispose();
    super.dispose();
  }

// أضف هذا في أعلى الكلاس
  List<XFile> selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: context.tr.adDetails),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomAddDetailsTitle(
                          title: widget.args!.category!.name,
                          icon: Icons.category,
                        ),
                        23.ph,

                        // 📸 استخدام CustomAddImage مع callback
                        CustomAddImage(
                          onImagesSelected: (images) {
                            setState(() {
                              selectedImages = images;
                            });
                          },
                        ),
                        23.ph,
                        CustomAddTextField(
                          title: context.tr.adTitle,
                          hint: context.tr.enterTitle,
                          controller: titleController,
                        ),
                        23.ph,
                        Text(
                          context.tr.about_course,
                          style: AppTextStyles.semiBold12().copyWith(
                              fontFamily: context.tr.fontFamilyLora),
                        ),
                        6.ph,
                        CustomTextFormField(
                          hintText: context.tr.about_course_hint,
                          height: const EdgeInsets.only(
                              bottom: 100, left: 10, right: 10),
                          controller: descriptionController,
                        ),
                        CustomTobic(key: topicsKey),
                        23.ph,
                        CustomAddLesson(key: lessonKey),
                        23.ph,
                        CustomAddTextField(
                          title: context.tr.location,
                          hint: context.tr.locationHint,
                          controller: locationController,
                        ),
                        23.ph,
                        CustomAddTextField(
                          title: context.tr.price,
                          hint: context.tr.priceHint,
                          isPrice: true,
                          controller: priceController,
                        ),
                        7.ph,

                        // زر الإرسال
                        SizedBox(
                          width: double.infinity,
                          child: BlocListener<CreateCourseCubit,
                              CreateCourseState>(
                            listener: (context, state) {
                              if (state is CreateCourseSuccess) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  context.showSuccessSnackBar(
                                      message: context.tr.add_product_success);
                                  GoRouter.of(context).pushReplacement(
                                      MainHomeView.routeName,
                                      extra: MainHomeViewArgs());
                                });
                              } else if (state is CreateCourseError) {
                                context.showErrorSnackBar(
                                    message: context.tr.add_product_error);
                                Navigator.of(context).pop();
                              } else if (state is CreateCourseLoading) {
                                context.showLoadingDialog();
                              }
                            },
                            child: CustomPrimaryButton(
                              title: context.tr.nextButton,
                              onTap: () async {
                                if (formKey.currentState?.validate() ?? false) {
                                  // 🧪 Debug: طباعة الـ lessons و الـ course JSON
                                  final lessons = lessonKey.currentState
                                          ?.getLessonsTitles()
                                          .map((title) => LessonModel(
                                              id: const Uuid().v4(),
                                              title: title))
                                          .toList() ??
                                      [];

                                  final course = CourseModel(
                                    id: const Uuid().v4(),
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    images: [],
                                    price: int.parse(priceController.text),
                                    category: Category(
                                      id: '6802df0a27ad6e735473aef8',
                                      name: 'Courses',
                                    ),
                                    lessons: lessons,
                                    instructor: Instructor(
                                      id: ProfileCubit
                                          .instance.state.profile.id,
                                      name: ProfileCubit
                                          .instance.state.profile.name,
                                      profileImg: ProfileCubit
                                          .instance.state.profile.profileImg,
                                    ),
                                    location: locationController.text,
                                    ratingsAverage: 0,
                                    ratingsQuantity: 0,
                                    language: 'Arabic',
                                    access: 'Both',
                                    certificate: true,
                                    pendingRequests: [],
                                    students: [],
                                    reviews: [],
                                    views: 0,
                                    details: topicsKey.currentState
                                            ?.getTopicsMap() ??
                                        {},
                                    createdAt: DateTime.now(),
                                    updatedAt: DateTime.now(),
                                  );

                                  // 🧪 طباعة الداتا قبل الإرسال
                                  log('🧪 Final Course Payload: ${course.createCourseFormData()}');
                                  log('🧪 Lessons: ${lessons.map((e) => e.toJson())}');

                                  await BlocProvider.of<CreateCourseCubit>(
                                          context)
                                      .createCourse(
                                    course,
                                    selectedImages.isNotEmpty
                                        ? selectedImages.first
                                        : XFile(''),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
