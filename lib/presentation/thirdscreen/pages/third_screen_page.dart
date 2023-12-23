import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:suit_media_test/core/constraint/colors.dart';
import 'package:suit_media_test/data/models/user_model.dart';
import 'package:suit_media_test/presentation/thirdscreen/bloc/fetch_user/fetch_user_bloc.dart';

import '../widgets/tile.dart';

class ThirdScreen extends StatefulWidget {
  final String name;
  const ThirdScreen({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  List<Data> dataUser = [];
  final ScrollController _scrollController = ScrollController();
  int page = 1;

  @override
  void initState() {
    context.read<FetchUserBloc>().add(FetchUserEvent.fetchUser("$page"));
    _scrollController.addListener(onScroll);
    super.initState();
  }

  void onScroll() async {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    if (maxScroll == currentScroll) {
      page++;
      context.read<FetchUserBloc>().add(FetchUserEvent.loadMore("$page"));
    }
  }

  Future refresh() async {
    page = 1;
    dataUser.clear();
    context.read<FetchUserBloc>().add(FetchUserEvent.refresh("$page"));
  }

  @override
  void dispose() {
    dataUser.clear();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Third Screen',
          style: TextStyle(
            color: AppColors.dark,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF554AF0),
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return refresh();
        },
        child: BlocBuilder<FetchUserBloc, FetchUserState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return const Center(child: CircularProgressIndicator());
              },
              loading: () {
                return const Center(child: CircularProgressIndicator());
              },
              success: (data) {
                dataUser.addAll(data);
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: ListView.separated(
                    itemCount: dataUser.length + 1,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      if (index < dataUser.length) {
                        final users = dataUser[index];
                        return Tile(widget: widget, users: users);
                      }
                      if (data.isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              'Data is Empty.',
                              style: TextStyle(
                                color: AppColors.dark,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: AppColors.lightGrey,
                        thickness: 1,
                      );
                    },
                  ),
                );
              },
              error: (message) {
                return Center(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: AppColors.dark,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
