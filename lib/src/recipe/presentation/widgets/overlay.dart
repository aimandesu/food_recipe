import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/src/core/router/generated_route.dart';
import 'package:food_recipe/src/user/presentation/blocs/authentication/auth_bloc.dart';
import 'package:food_recipe/src/user/presentation/pages/login_page.dart';

class SortDropdown extends StatefulWidget {
  const SortDropdown({super.key});

  @override
  State<SortDropdown> createState() => _SortDropdownState();
}

class _SortDropdownState extends State<SortDropdown>
    with SingleTickerProviderStateMixin {
  OverlayEntry? _dropdownOverlay;
  final GlobalKey _key = LabeledGlobalKey('sort_dropdown');

  final ValueNotifier<bool> isDropdownVisible = ValueNotifier(false);
  final ValueNotifier<String?> selectedSortOption = ValueNotifier('Logout');

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final List<String> sortOptions = [
    'Logout',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _controller.dispose();
    isDropdownVisible.dispose();
    selectedSortOption.dispose();
    _dropdownOverlay?.remove();
    _dropdownOverlay = null;
    super.dispose();
  }

  void showDropdown() {
    if (_dropdownOverlay != null) return;

    final RenderBox? renderBox =
        _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    _dropdownOverlay = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: hideDropdown,
              child: Container(color: Colors.grey.withOpacity(0.5)),
            ),
          ),
          Positioned(
            left: 8,
            top: position.dy + size.height + 8,
            width: 150,
            child: Material(
              color: Colors.transparent,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: _buildDropdownContent(),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_dropdownOverlay!);
    _controller.forward();
    isDropdownVisible.value = true;
  }

  void hideDropdown() {
    if (_dropdownOverlay != null) {
      _controller.reverse().then((_) {
        _dropdownOverlay?.remove();
        _dropdownOverlay = null;
        isDropdownVisible.value = false;
      });
    }
  }

  Widget _buildDropdownContent() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: ValueListenableBuilder(
          valueListenable: isDropdownVisible,
          builder: (context, bool isVisible, child) {
            return isVisible
                ? ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: sortOptions.length,
                    itemBuilder: (BuildContext context, int index) {
                      String option = sortOptions[index];
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            selectedSortOption.value = option;
                            if (selectedSortOption.value == 'Logout') {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                                (Route<dynamic> route) => false,
                              );
                              context.read<AuthBloc>().add(
                                    LogoutEvent(),
                                  );
                            }
                            hideDropdown();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  option,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isDropdownVisible.value) {
          hideDropdown();
        } else {
          showDropdown();
        }
      },
      child: Container(
        key: _key,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: const Icon(Icons.menu),
      ),
    );
  }
}
