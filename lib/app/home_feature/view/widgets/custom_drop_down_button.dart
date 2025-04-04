import 'package:flutter/material.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton({super.key, required this.index});
  final int index;

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  String? newValue;
  List<DropdownMenuItem<String>> ramItems = [
    const DropdownMenuItem(value: 'less_than_1', child: Text('Less than 1')),
    const DropdownMenuItem(value: '1', child: Text('1')),
    const DropdownMenuItem(value: '2', child: Text('2')),
    const DropdownMenuItem(value: '3', child: Text('3')),
    const DropdownMenuItem(value: '4', child: Text('4')),
    const DropdownMenuItem(value: '6', child: Text('6')),
    const DropdownMenuItem(value: '8', child: Text('8')),
    const DropdownMenuItem(value: '12', child: Text('12')),
    const DropdownMenuItem(value: '16', child: Text('16')),
    const DropdownMenuItem(value: 'more_than_16', child: Text('More than 16')),
  ];
  List<DropdownMenuItem<String>> storageItems = [
    const DropdownMenuItem(value: 'below_1000', child: Text('Below 1000 mAH')),
    const DropdownMenuItem(value: '1000', child: Text('(+) 1000 mAH')),
    const DropdownMenuItem(value: '2000', child: Text('(+) 2000 mAH')),
    const DropdownMenuItem(value: '3000', child: Text('(+) 3000 mAH')),
    const DropdownMenuItem(value: '4000', child: Text('(+) 4000 mAH')),
    const DropdownMenuItem(value: '5000', child: Text('(+) 5000 mAH')),
  ];
  List<DropdownMenuItem<String>> batteryCapacityItems = [
    const DropdownMenuItem(value: 'less_than_8', child: Text('Less than 8 GB')),
    const DropdownMenuItem(value: '8', child: Text('8 GB')),
    const DropdownMenuItem(value: '16', child: Text('16 GB')),
    const DropdownMenuItem(value: '32', child: Text('32 GB')),
    const DropdownMenuItem(value: '64', child: Text('64 GB')),
    const DropdownMenuItem(value: '128', child: Text('128 GB')),
    const DropdownMenuItem(value: '256', child: Text('256 GB')),
    const DropdownMenuItem(value: '512', child: Text('512 GB')),
    const DropdownMenuItem(value: '1_tb', child: Text('1 TB')),
    const DropdownMenuItem(
        value: 'more_than_1_tb', child: Text('More than 1 TB')),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: ColorsBox.black),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: DropdownButton<String>(
          items: widget.index == 1
              ? ramItems
              : widget.index == 2
                  ? storageItems
                  : batteryCapacityItems,
          icon: const Icon(
            Icons.arrow_forward_ios,
            color: ColorsBox.brightBlue,
          ),
          hint: Text(
            context.tr.choose,
            style: AppTextStyles.regular16().copyWith(
                fontFamily: AppTextStyles.fontFamilyLora,
                color: ColorsBox.greyish),
          ),
          value: newValue,
          underline: const SizedBox(),
          isExpanded: true,
          style: AppTextStyles.regular16().copyWith(color: ColorsBox.slateGrey),
          onChanged: (String? value) => setState(() => newValue = value!),
        ),
      ),
    );
  }
}
