// class _MyAuthPageState extends State<MyAuthPage> {
//   // name
//   String newUserName = "";
//   // Email
//   String newUserEmail = "";
//   // password
//   String newUserPassword = "";
//   // input Email
//   String loginUserEmail = "";
//   // input password
//   String loginUserPassword = "";
//   // information
//   String infoText = "";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           padding: EdgeInsets.all(32),
//           child: Column(
//             children: <Widget>[
//               TextFormField(
//                 //テキストの入力のラベルを設定
//                 decoration: InputDecoration(labelText: "なまえ"),
//                 onChanged: (String value) {
//                   setState(() {
//                     newUserName = value;
//                   });
//                 },
//               ),
//               TextFormField(
//                 //テキストの入力のラベルを設定
//                 decoration: InputDecoration(labelText: "メールアドレス"),
//                 onChanged: (String value) {
//                   setState(() {
//                     newUserEmail = value;
//                   });
//                 },
//               ),
//               const SizedBox(height: 8),
//               TextFormField(
//                 decoration: InputDecoration(labelText: "パスワード(6文字以上)"),
//                 // パスワードが見えないようにする
//                 obscureText: true,
//                 onChanged: (String value) {
//                   setState(() {
//                     newUserPassword = value;
//                   });
//                 },
//               ),
//               const SizedBox(height: 8),
//               ElevatedButton(
//                 onPressed: () async {
//                   try {
//                     // make user with mail&password
//                     final FirebaseAuth auth = FirebaseAuth.instance;
//                     final UserCredential result =
//                         await auth.createUserWithEmailAndPassword(
//                       email: newUserEmail,
//                       password: newUserPassword,
//                     );

//                     //fireStore docment作成
//                     await FirebaseFirestore.instance
//                         .collection('users')
//                         .add({'name': newUserName, 'email': newUserEmail})
//                         .then((value) => print("User Added"))
//                         .catchError(
//                             (error) => print("Failed to add user: $error"));

//                     // user info
//                     final User user = result.user!;
//                     setState(() {
//                       infoText = "登録OK:${user.email}";
//                     });
//                   } catch (e) {
//                     // 登録に失敗した場合
//                     setState(() {
//                       infoText = "登録NG:${e.toString()}";
//                     });
//                   }
//                 },
//                 child: Text("ユーザー登録"),
//               ),
//               const SizedBox(height: 32),
//               TextFormField(
//                 decoration: InputDecoration(labelText: "メールアドレス"),
//                 onChanged: (String value) {
//                   setState(() {
//                     loginUserEmail = value;
//                   });
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: '"パスワード'),
//                 obscureText: true,
//                 onChanged: (String value) {
//                   setState(() {
//                     loginUserPassword = value;
//                   });
//                 },
//               ),
//               const SizedBox(height: 8),
//               ElevatedButton(
//                 onPressed: () async {
//                   try {
//                     final FirebaseAuth auth = FirebaseAuth.instance;
//                     final UserCredential result =
//                         await auth.signInWithEmailAndPassword(
//                       email: loginUserEmail,
//                       password: loginUserPassword,
//                     );
//                     // success login
//                     final User user = result.user!;
//                     setState(() {
//                       infoText = "ログインOK:${user.email}";
//                     });
//                     Navigator.of(context)
//                         .push(MaterialPageRoute(builder: (context) {
//                       return MyHomePage(title: "天才");
//                     }));
//                   } catch (e) {
//                     // fail login
//                     setState(() {
//                       infoText = "ログインNG:${e.toString()}";
//                     });
//                   }
//                 },
//                 child: Text("ログイン"),
//               ),
//               const SizedBox(height: 8),
//               Text(infoText),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
