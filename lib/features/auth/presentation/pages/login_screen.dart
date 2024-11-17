import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:student_app_admin/core/app_core.dart';
import 'package:student_app_admin/core/extensions/extensions.dart';
import 'package:student_app_admin/core/responsive.dart';
import 'package:student_app_admin/core/routes/app_router.gr.dart';
import 'package:student_app_admin/core/theme/app_theme.dart';
import 'package:student_app_admin/core/utils/utils.dart';
import 'package:student_app_admin/features/auth/presentation/providers/auth_notifiers.dart';
import 'package:student_app_admin/features/auth/presentation/providers/auth_providers.dart';
import 'package:student_app_admin/features/widgets/primary_button.dart';
import 'package:student_app_admin/features/widgets/text_input_form_field.dart';
import 'package:student_app_admin/gen/assets.gen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod

@RoutePage()
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final ValueNotifier<bool> _passwordVisibility = ValueNotifier(true);
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    return Scaffold(
      backgroundColor: AppTheme.grey.withOpacity(0.2),
      body: Center(
        child: Container(
          height: !Responsive.isMobile(context) ? 90.h : 100.h,
          width: Responsive.isDesktop(context)
              ? 30.w
              : (Responsive.isMobile(context) ? 100.w : 70.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: AppTheme.white,
            boxShadow: const [BoxShadow(color: Colors.grey)],
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: !Responsive.isMobile(context) ? 2.h : 10.h,
                    ),
                    _buildLogo(),
                    const SizedBox(height: 10),
                    Text(AppStrings.login,
                        style: context.textTheme.displayMedium),
                    const SizedBox(height: 5),
                    Text(AppStrings.loginToContinue,
                        style: context.textTheme.labelSmall
                            ?.copyWith(color: AppTheme.grey)),
                    const SizedBox(height: 20),
                    _buildEmailField(),
                    const SizedBox(height: 20),
                    _buildPasswordField(authState),
                    const SizedBox(height: 5),
                    _buildForgotPasswordText(),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              _buildLoginButton(authState),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return SizedBox(
      height: 20.h,
      width: 80.w,
      child: Image.asset(Assets.images.illustration1.path),
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.email, style: context.textTheme.bodySmall),
        const SizedBox(height: 5),
        TextInputFormField(
            controller: _emailController,
            focusNode: _emailFocusNode,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
            validator: AppUtils.emailValidator),
      ],
    );
  }

  Widget _buildPasswordField(AuthState authState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.password, style: context.textTheme.bodySmall),
        const SizedBox(height: 5),
        ValueListenableBuilder<bool>(
          valueListenable: _passwordVisibility,
          builder: (context, isVisible, child) {
            return TextInputFormField(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                onFieldSubmitted: (_) => _signIn(authState),
                textInputAction: TextInputAction.done,
                isPasswordVisible: isVisible,
                maxLines: 1,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                suffixIcon: IconButton(
                  onPressed: () => _passwordVisibility.value = !isVisible,
                  icon:
                      Icon(isVisible ? Icons.visibility : Icons.visibility_off),
                ),
                validator: AppUtils.passWordValidator);
          },
        ),
      ],
    );
  }

  Widget _buildForgotPasswordText() {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {},
        // AutoRouter.of(context).pushNamed("/${ForgotPasswordRoute.name}"),
        child: Text(
          AppStrings.forgotPassword,
          style: context.textTheme.labelSmall,
          textAlign: TextAlign.end,
        ),
      ),
    );
  }

  Widget _buildLoginButton(AuthState authState) {
    return Consumer(
      builder: (context, ref, child) {
        log("auth State is Logged in=> ${authState.isLoggedIn}");
        if (authState.isLoggedIn) {
          AutoRouter.of(context).replaceAll([const DashboardRoute()]);
        }
        return child!;
      },
      child: SizedBox(
        height: 50,
        width: 100.w,
        child: authState.isLoading
            ? const Center(
                child: CircularProgressIndicator()) // Show loading spinner
            : PrimaryButton(
                label: AppStrings.login,
                onTap: () => _signIn(authState),
              ),
      ),
    );
  }

  void _signIn(AuthState authState) {
    if (_formKey.currentState!.validate()) {
      final authenticationProvider = ref.read(authProvider.notifier);
      authenticationProvider.signIn(
        _emailController.text,
        _passwordController.text,
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordVisibility.dispose();
    super.dispose();
  }
}
