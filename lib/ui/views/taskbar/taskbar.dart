import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:window_11/core/model/taskbar_model.dart';
import 'package:window_11/core/utils/assets.dart';
import 'package:window_11/ui/style/colors.dart';
import 'package:window_11/ui/style/typography.dart';

class Taskbar extends StatelessWidget {
  const Taskbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(AssetData.weather),
              const Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "8`C",
                    style: AppTextStyle.bold(13),
                  ),
                  const Gap(3),
                  Text(
                    "Partly sunny",
                    style: AppTextStyle.normal(14),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              TaskbarIcon(
                iconPath: AssetData.weather,
                onTap: () {
                  context.read<TaskbarModel>().startMenuOpened = !context.read<TaskbarModel>().startMenuOpened;
                  context.read<TaskbarModel>().updateUI();
                },
              ),
              const TaskbarIcon(iconPath: AssetData.weather),
              const TaskbarIcon(iconPath: AssetData.weather),
              const TaskbarIcon(iconPath: AssetData.weather),
              const TaskbarIcon(iconPath: AssetData.weather),
            ],
          ),
          const Row(
            children: [
              Icon(Icons.arrow_back_ios_new),
              Gap(60),
            ],
          )
        ],
      ),
    );
  }
}

class TaskbarIcon extends StatelessWidget {
  final String iconPath;
  final VoidCallback? onTap;
  const TaskbarIcon({
    super.key,
    this.onTap,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      splashColor: Colors.red,
      highlightColor: Colors.grey,
      focusColor: Colors.grey,
      hoverColor: Colors.grey,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(right: 5),
        padding: const EdgeInsets.all(10),
        child: Image.asset(iconPath),
      ),
    );
  }
}
