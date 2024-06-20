import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/presentations/features/auth/widgets/navigation_bar/navigation_bar.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/skillux.dart';
import 'package:skilluxfrontendflutter/services/auh_services/controller/auth_register_controller.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    TextTheme textTheme = Theme.of(context).textTheme;
    final GetXAuthController _getXAuthController =
        Get.put(GetXAuthController());

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  alignment: const Alignment(0, 1),
                  child: const Skillux(heightDivider: 4, widthDivider: 2)),
              ListTile(
                title: Text(text.stayEngaged, style: textTheme.titleSmall),
                subtitle:
                    Text(text.participateActively, style: textTheme.bodySmall),
              ),
              Obx(
                () => _getXAuthController.isSuccess.value
                    ? Container(
                        color: Theme.of(context)
                            .primaryColor, // Set background color to primary color

                        child: ListTile(
                          title: Text(text.activateAccount,
                              style: textTheme.headlineSmall
                                  ?.copyWith(color: ColorsTheme.white)),
                          leading: const Icon(
                            Icons.info_outline,
                            color: ColorsTheme.white,
                          ),
                          subtitle: Text(text.emailMessage,
                              style: textTheme.bodySmall
                                  ?.copyWith(color: ColorsTheme.white)),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Obx(() => _getXAuthController.isLoading.value
                    ? const LinearProgressIndicator(
                        color: ColorsTheme.primary,
                      )
                    : const SizedBox.shrink()),
              ),
              const Expanded(child: TopNavigationBar())
            ],
          ),
        ),
      ),
    );
  }
}
