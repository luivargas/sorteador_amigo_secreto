

import 'package:sorteador_amigo_secreto/core/network/app_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/alerts/app_alert.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/app_list_card.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_botton_sheet.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_gradient_button.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/screen_padding.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/database/auth_db.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/loading_or_error.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/session/group_session.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/update_participant_entity.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/participant/presentation/cubit/participant_state.dart';
import 'package:sorteador_amigo_secreto/pages/participant/widgets/view_participant_form_fields.dart';
import 'package:sorteador_amigo_secreto/i18n/app_localizations.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';

class ViewParticipant extends StatefulWidget {
  final String userId;

  const ViewParticipant({super.key, required this.userId});

  @override
  State<ViewParticipant> createState() => _ViewParticipant();
}

class _ViewParticipant extends State<ViewParticipant> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final PhoneController _phoneController = PhoneController();
  final GlobalKey<FormState> _validateFormKey = GlobalKey<FormState>();
  bool _prefilledOnce = false;
  bool readOnly = false;
  String? role;
  bool _hasEmail = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _onResendEmail(BuildContext context) async {
    final i18n = AppLocalizations.of(context)!;

    if (_hasEmail == false) {
      await AppAlert.showAlertDialog(
        context,
        title: i18n.validatorInvalidEmail,
        message: i18n.resendEmailInvalid,
        actions: [
          TextButton(
            onPressed: () {
              context.pop(false);
            },
            child: Text(i18n.ok),
          ),
        ],
      );
      return;
    }
    if (context.mounted) {
      final confirmed = await AppAlert.showAlertDialog(
        context,
        title: i18n.resendEmail,
        message: i18n.resendEmailSubtitle,
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: Text(
              i18n.cancel,
              style: const TextStyle(color: SecretSantaColors.accent2),
            ),
          ),
          TextButton(
            onPressed: () => context.pop(true),
            child: Text(
              i18n.resendEmail,
              style: const TextStyle(color: SecretSantaColors.accent),
            ),
          ),
        ],
      );

      if (confirmed == true && context.mounted) {
        context.read<ParticipantCubit>().resendEmail(
          widget.userId,
          getIt<GroupSession>().token,
        );
      }
    }
  }

  Future<void> _onDelete(BuildContext context) async {
    final i18n = AppLocalizations.of(context)!;
    if (role == ParticipantRole.admin.name) {
      await AppAlert.showAlertDialog(
        context,
        title: i18n.adminCannotBeDeleted,
        message: i18n.adminCannotBeDeleted,
        actions: [
          TextButton(
            onPressed: () {
              context.pop(false);
            },
            child: Text(i18n.ok),
          ),
        ],
      );
      return;
    }

    if (context.mounted) {
      final confirmed = await AppAlert.showAlertDialog(
        context,
        title: i18n.delete,
        message: i18n.confirmDeleteParticipant(_nameController.text),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: Text(
              i18n.cancel,
              style: const TextStyle(color: SecretSantaColors.accent2),
            ),
          ),
          TextButton(
            onPressed: () => context.pop(true),
            child: Text(
              i18n.delete,
              style: const TextStyle(color: SecretSantaColors.accent),
            ),
          ),
        ],
      );

      if (confirmed == true && context.mounted) {
        context.read<ParticipantCubit>().delete(
          widget.userId,
          getIt<GroupSession>().token,
        );
      }
    }
  }

  void _prefillFromApi(ParticipantState state) {
    if (_prefilledOnce) return;
    if (state.showParti == null) return;
    final g = state.showParti!;

    _nameController.text = g.name;
    if (g.role == ParticipantRole.admin.name) {
      _emailController.text = getIt<AuthDB>().email ?? g.email ?? '';
    } else {
      _emailController.text = g.email ?? '';
    }
    final idd = g.idd ?? '';
    final rawPhone = g.phone ?? '';
    final fullPhone = idd.isNotEmpty && rawPhone.isNotEmpty
        ? '+$idd$rawPhone'
        : rawPhone;
    _phoneController.value = fullPhone.isNotEmpty
        ? PhoneNumber.parse(fullPhone)
        : const PhoneNumber(isoCode: IsoCode.BR, nsn: '');
    _prefilledOnce = true;
    role = g.role;
    if (g.email != null) {
      setState(() {
        _hasEmail = true;
      } );
    }
  }

  Future<void> _onSubmit() async {
    final formState = _validateFormKey.currentState;
    if (formState == null || !formState.validate()) return;

    setState(() {
      readOnly = true;
    });

    final entity = UpdateParticipantEntity(
      name: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.value.nsn,
      idd: _phoneController.value.countryCode,
      role: role,
    );
    await context.read<ParticipantCubit>().update(
      entity,
      widget.userId,
      getIt<GroupSession>().token,
    );
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: MyAppBar(
        actions: [
          IconButton(
            onPressed: () => MyBottonSheet.show(
              title: i18n.participantOptionsTitle,
              subTitle: i18n.participantOptionsSubtitle,
              context: context,
              items: [
                if (getIt<GroupSession>().isRaffled)
                  AppListCard(
                    title: i18n.resendEmail,
                    subtitle: i18n.resendEmailSubtitle,
                    color: SecretSantaColors.accent,
                    icon: Icons.email_rounded,
                    name: '',
                    trailing: Icon(
                      Icons.chevron_right,
                      color: SecretSantaColors.accent,
                    ),
                    onTap: () {
                      context.pop();
                      _onResendEmail(context);
                    },
                  ),
                if (!getIt<GroupSession>().isRaffled)
                  AppListCard(
                    title: i18n.deleteParticipant,
                    subtitle: i18n.deleteParticipantSubtitle,
                    color: SecretSantaColors.error,
                    icon: Icons.delete_outline,
                    name: '',
                    trailing: Icon(
                      Icons.chevron_right,
                      color: SecretSantaColors.error,
                    ),
                    onTap: () {
                      context.pop();
                      _onDelete(context);
                    },
                  ),
              ],
            ),
            icon: const Icon(Icons.more_vert, size: 24),
            color: SecretSantaColors.accent,
          ),
        ],
      ),
      body: ScreenPadding(
        child: Form(
          key: _validateFormKey,
          child: BlocConsumer<ParticipantCubit, ParticipantState>(
            listener: (context, state) {
              _prefillFromApi(state);
              if (state.error != null) {
                AppAlert.showBanner(
                  context,
                  message: state.error!.localize(context),
                  type: AlertType.warning,
                );
                setState(() {
                  readOnly = false;
                });
              }
              if (state.updated) {
                AppAlert.showBanner(
                  context,
                  message: i18n.participantUpdatedSuccess(_nameController.text),
                  type: AlertType.success,
                );
                if (context.mounted) {
                  context.pop(true);
                }
              }
              if (state.deleted) {
                AppAlert.showBanner(
                  context,
                  message: i18n.participantDeletedSuccess(_nameController.text),
                  type: AlertType.success,
                );
                if (context.mounted) {
                  context.pop(true);
                }
              }
              if (state.resended) {
                AppAlert.showBanner(
                  context,
                  message: i18n.resendEmailSuccess(_nameController.text),
                  type: AlertType.success,
                );
                if (context.mounted) {
                  context.pop(true);
                }
              }
            },
            buildWhen: (previous, current) =>
                previous.isLoading != current.isLoading ||
                previous.showed != current.showed ||
                previous.error != current.error,
            builder: (context, state) {
              return LoadingOrError(
                isLoading: state.isLoading && !state.showed,
                error: state.error,
                onRetry: () async => await context
                    .read<ParticipantCubit>()
                    .show(widget.userId, getIt<GroupSession>().token),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: SecretSantaSpacing.md,
                    children: [
                      Column(
                        children: [
                          Text(
                            i18n.participantTitle,
                            style: SecretSantaTextStyles.titleMedium,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            i18n.participantSubtitle,
                            style: TextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      ViewParticipantFormFields(
                        nameController: _nameController,
                        readOnly: readOnly,
                        phoneController: _phoneController,
                        emailController: _emailController,
                        participant: state.showParti,
                      ),
                      MyGradientButton(
                        onTap: _onSubmit,
                        title: i18n.save,
                        icon: Icons.save,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
