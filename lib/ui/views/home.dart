import 'package:flutter/material.dart';
import 'package:note_app/ui/shared/app_colors.dart';
import 'package:note_app/viewmodels/home_view_model.dart';
import 'package:stacked/stacked.dart';

class PostHomeView extends StatelessWidget {
  static const routName = "/posthome";

  const PostHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Post? post;

    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (model) => model.listenToPosts(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
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
              body: Column(
                children: [
                  model.post != null
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: model.post!.length,
                          itemBuilder: ((context, index) => GestureDetector(
                                onTap: () {
                                  debugPrint("Tapped ${index + 1}");
                                  model.deletePost(index);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: primaryColor),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          // Text(post!.title)
                                          Text(
                                              "Posts title:  ${model.post![index].title}"),
                                          Text(
                                              "Posts message:  ${model.post![index].message}"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )))
                      : const CircularProgressIndicator()
                ],
              ),
            ));
  }
}
