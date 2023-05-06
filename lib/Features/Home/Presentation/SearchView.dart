import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:newsapp/Core/utils/widgets/VerticalSpacing.dart';

import 'package:newsapp/Features/Home/Presentation/Manger/HomeCubit.dart';

import 'Widgets/EmptyNewsView.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool isSearching = false;
  @override
  void dispose() {
    if (mounted) {
      textEditingController.dispose();
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      focusNode.unfocus();
                      Navigator.pop(context);
                    },
                    child: const Icon(IconlyLight.arrowLeft2),
                  ),
                  Flexible(
                    child: TextField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      style: TextStyle(
                          color: HomeCubit.getobject(context).isDark
                              ? Colors.white
                              : Colors.black),
                      autofocus: true,
                      textInputAction: TextInputAction.search,
                      keyboardType: TextInputType.text,
                      onEditingComplete: () {
                        HomeCubit.getobject(context)
                            .getSearchData(search: textEditingController.text);

                        focusNode.unfocus();
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(left: 10, top: 15),
                        hintText: 'Search',
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: GestureDetector(
                            onTap: () {
                              isSearching = true;
                              textEditingController.clear();
                              focusNode.unfocus();
                              setState(() {});
                            },
                            child: const Icon(
                              Icons.close,
                              size: 18,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const VerticalSpacing(20),
            if (!isSearching && HomeCubit.getobject(context).searchList != null)
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MasonryGridView.count(
                    itemCount: HomeCubit.getobject(context).items.length,
                    crossAxisCount: 4,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          textEditingController.text =
                              HomeCubit.getobject(context).items[index];
                        },
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: HomeCubit.getobject(context).isDark
                                      ? Colors.white
                                      : Colors.black)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              HomeCubit.getobject(context).items[index],
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            if (isSearching && HomeCubit.getobject(context).searchList != null)
              const Expanded(
                child: EmptyNewsView(
                    text: 'Oops! No result found',
                    imageUrl: 'assets/images/search.png'),
              ),
          ],
        ),
      )),
    );
  }
}
