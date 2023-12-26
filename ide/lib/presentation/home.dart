import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ide/domain/fetch/cubit/fetch_cubit.dart';
import 'package:ide/domain/shared/shared_cubit.dart';
import 'package:ide/external/share.dart';
import 'package:ide/presentation/login_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final nameControllers = TextEditingController();
  void getUsers() {
    context.read<FetchCubit>().fetchData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 1.3;
    final double itemWidth = size.width / 1.6;
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        centerTitle: true,
        title: InkWell(
            onTap: () {
              Shared.removeUser();
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (c) {
                return LoginPage();
              }), (route) => false);
            },
            child: Text(
              "IDE",
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30),
            )),
        elevation: 0,
        backgroundColor: Colors.grey.shade50,
        actions: [
          IconButton(
              onPressed: () {
                Shared.removeUser();
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (c) {
                  return LoginPage();
                }), (route) => false);
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ))
        ],
      ),
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Builder(builder: (context) {
                          final state = context.watch<SharedCubit>().state;
                          return Text(
                            state is LoggeIn
                                ? "Halo, ${state.userModel?.name}"
                                : "",
                            style: TextStyle(
                                fontSize: 20, color: Colors.grey.shade700),
                          );
                        }),
                        Text(
                          'What are you looking for today?',
                          style: TextStyle(
                              fontSize: 33, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Builder(builder: (context) {
              final state = context.watch<FetchCubit>().state;
              return state is FetchLoading
                  ? SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                  : state is FetchSuccess
                      ? SliverToBoxAdapter(
                        child: CarouselSlider(
                                options: CarouselOptions(
                                  height: 150.0,
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  viewportFraction: 0.8,
                                  aspectRatio: 2.0,
                                ),
                                items: state.modelData.map((url) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          image: DecorationImage(
                                            fit: BoxFit.contain,
                                            image: NetworkImage(
                                                url.bannerImage ?? ""),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                      ):Container();
            }),
            Builder(builder: (context) {
              final state = context.watch<FetchCubit>().state;
              return state is FetchLoading
                  ? SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()))
                  : state is FetchSuccess
                      ? SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: (itemWidth / itemHeight),
                                  mainAxisSpacing: 10),
                          delegate: SliverChildBuilderDelegate(
                            childCount: state.modelData.length,
                            (context, index) {
                              return Container(
                                  margin: EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade200,
                                          offset: Offset(1, 3))
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 200,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              fit: BoxFit.contain,
                                              image: NetworkImage(state
                                                      .modelData[index]
                                                      .bannerImage ??
                                                  ''),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.modelData[index]
                                                    .bannerName!,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                            },
                          ),
                        )
                      : Container();
            })
          ],
        ),
      ),
    );
  }
}

// Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Builder(builder: (context) {
//                           final state = context.watch<SharedCubit>().state;
//                           return Text(
//                             state is LoggeIn
//                                 ? "Halo, ${state.userModel?.name}"
//                                 : "",
//                             style: TextStyle(
//                                 fontSize: 20, color: Colors.grey.shade700),
//                           );
//                         }),
//                         Text(
//                           'What are you looking for today?',
//                           style: TextStyle(
//                               fontSize: 33, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                   state is FetchLoading
//                       ? Center(
//                           child: CircularProgressIndicator(),
//                         )
//                       : state is FetchSuccess
//                           ? CarouselSlider(
//                               options: CarouselOptions(
//                                 height: 150.0,
//                                 autoPlay: true,
//                                 enlargeCenterPage: true,
//                                 viewportFraction: 0.8,
//                                 aspectRatio: 2.0,
//                               ),
//                               items: state.modelData.map((url) {
//                                 return Builder(
//                                   builder: (BuildContext context) {
//                                     return Container(
//                                       width: MediaQuery.of(context).size.width,
//                                       margin:
//                                           EdgeInsets.symmetric(horizontal: 5.0),
//                                       decoration: BoxDecoration(
//                                         borderRadius:
//                                             BorderRadius.circular(8.0),
//                                         image: DecorationImage(
//                                           fit: BoxFit.contain,
//                                           image: NetworkImage(
//                                               url.bannerImage ?? ""),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 );
//                               }).toList(),
//                             )
//                           : Center(child: Text('Ada Masalah')),
