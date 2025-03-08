part of login_library;

class Login extends WidgetView<Login, LoginControllerState> {
  const Login(super.controllerState, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        builder: (BuildContext context, state) {
          if (state is LoginLoading) {
            return Container(
              margin: EdgeInsets.all(100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(
                      color: Colors.teal,
                    ),
                  )
                ],
              ),
            );
          } else if (state is LoginInitial) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.fromLTRB(10, 100, 10, 10),
                    child: Column(
                      children: [
                        Form(
                          key: controllerState.loginFormKey,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Login",
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                              const SizedBox(height: 50),
                              TextFormField(
                                controller: controllerState.emailController,
                                decoration: const InputDecoration(
                                  labelText: "Email",
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.email),
                                ),
                                validator: (value) {
                                  final trimmedValue = value?.trim() ?? '';
                                  if (trimmedValue.isEmpty) {
                                    return 'Email is required';
                                  } else if (!MyValidator.isValidEmail(
                                      trimmedValue)) {
                                    return 'Invalid email or mobile number';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 30), // Add spacing
                              TextFormField(
                                controller: controllerState.passwordController,
                                obscureText: controllerState.isPasswordHidden,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      controllerState.changePasswordHidden();
                                    },
                                    child: Icon(
                                      controllerState.isPasswordHidden
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  final trimmedValue = value?.trim() ?? '';
                                  if (trimmedValue.isEmpty) {
                                    return 'Password is required';
                                  } else if (!MyValidator.isValidPassword(
                                      trimmedValue)) {
                                    return 'Incorrect Password';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 30), // Add spacing
                              SizedBox(
                                width: 150,
                                child: ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<LoginBloc>(context)
                                        .add(LoginButtonClicked());
                                    controllerState.loginToApp();
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't Have an account?",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(fontSize: 18),
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [
                      Text("Powered By Shiwkesh Schematics Private Limited"),
                      Text("All Rights Reserved"),
                      Text('version: ${controllerState.appVersion ?? '1.0.0'}')
                    ],
                  )
                ],
              ),
            );
          } else {
            return Container();
          }
        },
        listener: (BuildContext context, Object? state) {
          if (state is LoginSuccess) {
            controllerState.handleApiResponse(context, state);
          }
        },
      ),
    );
  }
}
