import 'package:flutter/material.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class CustomDetailsGrid extends StatelessWidget {
  final Map<String, dynamic> details;

  const CustomDetailsGrid({super.key, required this.details});

  /// دالة لتفريغ أي Map داخلية
  List<MapEntry<String, dynamic>> flattenMap(Map<String, dynamic> map) {
    final List<MapEntry<String, dynamic>> result = [];

    for (var entry in map.entries) {
      if (entry.value is Map) {
        final nestedMap = entry.value as Map;
        result.addAll(nestedMap.entries.map(
          (e) => MapEntry(e.key.toString(), e.value),
        ));
      } else {
        result.add(entry);
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final entries = flattenMap(details);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.info,
                color: ColorsBox.brightBlue,
              ),
              8.pw,
              Text(
                context.tr.details,
                style: AppTextStyles.medium20().copyWith(
                  fontFamily: AppTextStyles.fontFamilyLora,
                  color: ColorsBox.brightBlue,
                ),
              ),
            ],
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: entries.length,
            padding: const EdgeInsets.only(top: 12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2.5,
            ),
            itemBuilder: (context, index) {
              final entry = entries[index];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      entry.key,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.medium16().copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    4.ph,
                    Text(
                      entry.value.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.semiBold14().copyWith(
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
