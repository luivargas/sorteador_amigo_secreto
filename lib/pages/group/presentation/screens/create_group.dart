import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/core/network/app_error.dart';
import 'package:sorteador_amigo_secreto/core/ui/alerts/app_alert.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_gradient_button.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/screen_padding.dart';
import 'package:sorteador_amigo_secreto/injector/injector.dart';
import 'package:sorteador_amigo_secreto/pages/auth/data/database/auth_db.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/create_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_state.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/navigation/show_group_args.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/create_form_group/group_form_field.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';
import 'package:sorteador_amigo_secreto/theme/flutter_theme.dart';
import 'package:sorteador_amigo_secreto/i18n/app_localizations.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _FormGroupBody();
}

class _FormGroupBody extends State<CreateGroup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController adminNameController = TextEditingController();
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController(
    text: getIt<AuthDB>().email,
  );
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
    final i18n = AppLocalizations.of(context)!;

    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: MyAppBar(),
        body: ScreenPadding(
          child: BlocConsumer<GroupCubit, GroupState>(
            listenWhen: (previous, current) =>
                previous.isLoading && !current.isLoading,
            listener: (context, state) async {
              if (state.created) {
                AppAlert.showBanner(
                  context,
                  message: i18n.groupCreatedSuccess(groupNameController.text),
                  type: AlertType.success,
                );
                if (context.mounted && state.createdGroup != null) {
                  context.pushReplacementNamed(
                    'view_group',
                    extra: ShowGroupArgs(
                      code: state.createdGroup!.code,
                      token: state.createdGroup!.token!,
                      name: state.createdGroup!.name,
                    ),
                  );
                }
              }
              if (state.error != null) {
                AppAlert.showBanner(
                  context,
                  message: state.error!.localize(context),
                  type: AlertType.warning,
                );
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  spacing: SecretSantaSpacing.md,
                  children: [
                    Column(
                      children: [
                        Text(
                          i18n.createGroupTitle,
                          style: SecretSantaTextStyles.titleMedium,
                        ),
                        Text(i18n.createGroupSubtitle, style: TextStyle()),
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
                      title: i18n.createGroupButton,
                      icon: Icons.save,
                      isLoading: state.isLoading,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
