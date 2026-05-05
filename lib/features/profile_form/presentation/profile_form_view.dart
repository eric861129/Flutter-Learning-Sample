import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/profile_form_data.dart';
import 'profile_form_validators.dart';
import 'profile_form_view_model.dart';

/// 表單與驗證範例頁。
///
/// 這個頁面示範 Flutter 表單常見流程：
/// Form -> TextFormField -> validator -> submit loading -> error display。
class ProfileFormView extends ConsumerStatefulWidget {
  const ProfileFormView({super.key});

  @override
  ConsumerState<ProfileFormView> createState() => _ProfileFormViewState();
}

class _ProfileFormViewState extends ConsumerState<ProfileFormView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _bioController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final submissionState = ref.watch(profileFormViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('表單與驗證')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              key: const Key('profile_name_field'),
              controller: _nameController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: '姓名',
                prefixIcon: Icon(Icons.person_outline),
              ),
              validator: ProfileFormValidators.name,
            ),
            const SizedBox(height: 16),
            TextFormField(
              key: const Key('profile_email_field'),
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              validator: ProfileFormValidators.email,
            ),
            const SizedBox(height: 16),
            TextFormField(
              key: const Key('profile_password_field'),
              controller: _passwordController,
              obscureText: true,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: '密碼',
                prefixIcon: Icon(Icons.lock_outline),
              ),
              validator: ProfileFormValidators.password,
            ),
            const SizedBox(height: 16),
            TextFormField(
              key: const Key('profile_bio_field'),
              controller: _bioController,
              minLines: 3,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: '個人簡介',
                alignLabelWithHint: true,
              ),
            ),
            if (submissionState.errorMessage != null) ...[
              const SizedBox(height: 16),
              _ErrorDisplay(message: submissionState.errorMessage!),
            ],
            const SizedBox(height: 24),
            FilledButton(
              onPressed: submissionState.isSubmitting ? null : _submit,
              child: submissionState.isSubmitting
                  ? const Text('送出中...')
                  : const Text('送出'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final formState = _formKey.currentState;
    if (formState == null || !formState.validate()) {
      return;
    }

    final data = ProfileFormData(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      bio: _bioController.text.trim(),
    );

    await ref.read(profileFormViewModelProvider.notifier).submit(data);

    final state = ref.read(profileFormViewModelProvider);
    if (!mounted || !state.isSuccess) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('表單已送出')),
    );
  }
}

/// 表單送出失敗時的錯誤顯示區塊。
///
/// 錯誤訊息不要只放在 console；使用者需要在畫面上知道發生什麼事。
class _ErrorDisplay extends StatelessWidget {
  const _ErrorDisplay({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          message,
          style: TextStyle(color: theme.colorScheme.onErrorContainer),
        ),
      ),
    );
  }
}
