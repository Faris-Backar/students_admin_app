// sidebar_widget.dart

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:student_app_admin/core/app_strings.dart';
import 'package:student_app_admin/core/routes/app_router.dart';
import 'package:student_app_admin/core/theme/app_theme.dart';

class SidebarWidget extends StatefulWidget {
  final bool isExpanded;
  final VoidCallback onToggleExpand;

  const SidebarWidget({
    super.key,
    required this.isExpanded,
    required this.onToggleExpand,
  });

  @override
  State<SidebarWidget> createState() => _SidebarState();
}

class _SidebarState extends State<SidebarWidget> {
  int selectedIndex = 0;
  int? hoveredIndex;

  final List<Map<String, dynamic>> options = [
    {
      AppStrings.icon: Icons.home,
      AppStrings.title: AppStrings.home,
      AppStrings.route: PageResources.homeNested
    },
    {
      AppStrings.icon: Icons.school,
      AppStrings.title: AppStrings.students,
      AppStrings.route: PageResources.students
    },
    {
      AppStrings.icon: Icons.campaign,
      AppStrings.title: AppStrings.campaings,
      AppStrings.route: PageResources.campaign
    },
    // {
    //   AppStrings.icon: Icons.settings,
    //   AppStrings.title: AppStrings.admin,
    //   AppStrings.route: PageResources.admin
    // },
    {
      AppStrings.icon: Icons.settings,
      AppStrings.title: AppStrings.settings,
      AppStrings.route: PageResources.settings
    },
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: widget.isExpanded ? 200 : 80,
      color: AppTheme.darkPurple,
      child: Column(
        children: [
          const SizedBox(height: 10),
          ...List.generate(options.length, (index) {
            final isHovered = hoveredIndex == index;
            final isSelected = selectedIndex == index;

            return MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => setState(() => hoveredIndex = index),
              onExit: (_) => setState(() => hoveredIndex = null),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                  context.router.pushNamed(
                      options[index][AppStrings.route]); // Navigate to route
                },
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.white
                        : isHovered
                            ? Colors.grey[400]
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        options[index][AppStrings.icon],
                        color: isSelected ? AppTheme.black : AppTheme.white,
                      ),
                      if (widget.isExpanded) ...[
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            options[index][AppStrings.title],
                            style: TextStyle(
                              color:
                                  isSelected ? AppTheme.black : AppTheme.white,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
