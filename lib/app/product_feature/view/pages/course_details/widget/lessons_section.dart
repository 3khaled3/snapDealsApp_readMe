import 'package:flutter/material.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class LessonsSection extends StatelessWidget {
  const LessonsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> lessons = [
      'Lesson 1',
      'Lesson 2',
      'Lesson 3',
      'Lesson 4',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        9.ph,
        Text('Lessons (${lessons.length})', style: AppTextStyles.semiBold20()),
        9.ph,
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.36,
          width: double.infinity,
          child: ListView.builder(
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        borderRadius:
                            const BorderRadius.all(Radius.circular(40)),
                        child: Ink(
                          height: 70,
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue),
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(999999),
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: AppTextStyles.regular16()
                                        .copyWith(color: Colors.purple),
                                  ),
                                ),
                              ),
                              30.pw,
                              Text(
                                lessons[index],
                                style: AppTextStyles.regular16()
                                    .copyWith(color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    15.ph,
                  ],
                );
              }),
        ),
      ],
    );
  }
}
