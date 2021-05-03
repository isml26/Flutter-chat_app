import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email,String password ,String username,bool isLogin,BuildContext ctx) submitFn;
  final bool isLoading;
  AuthForm(this.submitFn,this.isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail='';
  String _userName='';
  String _userPw='';
  void _trySubmit(){
    //triggers all the validater of the all the text form fields on the form
  final isValid=  _formKey.currentState.validate();
    //close the soft keyboard which might be be open as soon as we submit the form
  FocusScope.of(context).unfocus();
  if(isValid){
    //go to all text form fields  trigger on saved
    _formKey.currentState.save();
    widget.submitFn(
      _userEmail.trim(),
      _userPw.trim(),
      _userName.trim(),
      _isLogin,
      //we are passing context because auth form is the context that actually has accces to the
      //surrounding scaffold which intern is the context where the scaffold messenger should be mounted on
      context,
    );
  }
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key:_formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        //if(!_isLogin)UserImagePicker(),
                        TextFormField(
                          key: ValueKey('email'),
                          validator: (value){
                            if(value.isEmpty || !value.contains('@'))
                              return 'Please enter valid email address';
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(labelText: 'Email address'
                          ),
                          onSaved: (value){
                            _userEmail = value;
                          },
                        ),
                        if(!_isLogin)
                        TextFormField( 
                          key: ValueKey('username'),
                          validator: (value){
                            if(value.isEmpty || value.length<4)
                              return 'Please enter at leat 4 characters';
                            return null;     
                          },
                          decoration: InputDecoration(labelText: 'Username'),
                          onSaved: (value){
                            _userName = value;
                          },
                        ),
                        TextFormField(
                          key: ValueKey('password'),
                            validator: (value){
                            if(value.isEmpty || value.length<7)
                              return 'Pw must be at lest 7 characters long.';
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          onSaved: (value){
                            _userPw = value;
                          },
                        ),
                        SizedBox(height:12),
                        if(widget.isLoading)
                          CircularProgressIndicator(),
                        if(!widget.isLoading)
                        ElevatedButton(onPressed: _trySubmit, child: Text(_isLogin ? 'Login': 'SignUp')),
                        if(!widget.isLoading)
                        TextButton(onPressed: (){
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        }, child: Text(_isLogin ? 'Create new account':'I already have an account'))
                      ],
                    ),
                  )))),
    );
  }
}
