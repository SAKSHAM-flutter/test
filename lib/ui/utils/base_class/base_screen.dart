import 'package:flutter/material.dart';
import 'package:interview_task/ui/utils/base_class/view_model.dart';
import 'package:interview_task/ui/utils/loading.dart';
import 'package:interview_task/ui/utils/toasts.dart';

class ScreenBase<VIEW_MODEL extends ViewModel> extends StatefulWidget {
  final Widget child;
  final ValueChanged<String>? onError;

  const ScreenBase({
    Key? key,
    required this.child,
    this.onError,
  }) : super(key: key);

  @override
  State<ScreenBase<VIEW_MODEL>> createState() => _ScreenBaseState<VIEW_MODEL>();
}

class _ScreenBaseState<VIEW_MODEL extends ViewModel>
    extends State<ScreenBase<VIEW_MODEL>> {
  @override
  void initState() {
    withViewModel<VIEW_MODEL>(context, (viewModel) {
      viewModel.onError = (String? errorMessage) {
        if (errorMessage == null) return;
        if (widget.onError == null) {
          errorToast(errorMessage);
        } else {
          widget.onError?.call(errorMessage);
        }
      };
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          widget.child,
          LoadingIndicatorConsumer<VIEW_MODEL>(),
        ],
      ),
    );
  }
}

class ScreenBaseScaffold<VIEW_MODEL extends ViewModel> extends StatelessWidget {
  final Widget child;
  final Widget? bottom;

  const ScreenBaseScaffold({Key? key, required this.child, this.bottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenBase<VIEW_MODEL>(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: child,
        bottomSheet: bottom,
      ),
    );
  }
}
