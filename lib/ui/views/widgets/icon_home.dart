import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_11/core/model/window_manager.dart';
import 'package:window_11/core/utils/assets.dart';
import 'package:window_11/ui/style/typography.dart';

class HomeIcon extends StatelessWidget {
  final String id;
  const HomeIcon({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Material(
        elevation: 0,
        color: Colors.transparent,
        child: InkWell(
          onDoubleTap: () {
            context.read<WindowManager>().newWindow(id, context);
          },
          borderRadius: BorderRadius.circular(7),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AssetData.weather),
                const SizedBox(height: 6),
                Text(
                  "Weather App",
                  style: AppTextStyle.normal(12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
