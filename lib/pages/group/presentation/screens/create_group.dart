import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:sorteador_amigo_secreto/core/ui/app_bar/my_app_bar.dart';
import 'package:sorteador_amigo_secreto/core/ui/components/my_gradient_button.dart';
import 'package:sorteador_amigo_secreto/pages/group/domain/entities/create_group_entity.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_cubit.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/cubit/group_state.dart';
import 'package:sorteador_amigo_secreto/pages/group/presentation/widgets/create_form_group/group_form_field.dart';
import 'package:sorteador_amigo_secreto/pages/participant/domain/entities/create_participant_entity.dart';
import 'package:sorteador_amigo_secreto/theme/my_theme.dart';
import 'package:sorteador_amigo_secreto/l10n/app_localizations.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _FormGroupBody();
}

class _FormGroupBody extends State<CreateGroup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final PhoneController phoneController = PhoneController(
    initialValue: PhoneNumber(isoCode: IsoCode.BR, nsn: ''),
  );
  void _onSubmit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    _formKey.currentState?.save();

    final entity = CreateGroupEntity(
      name: groupNameController.text,

      admin: CreateParticipantEntity(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.value.international,
        idd: phoneController.value.countryCode,
      ),
    );
    context.read<GroupCubit>().create(entity);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: MyAppBar(title: AppLocalizations.of(context)!.createGroupTitle, subTitle: AppLocalizations.of(context)!.createGroupSubtitle,),
        body: BlocConsumer<GroupCubit, GroupState>(
          listenWhen: (previous, current) =>
              previous.isLoading &&
              !current.isLoading &&
              current.created,
          listener: (context, state) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  AppLocalizations.of(context)!.groupCreatedSuccess(groupNameController.text),
                ),
                showCloseIcon: true,
              ),
            );
            context.pop(true);
          },
          builder: (context, state) {
            if (state.isLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: myProgressIndicator.color,
                ),
              );
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20, 40),
                child: Column(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GroupFormFields(
                      groupNameController: groupNameController,
                      nameController: nameController,
                      emailController: emailController,
                      phoneController: phoneController,
                    ),
                    MyGradientButton(
                      onTap: _onSubmit,
                      title: AppLocalizations.of(context)!.createGroupButton,
                      icon: Icons.create,
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
