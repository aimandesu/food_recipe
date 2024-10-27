import 'package:flutter/material.dart';
import 'package:food_recipe/src/core/utils/styles/styles.dart';

class ProgressStepper<T> extends StatelessWidget {
  const ProgressStepper({
    super.key,
    required this.btnTitles,
    required this.currentTab,
    required this.onTapCallbacks,
    required this.enumSelection,
  });

  factory ProgressStepper.genericStepper({
    required final List<String> btnTitles,
    required final List<T> enumSelection,
    required final T currentTab,
    required final List<VoidCallback?> onTapCallbacks,
  }) {
    return ProgressStepper(
      btnTitles: btnTitles,
      currentTab: currentTab,
      onTapCallbacks: onTapCallbacks,
      enumSelection: enumSelection,
    );
  }

  final List<String> btnTitles;
  final List<T> enumSelection;
  final T currentTab;
  final List<VoidCallback?> onTapCallbacks;

  @override
  Widget build(BuildContext context) {
    bool isStepPassed(
      T step,
      T currentTab,
      List<T> enumSelection,
    ) {
      return enumSelection.indexOf(currentTab) >= enumSelection.indexOf(step);
    }

    bool isStepBuffering(
      T step,
      T currentTab,
      List<T> enumSelection,
    ) {
      return enumSelection.indexOf(step) < enumSelection.indexOf(currentTab);
    }

    return Column(
      children: [
        Row(
          children: List.generate(
            btnTitles.length * 2 - 1,
            (index) {
              if (index.isEven) {
                int btnIndex = index ~/ 2;

                return InformationBtn(
                  isStepBuffering: isStepBuffering(
                    enumSelection[btnIndex],
                    currentTab,
                    enumSelection,
                  ),
                  btnTitle: btnTitles[btnIndex],
                  currentTab: isStepPassed(
                    enumSelection[btnIndex],
                    currentTab,
                    enumSelection,
                  ),
                  moveForward: onTapCallbacks[btnIndex],
                );
              } else {
                //DottedLine goes
                int prevBtnIndex = index ~/ 2;
                int nextBtnIndex = prevBtnIndex + 1;

                bool isNextStepPassed = nextBtnIndex < enumSelection.length &&
                    isStepPassed(
                      enumSelection[nextBtnIndex],
                      currentTab,
                      enumSelection,
                    );
                return Expanded(
                  child: Container(
                    height: 2,
                    color: isNextStepPassed
                        ? Colors.red
                        : Colors.grey.withOpacity(0.5),
                  ),
                );
              }
            },
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}

class InformationBtn extends StatelessWidget {
  const InformationBtn({
    super.key,
    required this.btnTitle,
    required this.currentTab,
    required this.moveForward,
    required this.isStepBuffering,
  });
  final String btnTitle;
  final bool currentTab;
  final VoidCallback? moveForward;
  final bool isStepBuffering;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: moveForward,
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          border: !currentTab
              ? Border.all(
                  color: Colors.grey.withOpacity(0.4),
                  width: 2,
                )
              : null,
          color: currentTab ? Colors.red : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: isStepBuffering
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                )
              : Text(
                  btnTitle,
                  style: TextStyleShared.textStyle.subtitle.copyWith(
                    fontWeight: FontWeight.w700,
                    color: currentTab ? Colors.white : Colors.grey,
                  ),
                ),
        ),
      ),
    );
  }
}
