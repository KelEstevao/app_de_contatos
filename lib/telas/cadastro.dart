import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  String cpf;
  String nome;
  String nascimento;
  String email;
  String password;

  User({
    required this.cpf,
    required this.nome,
    required this.nascimento,
    required this.email,
    required this.password,
  });
}

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _cpfController = TextEditingController();
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _nascimentoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _registerUser(User user) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(user.cpf).set({
        'cpf': user.cpf,
        'nome': user.nome,
        'nascimento': user.nascimento,
        'email': user.email,
        'password': user.password,
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sucesso'),
            content: Text('Usuário cadastrado com sucesso!'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _cpfController.clear();
                  _nomeController.clear();
                  _nascimentoController.clear();
                  _emailController.clear();
                  _passwordController.clear();
                },
              ),
            ],
          );
        },
      );
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro'),
            content: Text('Ocorreu um erro ao cadastrar o usuário.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _cpfController.dispose();
    _nomeController.dispose();
    _nascimentoController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Usuário'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _cpfController,
                decoration: InputDecoration(labelText: 'CPF'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira o CPF';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nascimentoController,
                decoration: InputDecoration(labelText: 'Data de Nascimento'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira a data de nascimento';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'E-mail'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira o e-mail';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira a senha';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                child: Text('Cadastrar'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    User user = User(
                      cpf: _cpfController.text,
                      nome: _nomeController.text,
                      nascimento: _nascimentoController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    _registerUser(user);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'Cadastro de Usuário',
    home: Cadastro(),
  ));
}
