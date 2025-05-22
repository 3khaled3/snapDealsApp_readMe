import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/app/admin_feature/view/widgets/custom_copy_button.dart';

class ShimmerUserCard extends StatelessWidget {
  const ShimmerUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: ColorsBox.grey, width: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Shimmer.fromColors(
          baseColor: ColorsBox.greyReceivedMessage,
          highlightColor: ColorsBox.paleGrey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 16,
                    decoration: BoxDecoration(
                      color: ColorsBox.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  8.pw,
                  const CustomCopyButton(textToCopy: ''), // Placeholder
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white),
                    onPressed: () {}, // لا تفعل شيء أثناء الـ Shimmer
                  ),
                ],
              ),
              8.ph,
              Row(
                children: [
                  const CircleAvatar(
                    radius: 37,
                    backgroundColor: ColorsBox.white,
                  ),
                  20.pw,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 120,
                            height: 16,
                            decoration: BoxDecoration(
                              color: ColorsBox.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          8.pw,
                          const CustomCopyButton(textToCopy: ''),
                        ],
                      ),
                      7.ph,
                      Row(
                        children: [
                          Container(
                            width: 190,
                            height: 14,
                            decoration: BoxDecoration(
                              color: ColorsBox.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          8.pw,
                          const CustomCopyButton(textToCopy: ''),
                        ],
                      ),
                      7.ph,
                      Row(
                        children: [
                          Container(
                            width: 160,
                            height: 14,
                            decoration: BoxDecoration(
                              color: ColorsBox.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          8.pw,
                          const CustomCopyButton(textToCopy: ''),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
