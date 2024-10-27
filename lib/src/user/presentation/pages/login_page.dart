import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/gen/assets.gen.dart';
import 'package:food_recipe/src/core/router/login_route.dart';
import 'package:food_recipe/src/core/router/recipe_route.dart';
import 'package:food_recipe/src/core/utils/styles/styles.dart';
import 'package:food_recipe/src/recipe/presentation/widgets/textform_field.dart';
import 'package:food_recipe/src/user/presentation/blocs/authentication/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _fullNameController = TextEditingController();

  // ValueNotifier to track if we're in signup mode
  final ValueNotifier<bool> _isSignUpMode = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _fullNameController.dispose();
    _isSignUpMode.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    return null;
  }

  String? _validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    if (value.length < 2) {
      return 'Please enter a valid full name';
    }
    return null;
  }

  void _handleSubmit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      if (_isSignUpMode.value) {
        context.read<AuthBloc>().add(
              SignUpEvent(
                email: _emailController.text,
                password: _passwordController.text,
                username: _usernameController.text,
                fullName: _fullNameController.text,
              ),
            );
      } else {
        context.read<AuthBloc>().add(
              LoginEvent(
                email: _emailController.text,
                password: _passwordController.text,
              ),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          authenticated: (user) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RecipeRoute.routeRecipe,
              (Route<dynamic> route) => false,
            );
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return Scaffold(
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.55,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(30),
                          ),
                          child: Image.asset(
                            Assets.lib.src.core.images.breakfast.path,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                          alignment: const Alignment(0.0, 0.7),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              'Delicious Recipes at Your Fingertips',
                              style:
                                  TextStyleShared.textStyle.bodyMedium.copyWith(
                                fontSize: 28,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    offset: const Offset(2.0, 2.0),
                                    blurRadius: 3.0,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              'Explore more than 15,000 Food Recipes that fit your diet and lifestyle!',
                              style:
                                  TextStyleShared.textStyle.bodyMedium.copyWith(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    offset: const Offset(2.0, 2.0),
                                    blurRadius: 3.0,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ValueListenableBuilder<bool>(
                      valueListenable: _isSignUpMode,
                      builder: (context, isSignUp, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 10),
                            if (isSignUp) ...[
                              CustomTextFormField(
                                controller: _usernameController,
                                title: 'Username',
                                hintText: 'Enter your username',
                                validator: _validateUsername,
                                textStyleTitle: TextStyleShared
                                    .textStyle.subtitle
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              CustomTextFormField(
                                controller: _fullNameController,
                                title: 'Full Name',
                                hintText: 'Enter your full name',
                                validator: _validateFullName,
                                textStyleTitle: TextStyleShared
                                    .textStyle.subtitle
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                            ],
                            CustomTextFormField(
                              controller: _emailController,
                              title: 'Email',
                              hintText: 'Enter your email',
                              validator: _validateEmail,
                              keyboardType: TextInputType.emailAddress,
                              textStyleTitle: TextStyleShared.textStyle.subtitle
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            CustomTextFormField(
                              controller: _passwordController,
                              title: 'Password',
                              hintText: 'Enter your password',
                              validator: _validatePassword,
                              textStyleTitle: TextStyleShared.textStyle.subtitle
                                  .copyWith(fontWeight: FontWeight.w500),
                              obscureText: true,
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => _handleSubmit(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  isSignUp ? 'Sign Up' : 'Get Started',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                _formKey.currentState?.reset();
                                _isSignUpMode.value = !_isSignUpMode.value;
                              },
                              child: Text.rich(
                                TextSpan(
                                  text: isSignUp
                                      ? 'Already have an account? '
                                      : 'Do not have an account? ',
                                  style: const TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: isSignUp ? 'Login' : 'Sign Up',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
