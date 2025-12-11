import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../core/network/api_client.dart';
import '../../data/datasources/auth_remote_datasource.dart';

class RegisterPage extends StatefulWidget{
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

//MArk :: Ini seperti SwiftUi atau JpackCompose pada Native Code
class _RegisterPageState extends State<RegisterPage> {
  final _form = GlobalKey<FormState>();
  String firstName = '';
  String lastName = '';
  String email = '';
  String username = '';
  String password = '';

  bool loading = false;
  String? error;

  Future<void> _register() async {
    setState(() {
      loading = true;
      error = null;
    });
    try {
      final api = ApiClient(client: http.Client(), baseUrl: 'https://dummyjson.com');
      final ds = AuthRemoteDatasource(api);
      await ds.register({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'username': username.isEmpty ? 'user${DateTime.now().millisecondsSinceEpoch}' : username,
        'password': password.isEmpty ? 'password' : password,
      });
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Register success — please login')));
      Navigator.pop(context);
    } catch (e) {
      setState(() {
        loading = false;
        error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            if (error != null) Text(error!, style: TextStyle(color: Colors.red)),
            Form(
              key: _form,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'First Name'),
                    onSaved: (v) => firstName = v?.trim() ?? '',
                    validator: (v) => (v?.isNotEmpty ?? false) ? null : 'Required',
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Last Name'),
                    onSaved: (v) => lastName = v?.trim() ?? '',
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email'),
                    onSaved: (v) => email = v?.trim() ?? '',
                    validator: (v) => (v?.contains('@') ?? false) ? null : 'Invalid email',
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Username'),
                    onSaved: (v) => username = v?.trim() ?? '',
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (v) => password = v ?? '',
                  ),
                  SizedBox(height: 16),
                  loading ? CircularProgressIndicator() : ElevatedButton(
                    onPressed: () {
                      if (!_form.currentState!.validate()) return;
                      _form.currentState!.save();
                      _register();
                    },
                    child: Text('Register'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}