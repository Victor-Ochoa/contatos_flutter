import 'dart:io';

import 'package:contatos/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  final Contact contact;

  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

final _nameController = TextEditingController();
final _emailController = TextEditingController();
final _phoneController = TextEditingController();

final _nameFocus = FocusNode();

  Contact _editedContact;
  var _userEdit = false;

  @override
  void initState() {
    super.initState();

    _editedContact = widget.contact == null
        ? Contact()
        : Contact.fromMap(widget.contact.toMap());
    
    _nameController.text = _editedContact.name;
    _emailController.text = _editedContact.email;
    _phoneController.text = _editedContact.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editedContact.name ?? "Novo Contato"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(_editedContact.name == null || _editedContact.name.isEmpty){
            FocusScope.of(context).requestFocus(_nameFocus);
          }else{
            Navigator.pop(context, _editedContact);
          }
        },
        child: Icon(Icons.save),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            GestureDetector(
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: _editedContact.img != null
                            ? FileImage(File(_editedContact.img))
                            : AssetImage("images/person.png"))),
              ),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Nome"),
              controller: _nameController,
              focusNode: _nameFocus,
              onChanged: (text) {
                _userEdit = true;
                setState(() {
                  _editedContact.name = text;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: "E-mail"),
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              onChanged: (text) {
                _userEdit = true;
                _editedContact.email = text;
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: "Phone"),
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              onChanged: (text) {
                _userEdit = true;
                _editedContact.phone = text;
              },
            )
          ],
        ),
      ),
    );
  }
}