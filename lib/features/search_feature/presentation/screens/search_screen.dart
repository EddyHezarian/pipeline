import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pipeline/configs/components/cards/order_cart.dart';
import 'package:pipeline/configs/components/loding_animations.dart';
import 'package:pipeline/configs/consts/text_consts.dart';
import 'package:pipeline/configs/extensions/custome_extensetion.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';
import 'package:pipeline/configs/theme/icons_path.dart';
import 'package:pipeline/configs/theme/text_styles.dart';
import 'package:pipeline/features/search_feature/repository/bloc/search_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
      //? initial state
      if (state is InitialSearchState) {
        return _initialView();
      }
      //? loading state
      if (state is LoadingSearchState) {
        return _loadingView();
      }
      //* success state
      if (state is SuccessSearchState) {
        return _successDataView(state);
      }

      //! failed search state
      if (state is FailedSearchState) {
        return _emptyState();
      }

      //! unexpected Error

      return _errorState();
    });
  }

  _initialView() {
    return SafeArea(child: Scaffold(appBar: _searchAppbar()));
  }

  _loadingView() {
    return SafeArea(
        child: Scaffold(
      appBar: _searchAppbar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  lodingWidget(),
                  const Text(
                    TextConsts.searchforname,
                    style: TextStyles.drawerItems,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  AppBar _searchAppbar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: TextField(
        controller: searchController,
        onSubmitted: (value) {
          BlocProvider.of<SearchCubit>(context)
              .searchForName(searchController.text);
        },
        textInputAction: TextInputAction.search,
        autofocus: true,
        decoration: InputDecoration(
            prefixIcon: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  BlocProvider.of<SearchCubit>(context).refresh();
                },
                child: const Icon(Icons.arrow_back)),
            hintText: "جستجوی نام سفارش",
            suffixIcon: InkWell(
                onTap: () {
                  searchController.clear();
                },
                child: const Icon(Icons.clear)),
            hintStyle: const TextStyle(
                fontFamily: "dana", fontWeight: FontWeight.w500)),
      ),
    );
  }

  _emptyState() {
    return SafeArea(
        child: Scaffold(
      appBar: _searchAppbar(),
      body: Center(
        child: Column(
          children: [
            140.0.sizedBoxheightExtention,
            SvgPicture.asset(IconsPath.emptySearch),
            const Text(
              "سفارشی با این نام ثبت نشده",
              style: TextStyle(
                  fontFamily: "dana",
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: ColorPallet.primary),
            ),
          ],
        ),
      ),
    ));
  }

  _errorState() {
    return SafeArea(
        child: Scaffold(
      appBar: _searchAppbar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              IconsPath.noConeection,
              theme: const SvgTheme(currentColor: ColorPallet.error),
            ),
            const Text(
              "یه مشکلی پیش اومده",
              style: TextStyle(
                  fontFamily: "dana",
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: ColorPallet.error),
            ),
          ],
        ),
      ),
    ));
  }

  _successDataView(SuccessSearchState state) {
    return SafeArea(
        child: Scaffold(
            appBar: _searchAppbar(),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        return OrderCard(model: state.items[index]);
                      }),
                ),
              ],
            )));
  }
}
