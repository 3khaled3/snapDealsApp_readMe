import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:snap_deals/app/chat_feature/model_view/get_sup_user_cubit/get_sup_user_cubit.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/request_feature/model_view/send_request_cubit/send_request_cubit.dart';
import 'package:snap_deals/app/request_feature/view/pages/instractor_request_view.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class ContactAndPrice extends StatelessWidget {
  const ContactAndPrice({super.key, required this.courseModel});
  final CourseModel courseModel;
  @override
  Widget build(BuildContext context) {
    final SendRequestCubit sendRequestCubit = SendRequestCubit();
    final user = ProfileCubit.instance.state.profile;
    final isOnwer = user.id == courseModel.instructor.id;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorsBox.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Price Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr.total_price,
                style: AppTextStyles.regular14().copyWith(
                  color: ColorsBox.blueGrey,
                ),
              ),
              4.ph,
              Text(
                courseModel.price == 0
                    ? context.tr.free
                    : '${courseModel.price} EGP',
                style: AppTextStyles.bold18().copyWith(
                  color: ColorsBox.brightBlue,
                ),
              ),
            ],
          ),
          const Spacer(flex: 1),

          // Chat Button
          Expanded(
            flex: 3,
            child: SizedBox(
              height: 48,
              child: !isOnwer
                  ? BlocListener<SendRequestCubit, SendRequestState>(
                      bloc: sendRequestCubit,
                      listener: (context, state) {
                        if (state is SendRequestSuccess) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            context.showSuccessSnackBar(
                              message: context.tr.request_sent,
                            );
                          });
                          Navigator.of(context).pop();
                        } else if (state is SendRequestError) {
                          context.showErrorSnackBar(
                            message: context.tr.request_error,
                          );
                          Navigator.of(context).pop();
                        } else if (state is SendRequestLoading) {
                          context.showLoadingDialog();
                        }
                      },
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () async {
                            GetSupUserCubit getSupUserCubit = GetSupUserCubit();
                            await getSupUserCubit
                                .getSupUser(courseModel.instructor.id);
                            if (getSupUserCubit.state is GetSupUserSuccess) {
                              final result =
                                  getSupUserCubit.state as GetSupUserSuccess;
                              await sendRequestCubit.sendRequest(
                                courseModel.id,
                                Partner(
                                    id: courseModel.instructor.id,
                                    name: result.user.name,
                                    role: result.user.role,
                                    notificationToken:
                                        result.user.notificationToken),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsBox.brightBlue,
                            foregroundColor: ColorsBox.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            elevation: 2,
                          ),
                          child: Text(
                            context.tr.make_request,
                            style: AppTextStyles.semiBold16().copyWith(
                              color: ColorsBox.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          GoRouter.of(context).push(
                              InstractorRequestView.routeName,
                              extra: InstractorRequestViewArgs(
                                  courseId: courseModel.id));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsBox.brightBlue,
                          foregroundColor: ColorsBox.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          elevation: 2,
                        ),
                        child: Text(
                          context.tr.go_my_requests,
                          style: AppTextStyles.semiBold16().copyWith(
                            color: ColorsBox.white,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
