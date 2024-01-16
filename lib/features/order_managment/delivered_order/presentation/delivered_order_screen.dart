import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pipeline/configs/components/appbar/app_bar.dart';
import 'package:pipeline/configs/components/buttons/brand_selector_container.dart';
import 'package:pipeline/configs/components/cards/order_cart.dart';
import 'package:pipeline/configs/components/drawer/custome_drawer.dart';
import 'package:pipeline/configs/components/loding_animations.dart';
import 'package:pipeline/configs/consts/text_consts.dart';
import 'package:pipeline/configs/extensions/custome_extensetion.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';
import 'package:pipeline/configs/theme/icons_path.dart';
import 'package:pipeline/configs/theme/text_styles.dart';
import 'package:pipeline/features/brand_management/data/local/brand_local_db_controller.dart';
import 'package:pipeline/features/brand_management/data/model/brand_model.dart';
import 'package:pipeline/features/order_managment/repository/blocs/cubit/order_cubit.dart';
import 'package:pipeline/locator.dart';

class DeliveredOrderScreen extends StatefulWidget {
  const DeliveredOrderScreen({super.key});

  @override
  State<DeliveredOrderScreen> createState() => _DeliveredOrderScreenState();
}

class _DeliveredOrderScreenState extends State<DeliveredOrderScreen> {
  List<BrandModel> listOfBrands = [];
  List<DropdownMenuItem<String>> brandMenuItems = [];
  BrandLocalDbController brandHiveController = locator();
  String brandName = 'انتخاب برند';
  bool focusDropDown = false;
  _brandMenuItemsLoader() async {
    listOfBrands = await brandHiveController.getBrands();
    for (int index = 0; index < listOfBrands.length; index++) {
      brandMenuItems.add(DropdownMenuItem(
        value: listOfBrands[index].name,
        child: Text(listOfBrands[index].name),
      ));
    }
  }

  @override
  void initState() {
    _brandMenuItemsLoader();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        //? initial state----------------------------------------------------
        if (state is InitialOrderState) {
          return _initialView(context);
        }
        //? Loading----------------------------------------------------
        if (state is LoadingOrdersState) {
          return _loadingView(context);
        }
        //* Fetched----------------------------------------------------
        if (state is FetchedOrdersState) {
          return _successView(context, state);
        }
        //! Crash State ------------------------------------------------------
        return _errorView();
      },
    );
  }

  _errorView() => Container();

  _successView(BuildContext context, FetchedOrdersState state) {
    return SafeArea(
        child: Scaffold(
            drawer: const CustomeDrawer(),
            backgroundColor: ColorPallet.background,
            appBar: customeMainAppBar(
                context: context, title: TextConsts.deliveredOrders),
            body: Column(
              children: [
                BrandSelectorContainer(
                    action: (dynamic value) {
                      setState(() {
                        brandName = value!;
                      });
                      BlocProvider.of<OrderCubit>(context)
                          .loadOrders(brandName: brandName, status: "DELIVERED");
                    },
                    activator: () {
                      setState(() {
                        focusDropDown = true;
                      });
                    },
                    menuItems: brandMenuItems,
                    controller: brandName,
                    isAutoFocused: focusDropDown),
                // divider
                10.0.sizedBoxheightExtention,
                Expanded(
                    child: state.freshOrders.isNotEmpty
                        ? _orderList(state)
                        : _emptyState())
              ],
            )));
  }

  _orderList(FetchedOrdersState state) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: state.freshOrders.length,
        itemBuilder: (context, index) {
          var model = state.freshOrders[index];
          return OrderCard(model: model);
        });
  }

  _emptyState() {
    return Column(
      children: [
        SvgPicture.asset(IconsPath.noOrder),
        const Text(
          "هنوز سفارشی برای این برند تحویل نشده",
          style: TextStyle(
              fontFamily: "dana",
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: ColorPallet.primary),
        ),
      ],
    );
  }

  _loadingView(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: const CustomeDrawer(),
      backgroundColor: ColorPallet.background,
      appBar: customeMainAppBar(context: context, title: TextConsts.deliveredOrders),
      body: Column(
        children: [
          BrandSelectorContainer(
              action: (dynamic value) {
                setState(() {
                  brandName = value!;
                });
                BlocProvider.of<OrderCubit>(context)
                    .loadOrders(brandName: brandName, status: "DELIVERED");
              },
              activator: () {
                setState(() {
                  focusDropDown = true;
                });
              },
              menuItems: brandMenuItems,
              controller: brandName,
              isAutoFocused: focusDropDown),
          200.0.sizedBoxheightExtention,
          Center(
            child: Column(
              children: [
                lodingWidget(),
                const Text(
                  TextConsts.loadingProducts,
                  style: TextStyles.drawerItems,
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }

  _initialView(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            drawer: const CustomeDrawer(),
            backgroundColor: ColorPallet.background,
            appBar: customeMainAppBar(
                context: context, title: TextConsts.deliveredOrders),
            body: Column(
              children: [
                BrandSelectorContainer(
                    action: (dynamic value) {
                      setState(() {
                        brandName = value!;
                      });
                      BlocProvider.of<OrderCubit>(context)
                          .loadOrders(brandName: brandName, status: "DELIVERED");
                    },
                    activator: () {
                      setState(() {
                        focusDropDown = true;
                      });
                    },
                    menuItems: brandMenuItems,
                    controller: brandName,
                    isAutoFocused: focusDropDown),
                Column(
                  children: [
                    SvgPicture.asset(IconsPath.empty),
                    const Text(
                      "یک برند را انتخاب کنید",
                      style: TextStyle(
                          fontFamily: "dana",
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: ColorPallet.primary),
                    ),
                  ],
                )
              ],
            )));
  }
}
