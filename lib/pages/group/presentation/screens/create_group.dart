import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/core/network/app_error.dart';
import 'package:sorteador_amigo_secreto/core/ui/alerts/alert.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_gradient_button.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/database/auth_db.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/create_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_state.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/create_form_group/group_form_field.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _FormGroupBody();
}

class _FormGroupBody extends State<CreateGroup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController adminNameController = TextEditingController();
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController( text: getIt<AuthDB>().email);
  final PhoneController phoneController = PhoneController(
    initialValue: PhoneNumber(isoCode: IsoCode.BR, nsn: ''),
  );
  void _onSubmit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    _formKey.currentState?.save();

    final entity = CreateGroupEntity(
      name: groupNameController.text,

      admin: CreateParticipantEntity(
        name: adminNameController.text,
        email: emailController.text,
        phone: phoneController.value.international,
        idd: phoneController.value.countryCode,
      ),
    );
    await context.read<GroupCubit>().create(entity);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: MyAppBar(),
        body: BlocConsumer<GroupCubit, GroupState>(
          listenWhen: (previous, current) =>
              previous.isLoading && !current.isLoading && current.created,
          listener: (context, state) async {
            if (state.created) {
              SecretSantaAlert.show(
                message: l10n.groupCreatedSuccess(groupNameController.text),
                type: AlertType.success,
                context: context,
              );
              if (context.mounted) {
                context.pop(true);
              }
            }
            if (state.error != null) {
              SecretSantaAlert.show(
                context: context,
                message: state.error!.localize(context),
                type: AlertType.warning,
              );
            }
          },
          builder: (context, state) {
            if (state.isLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: SecretSantaColors.accent,
                ),
              );
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20, 50),
                child: Column(
                  spacing: 30,
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: SecretSantaColors.neutral50,
                            border: Border.all(
                              color: SecretSantaColors.accent2.withValues(
                                alpha: 0.3,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(Icons.group, size: 40),
                          ),
                        ),
                        Text(
                          l10n.createGroupTitle,
                          style: SecretSantaTextStyles.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          l10n.createGroupSubtitle,
                          style: TextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    GroupFormFields(
                      groupNameController: groupNameController,
                      nameController: adminNameController,
                      emailController: emailController,
                      phoneController: phoneController,
                    ),
                    MyGradientButton(
                      onTap: _onSubmit,
                      title: l10n.createGroupButton,
                      icon: Icons.save,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
