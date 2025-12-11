import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginPage extends StatefulWidget{
  @override
  State<LoginPage> createState() => _LoginPageState();
}

//MArk :: Ini seperti SwiftUi atau JpackCompose pada Native Code
class _LoginPageState extends State<LoginPage> {
  final _form = GlobalKey<FormState>();
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            if (auth.error != null) ...[
              Text(auth.error!, style: TextStyle(color: Colors.red)),
              SizedBox(height: 8),
            ],
            Form(
              key: _form,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Username (emilys for sample)'),
                    onSaved: (v) => username = v?.trim() ?? '',
                    validator: (v) => (v?.isNotEmpty ?? false) ? null : 'Required',
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password (emilyspass for sample)'),
                    obscureText: true,
                    onSaved: (v) => password = v ?? '',
                    validator: (v) => (v?.length ?? 0) >= 3 ? null : 'Min 3 chars',
                  ),
                  SizedBox(height: 16),
                  auth.loading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () async {
                            if (!_form.currentState!.validate()) return;
                            _form.currentState!.save();
                            final ok = await auth.login(username, password);
                            if (ok) {
                              Navigator.pushReplacementNamed(context, '/weather');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(auth.error ?? 'Login failed')));
                            }
                          },
                          child: Text('Login'),
                        ),
                  //Mark :: Comming Soon dikarenakan API DummyJSON
                  // TextButton(
                  //   onPressed: () => Navigator.pushNamed(context, '/register'),
                  //   child: Text('Register'),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}