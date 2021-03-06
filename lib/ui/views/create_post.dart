import 'package:flutter/material.dart';
import 'package:note_app/models/post.dart';
import 'package:note_app/viewmodels/post_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../locator.dart';
import '../widgets/app_text.dart';

class CreatePostView extends StatefulWidget {
  static const routName = "/createPost";
  const CreatePostView({Key? key}) : super(key: key);

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  Post? editingPost;
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostViewModel>.reactive(
      viewModelBuilder: () => locator<PostViewModel>(),
      onModelReady: (model) {
        _titleController.text = editingPost?.title ?? "";
        // _messageController.text = editingPost?.message ?? "";

        // model.setEdittingPost(editingPost!);
      },
      disposeViewModel: false,
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Add Post"),
            actions: [
              !model.isLogged
                  ? Container()
                  : IconButton(
                      onPressed: () {
                        model.logOut();
                      },
                      icon: const Icon(Icons.logout),
                    ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Hello : ${model.currentUser?.firstName}"),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter something';
                          }
                          return null;
                        },
                        controller: _titleController,
                        decoration: const InputDecoration(
                          hintText: "title",
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter something';
                          }
                          return null;
                        },
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: "message",
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 3,
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: MaterialButton(
                            child: model.isBusy
                                ? const CircularProgressIndicator(
                                    color: Colors.blue,
                                  )
                                : AppText.headingThree(
                                    "create post",
                                  ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                debugPrint("gone");

                                model.addPost(_titleController.text,
                                    _messageController.text);
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
