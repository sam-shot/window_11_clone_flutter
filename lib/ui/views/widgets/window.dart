// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:window_11/core/model/window_manager.dart';
import 'package:window_11/core/utils/assets.dart';

class WindowWidget extends StatefulWidget {
  final String id;

  const WindowWidget({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _WindowWidgetState createState() => _WindowWidgetState();
}

class _WindowWidgetState extends State<WindowWidget> {
  Offset position = Offset.zero;
  bool isFull = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: isFull ? 0 : position.dx,
      top: isFull ? 0 : position.dy,
      child: GestureDetector(
        onTap: () => context.read<WindowManager>().bringToFront(widget.id),
        child: Container(
          width: isFull ? MediaQuery.sizeOf(context).width : 500,
          height: isFull ? MediaQuery.sizeOf(context).height - 60 : 400,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 3),
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            children: [
              GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    if (isFull) {
                      isFull = false;
                    }
                    position += details.delta;
                  });
                },
                child: SizedBox(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          Image.asset(AssetData.weather),
                          const Gap(10),
                          Text(
                            widget.id,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          )
                        ],
                      ),
                      const Expanded(
                        child: SizedBox(
                          height: 30,
                          width: double.infinity,
                          child: Text(""),
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () => setState(() {
                              isFull = !isFull;
                            }),
                            child: const Icon(
                              PhosphorIconsRegular.rectangle,
                              size: 20,
                            ),
                          ),
                          const Gap(10),
                          InkWell(
                            onTap: () {
                              context
                                  .read<WindowManager>()
                                  .removeApp(widget.id);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              padding: const EdgeInsets.all(2),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: context.read<WindowManager>().generateColor(),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.id),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
