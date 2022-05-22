import 'package:flutter/material.dart';
import 'package:note_app/models/post.dart';
import 'package:note_app/ui/shared/app_colors.dart';
import 'package:note_app/viewmodels/home_view_model.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  static const routName = "/home";

  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Post? post;

    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (model) => model.listenToPosts(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text("Your Post"),
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
              floatingActionButton: FloatingActionButton(
                onPressed: model.navigateToCreateView,
                child: const Icon(Icons.add),
              ),
              body: model.post != null
                  ? Column(
                      children: [
                        GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 3 / 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          shrinkWrap: true,
                          itemCount: model.post!.length,
                          itemBuilder: ((context, index) {
                            Post post = model.post![index];
                            return GestureDetector(
                              onTap: () {
                                debugPrint("Tapped ${index + 1}");
                                model.editPost(index);
                                // model.deletePost(index);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Dismissible(
                                  key: ValueKey<String?>(post.documentId),
                                  onDismissed: (direction) => {
                                    model.deletePost(index),
                                    debugPrint("deleted")
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: primaryColor),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Text(post!.title)
                                          Text(
                                            "Posts title:  \n${model.post![index].title}",
                                          ),
                                          Text(
                                            "Posts message: \n${model.post![index].message.substring(0, 5)}...",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        )
                      ],
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ));
  }
}
