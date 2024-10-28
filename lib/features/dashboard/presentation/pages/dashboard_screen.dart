import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:student_app_admin/core/app_core.dart';
import 'package:student_app_admin/core/responsive.dart';
import 'package:student_app_admin/features/dashboard/presentation/widget/sidebar_widget.dart';

@RoutePage()
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSidebarExpanded = true;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: !isDesktop ? _buildAppBar() : null,
      drawer: !isDesktop
          ? Drawer(
              child: SidebarWidget(
              isExpanded: true,
              onToggleExpand: () {},
            ))
          : null,
      body: Row(
        children: [
          if (isDesktop)
            SidebarWidget(
              isExpanded: isSidebarExpanded,
              onToggleExpand: _toggleSidebarExpansion,
            ),
          Expanded(
            flex: isDesktop ? 7 : 1,
            child: Column(
              children: [
                if (isDesktop) _buildAppBar(),
                _buildMainContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the main app bar with conditionally included sidebar toggle button.
  AppBar _buildAppBar() {
    final isDesktop = Responsive.isDesktop(context);
    return AppBar(
      leading: isDesktop
          ? IconButton(
              icon: Icon(isSidebarExpanded
                  ? Icons.arrow_back_ios
                  : Icons.arrow_forward_ios),
              onPressed: _toggleSidebarExpansion,
            )
          : IconButton(
              icon: const Icon(Icons.menu_rounded),
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),
      title: const Text(AppStrings.home),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Badge.count(
            count: 9999,
            child: const Icon(Icons.notifications_rounded),
          ),
        ),
        const SizedBox(width: 50),
        CircleAvatar(backgroundColor: Colors.red.withOpacity(0.5)),
      ],
    );
  }

  /// Toggles the sidebar expansion state.
  void _toggleSidebarExpansion() {
    setState(() {
      isSidebarExpanded = !isSidebarExpanded;
    });
  }

  /// Builds the main content area.
  Widget _buildMainContent() {
    return Expanded(
      child: Container(
        color: Colors.grey[100],
        child: const Center(child: Text("Main Content Area")),
      ),
    );
  }
}
