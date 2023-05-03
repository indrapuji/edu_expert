import 'package:dio/dio.dart';
import 'package:edu_expert/data/datasource/book_remote.datasource.dart';
import 'package:edu_expert/domain/use_case/get_book_use_case.dart';
import 'package:edu_expert/presentation/screens/home/home_controller.dart';
import 'package:edu_expert/presentation/screens/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repository/book_repository_impl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

var _controller = TextEditingController();

class _HomePageState extends State<HomePage> {
  bool _btnActive = true;

  final controller = HomeController(
    GetBookUseCase(
      BookRepositoryImpl(
        BookRemoteDatasource(Dio()),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Hai, Indra!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Selamat Datang',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfilePage(),
                          ));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.all(10),
                        child: const Tooltip(
                          message: 'Press to see profile',
                          child: Icon(
                            Icons.account_circle,
                            size: 24,
                            color: Colors.white,
                          ),
                        )),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              TextField(
                controller: _controller,
                onChanged: (value) {
                  setState(() {
                    _btnActive = value.isEmpty ? true : false;
                  });
                },
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _btnActive
                        ? null
                        : IconButton(
                            onPressed: _controller.clear,
                            icon: const Icon(
                              Icons.check,
                            ),
                          ),
                    hintText: "Search"),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Column(
                    children: const [
                      Text(
                        "Books List",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                  child: GetBuilder<HomeController>(
                      init: controller,
                      initState: (state) => controller.getBook(),
                      builder: (context) {
                        return ListView.separated(
                            itemCount: controller.books.value.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 8),
                            itemBuilder: (context, index) {
                              final book = controller.books.value[index];
                              return Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          book.title ?? 'No Title',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          book.subtitle ?? 'No Title',
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            });
                      }))
            ],
          ),
        ),
      ),

      // ListView.separated(
      //       itemCount: 100,
      //       padding: const EdgeInsets.all(16),
      //       separatorBuilder: (context, index) => const SizedBox(height: 8),
      //       itemBuilder: (context, index) {
      //         return Row(
      //           children: [
      //             Container(
      //               height: 50,
      //               width: 50,
      //               color: Colors.red,
      //             ),
      //             const SizedBox(width: 8),
      //             Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: const [
      //                 Text(
      //                   "lorem ipsum",
      //                   style: TextStyle(
      //                       fontWeight: FontWeight.w600, fontSize: 18),
      //                 ),
      //                 Text('Lorem Ipsum Subtitle'),
      //               ],
      //             )
      //           ],
      //         );
      //       })
    );
  }
}
