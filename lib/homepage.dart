import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoapp/models/todomodel.dart';
import 'package:todoapp/services/todoservice.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  final String?name;
  final String?email;
  final String?phone;
  const HomePage({Key? key,this.email,this.phone,this.name}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _subtitleController = TextEditingController();

  final _todokey = GlobalKey<FormState>();

  List<Map<String, dynamic>> todos = [];
  var uuid=Uuid();
  var todoid;

  getalldata() {
    List<Map<String, dynamic>> data = _todoService.getAllTodos();

    print(data);
    setState(() {
      todos.addAll(data);
    });
  }

  @override
  void initState() {

    getalldata();
    super.initState();
  }

  ToDoService _todoService = ToDoService();

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
         "Welcome ${widget.name}"
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Add To-Do"),
                  content: Container(
                    height: 200,
                    child: Form(
                      key: _todokey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _titleController,
                            decoration:
                                InputDecoration(hintText: "Enter Title"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter a valid title";
                              }
                            },
                          ),
                          TextFormField(
                            controller: _subtitleController,
                            decoration:
                                InputDecoration(hintText: "Enter Sub Title"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter a valid sub-title";
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {

                          if (_todokey.currentState!.validate()) {

                            todoid=uuid.v1();
                            print(todoid);
                            ToDoModel _todo = ToDoModel(
                              title: _titleController.text,
                              subtitle: _subtitleController.text,
                              id: todoid,
                            );

                            _todoService.crateTodo(_todo);





                            getalldata();
                            _subtitleController.text = "";
                            _titleController.text = "";
                            Navigator.pop(context);
                          }
                        },
                        child: Text("Save")),
                    ElevatedButton(
                        onPressed: () {
                          _subtitleController.text = "";
                          _titleController.text = "";
                        },
                        child: Text("Cancel"))
                  ],
                );
              });
        },
        child: FaIcon(FontAwesomeIcons.plus),
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child:FutureBuilder(

          future: FirebaseFirestore.instance.collection('todos').get(),
            builder: (context, snapshot){
              if(snapshot.hasData && snapshot.data!.docs.length==0){

                return Center(
                  child: Text("No todos"),
                );

              }

              if(snapshot.hasData){
                return  ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {

                      return ListTile(
                          leading:
                          CircleAvatar(child: FaIcon(FontAwesomeIcons.check)),
                          title: Text(snapshot.data!.docs[index]['title']),
                          subtitle: Text(snapshot.data!.docs[index]['subtitle']),
                          trailing: IconButton(
                            onPressed: () {
                              _todoService.deleteTodo(index);
                              getalldata();
                            },
                            icon: FaIcon(FontAwesomeIcons.trash),
                          ));


                    });
              }

              if(snapshot.hasError){

                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );



            },

          )),
    );
  }
}
