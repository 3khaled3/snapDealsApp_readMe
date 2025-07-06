import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_primary_button.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/app/home_feature/view/pages/main_home.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_add_text_field.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_header_add_view.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/model_view/courses/update_course_cubit/update_course_cubit.dart';
import 'package:snap_deals/app/product_feature/model_view/update_product_cubit/update_product_cubit.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/edit_lesson.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/widgets/custom_edit_topic.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class EditCourseArgs {
  final CourseModel? course;

  EditCourseArgs(this.course);
}

class EditCourseView extends StatefulWidget {
  const EditCourseView({super.key, this.args});
  static const String routeName = '/edit_course_route';
  final EditCourseArgs? args;

  @override
  State<EditCourseView> createState() => _EditCourseViewState();
}

class _EditCourseViewState extends State<EditCourseView> {
  final GlobalKey<CustomEditTobicState> topicsKey = GlobalKey<CustomEditTobicState>();
  final GlobalKey<CustomEditLessonState> lessonsKey = GlobalKey<CustomEditLessonState>();


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController locationController;
  late TextEditingController priceController;


  UpdateCourseCubit updateCourseCubit = UpdateCourseCubit();

// تحويل Map<String, dynamic> إلى Map<String, String> بشكل آمن:
  Map<String, String> initialTopics = {};
 List<LessonModel> initialLessons = [];

  @override
  void initState() {
    super.initState();
    final p = widget.args?.course;

    titleController = TextEditingController(text: p?.title ?? '');
    descriptionController = TextEditingController(text: p?.description ?? '');
    locationController = TextEditingController(text: p?.location ?? '');
    priceController = TextEditingController(text: p?.price.toString() ?? '');

    if (p?.details != null) {
      initialTopics =
          p!.details.map((key, value) => MapEntry(key, value.toString()));
    }
    if (p?.lessons != null) {
      initialLessons = p!.lessons;
    }

  }

  @override
  void dispose() {
    
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 70, right: 20, left: 20, bottom: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeaderAddView(
                  title: context.tr.editProduct,
                  icon: Icons.arrow_back_ios_new,
                ),
                const Divider(thickness: 1, color: ColorsBox.black),
                15.ph,
                // CustomAddDetailsTitle(
                //   title: widget.args!.product!.category.name,
                //   icon: Icons.category,
                // ),
                // 23.ph,
               
              
                // CustomAddTextField(
                //   title: context.tr.brand,
                //   hint: context.tr.brandHint,
                //   controller: brandController,
                // ),
                // 23.ph,
                CustomAddTextField(
                  title: context.tr.adTitle,
                  hint: context.tr.enterTitle,
                  controller: titleController,
                ),
                23.ph,
                Text(
                  context.tr.describtion,
                  style: AppTextStyles.semiBold12()
                      .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
                ),
                6.ph,
                CustomTextFormField(
                  hintText: context.tr.describtionHint,
                  height:
                      const EdgeInsets.only(bottom: 100, left: 10, right: 10),
                  controller: descriptionController,
                ),
                CustomEditTobic(
                  key: topicsKey,
                  initialTopics: initialTopics,
                ),
                15.ph,
                CustomEditLesson(
  key: lessonsKey,
  initialLessons: initialLessons,
),


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
                SizedBox(
                  width: double.infinity,
                  child: BlocListener<UpdateCourseCubit, UpdateCourseState>(
                    bloc: updateCourseCubit,
                    listener: (context, state) {
                      if (state is UpdateCourseSuccess) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          context.showSuccessSnackBar(
                              message: context.tr.update_success);
                          GoRouter.of(context).pushReplacement(MainHomeView.routeName); // العودة للصفحة السابقة
                        });
                      } else if (state is UpdateCourseError) {
                        GoRouter.of(context).pop(); // إغلاق أي حوار مفتوح
                        context.showErrorSnackBar(
                            message: context.tr.update_error);
                      } else if (state is UpdateCourseLoading) {
                        context.showLoadingDialog();
                      }
                    },
                    child: CustomPrimaryButton(
                      title: context.tr.saveButton,
                      onTap: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          final updatedCourse = widget.args!.course!.copyWith(
                            
                            title: titleController.text,
                            description: descriptionController.text,
                            location: locationController.text,
                            price: int.parse(priceController.text),
                            details:
                                topicsKey.currentState?.getTopicsMap() ?? {},
                            updatedAt: DateTime.now(),
                            lessons: lessonsKey.currentState?.getLessonsList() ?? [],


                          );
                          final Map<String, dynamic> updatedFields = {};


if (updatedCourse.title != widget.args!.course!.title) {
  updatedFields['title'] = updatedCourse.title;
}
if (updatedCourse.description != widget.args!.course!.description) {
  updatedFields['description'] = updatedCourse.description;
}
if (updatedCourse.location != widget.args!.course!.location) {
  updatedFields['location'] = updatedCourse.location;
}
if (updatedCourse.price != widget.args!.course!.price) {
  updatedFields['price'] = updatedCourse.price;
}
if (updatedCourse.details.toString() != widget.args!.course!.details.toString()) {
  updatedFields['details'] = updatedCourse.details;
}
final oldLessons = widget.args!.course!.lessons.map((e) => e.toJson()).toList();
final newLessons = updatedCourse.lessons.map((e) => e.toJson()).toList();

if (oldLessons.toString() != newLessons.toString()) {
  updatedFields['lessons'] = updatedCourse.lessons
    .map((e) => {'title': e.title})
    .toList();

}



print('Topics Map: ${topicsKey.currentState?.getTopicsMap()}');
print('Lessons List: ${lessonsKey.currentState?.getLessonsList()?.map((e) => e.toJson()).toList()}');



                          await updateCourseCubit.updateCourse(
                            updatedCourse,
                            updatedFields
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
    );
  }
}
