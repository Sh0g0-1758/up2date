import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up2date/components/all_news.dart';
import 'package:up2date/components/drawer.dart';
import 'package:up2date/components/breaking_news.dart';
import 'package:up2date/mainPage/bloc/main_page_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MainPage extends StatefulWidget {
  final String Title;
  MainPage({
    super.key,
    required this.Title,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final user = FirebaseAuth.instance.currentUser!;

  final MainPageBloc mainPageBloc = MainPageBloc();

  @override
  void initState() {
    mainPageBloc.add(NewsInitialFetchEvent(Title: widget.Title));
    super.initState();
  }

  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        actions: [
          IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))
        ],
        title: Text(
          user.email?.split("@").first ?? "User",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
      ),
      drawer: sidebar(),
      body: SingleChildScrollView(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 30.0),
                      child: Text(
                        widget.Title,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Top Headlines",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          BlocConsumer<MainPageBloc, MainPageState>(
            bloc: mainPageBloc,
            listenWhen: (previous, current) => current is MainPageActionState,
            buildWhen: (previous, current) => current is! MainPageActionState,
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              switch (state.runtimeType) {
                case NewsFetchingSuccessfulState:
                  final successState = state as NewsFetchingSuccessfulState;
                  return CarouselSlider.builder(
                      itemCount: successState.Headnews?.length,
                      itemBuilder: (BuildContext context, int index, id) =>
                          BreakingNewsCard(successState.Headnews![index]),
                      options: CarouselOptions(
                        aspectRatio: 16 / 9,
                        enableInfiniteScroll: false,
                        enlargeCenterPage: true,
                      ));
                default:
                  return const SizedBox(height: 30);
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Latest Headlines",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          BlocConsumer<MainPageBloc, MainPageState>(
            bloc: mainPageBloc,
            listenWhen: (previous, current) => current is MainPageActionState,
            buildWhen: (previous, current) => current is! MainPageActionState,
            listener: (context, state) {
            },
            builder: (context, state) {
              switch (state.runtimeType) {
                case NewsFetchingSuccessfulState:
                  final successState = state as NewsFetchingSuccessfulState;
                  return Column(
                      children: successState.news!
                          .map((e) => NewsListTile(e))
                          .toList());
                default:
                  return const SizedBox(
                    height: 30,
                  );
              }
            },
          ),
        ]),
      ),
    );
  }
}
