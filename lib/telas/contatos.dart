import 'package:flutter/material.dart';

class Contact {
  String nome;
  String telefone;
  String endereco;

  Contact({required this.nome, required this.telefone, required this.endereco});
}

class Contatos extends StatefulWidget {
  @override
  _ContatosState createState() => _ContatosState();
}

class _ContatosState extends State<Contatos> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _enderecoController = TextEditingController();
  List<Contact> _contacts = [];

  @override
  void dispose() {
    _nomeController.dispose();
    _telefoneController.dispose();
    _enderecoController.dispose();
    super.dispose();
  }

  void _addContact() {
    if (_formKey.currentState!.validate()) {
      Contact newContact = Contact(
        nome: _nomeController.text,
        telefone: _telefoneController.text,
        endereco: _enderecoController.text,
      );
      setState(() {
        _contacts.add(newContact);
      });
      _formKey.currentState?.reset();
    }
  }

  void _editContact(Contact contact) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Contato'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: TextEditingController(text: contact.nome),
                decoration: InputDecoration(labelText: 'Nome'),
                onChanged: (value) {
                  contact.nome = value;
                },
              ),
              TextFormField(
                controller: TextEditingController(text: contact.telefone),
                decoration: InputDecoration(labelText: 'Telefone'),
                onChanged: (value) {
                  contact.telefone = value;
                },
              ),
              TextFormField(
                controller: TextEditingController(text: contact.endereco),
                decoration: InputDecoration(labelText: 'Endereço'),
                onChanged: (value) {
                  contact.endereco = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Salvar'),
              onPressed: () {
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteContact(Contact contact) {
    setState(() {
      _contacts.remove(contact);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
      ),
      body: ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_contacts[index].nome),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(_contacts[index].telefone),
                Text(_contacts[index].endereco),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _editContact(_contacts[index]);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteContact(_contacts[index]);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Adicionar Contato'),
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        controller: _nomeController,
                        decoration: InputDecoration(labelText: 'Nome'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o nome';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _telefoneController,
                        decoration: InputDecoration(labelText: 'Telefone'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o telefone';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _enderecoController,
                        decoration: InputDecoration(labelText: 'Endereço'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o endereço';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Cancelar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Salvar'),
                    onPressed: () {
                      _addContact();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Agenda de Contatos',
    home: Contatos(),
  ));
}
