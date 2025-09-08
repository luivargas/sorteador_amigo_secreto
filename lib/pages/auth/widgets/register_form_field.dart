import 'package:flutter/material.dart';

class RegisterFormField extends StatefulWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;
  final dynamic validator;
  final dynamic passwordValidator;

  const RegisterFormField({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.passwordConfirmController,
    required this.validator,
    required this.passwordValidator,
  });

  @override
  State<RegisterFormField> createState() => _RegisterFormField();
}

class _RegisterFormField extends State<RegisterFormField> {
  var showPassword = true;
  var showConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nome'),
              TextFormField(
                controller: widget.firstNameController,
                validator: widget.validator,
                decoration: const InputDecoration(
                  hintText: 'Coloque aqui seu nome',
                  prefixIcon: Icon(Icons.abc),
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sobrenome'),
            TextFormField(
              controller: widget.lastNameController,
              validator: widget.validator,
              decoration: const InputDecoration(
                hintText: 'Coloque aqui seu sobrenome',
                prefixIcon: Icon(Icons.abc),
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('E-mail'),
            TextFormField(
              controller: widget.emailController,
              validator: widget.validator,
              decoration: const InputDecoration(
                hintText: 'Qual o seu e-mail?',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        // Column(
        //   spacing: 10,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text('Telefone'),
        //     TextFormField(
        //       controller: widget.phoneController,
        //       validator: widget.validator,
        //       decoration: const InputDecoration(
        //         hintText: 'Qual seu numero de telefone?',
        //         prefixIcon: Icon(Icons.phone),
        //         border: OutlineInputBorder(),
        //       ),
        //     ),
        //   ],
        // ),
        Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Senha'),
            TextFormField(
              obscureText: showPassword,
              controller: widget.passwordController,
              validator: widget.passwordValidator,
              decoration: InputDecoration(
                hintText: 'Escolha uma senha ',
                prefixIcon: const Icon(Icons.password),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(
                    showPassword ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
        Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Confirme sua senha'),
            TextFormField(
              obscureText: showConfirmPassword,
              controller: widget.passwordConfirmController,
              validator: widget.passwordValidator,
              decoration: InputDecoration(
                hintText: 'Confirme sua senha',
                prefixIcon: const Icon(Icons.password),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      showConfirmPassword = !showConfirmPassword;
                    });
                  },
                  icon: Icon(
                    showConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
