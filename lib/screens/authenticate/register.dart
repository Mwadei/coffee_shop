import 'package:cofee_flutter/Services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _keyForm = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = '';
  String confirmPassword = '';

  //error message dialog
  void eMessage() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.primary,
        content: Text(
          'Please enter a valid Email',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        actions: [
          // okay button
          IconButton(
            onPressed: () {
              // pop once to remove dialog box
              Navigator.pop(context);
            },
            icon: Icon(Icons.done),
            color: Theme.of(context).colorScheme.secondary,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0.0,
        title: Text(
          "Sign Up",
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,

        //Sign In button
        actions: [
          TextButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: Icon(
              Icons.person_outlined,
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
            ),
            label: Text(
              "Sign In",
              style: TextStyle(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                  letterSpacing: 1),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _keyForm,
          child: Column(
            children: [
              SizedBox(height: 20),
              TextFormField(
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  border: InputBorder.none,
                  hintText: "E-mail",
                  hintStyle: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.8),
                  ),
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    size: 30,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.8),
                  ),
                ),
                validator: (value) => value!.isEmpty ? 'Enter an E-mail' : null,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  border: InputBorder.none,
                  hintText: "Password",
                  hintStyle: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.8),
                  ),
                  prefixIcon: Icon(
                    Icons.password,
                    size: 30,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.8),
                  ),
                ),
                obscureText: true,
                validator: (value) => value!.length < 6
                    ? 'Enter password above 6 characters'
                    : null,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  border: InputBorder.none,
                  hintText: "Confirm password",
                  hintStyle: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.8),
                  ),
                  prefixIcon: Icon(
                    Icons.password,
                    size: 30,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.8),
                  ),
                ),
                obscureText: true,
                validator: (value) =>
                    value != password ? 'Wrong confirmation password' : null,
                onChanged: (value) {
                  setState(() {
                    confirmPassword = value;
                  });
                },
              ),
              SizedBox(height: 20),
              Material(
                color: Color(0xFFE57734),
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  onTap: () async {
                    if (_keyForm.currentState!.validate()) {
                      if (confirmPassword == password) {
                        dynamic result = await _auth
                            .registerWithEmailAndPassword(email, password);
                        if (result == null) {
                          eMessage();
                        }
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
