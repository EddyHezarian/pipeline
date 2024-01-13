import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipeline/configs/components/appbar/app_bar.dart';
import 'package:pipeline/configs/components/drawer/custome_drawer.dart';
import 'package:pipeline/configs/components/loding_animations.dart';
import 'package:pipeline/configs/consts/text_consts.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';
import 'package:pipeline/configs/theme/text_styles.dart';
import 'package:pipeline/features/brand_management/data/local/brand_local_db_controller.dart';
import 'package:pipeline/features/brand_management/data/model/brand_model.dart';
import 'package:pipeline/features/order_managment/repository/blocs/cubit/order_cubit.dart';
import 'package:pipeline/locator.dart';

class OpenOrderScreen extends StatefulWidget {
  const OpenOrderScreen({super.key});

  @override
  State<OpenOrderScreen> createState() => _OpenOrderScreenState();
}

class _OpenOrderScreenState extends State<OpenOrderScreen> {
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
          return SafeArea(
              child: Scaffold(
                  drawer: const CustomeDrawer(),
                  backgroundColor: ColorPallet.background,
                  appBar: customeMainAppBar(
                      context: context, title: TextConsts.openOrders),
                  body: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () => setState(() {
                            focusDropDown = true;
                          }),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            margin: const EdgeInsets.only(right: 20, top: 20),
                            //width: MediaQuery.of(context).size.width * 0.43,
                            height: 48,
                            decoration: BoxDecoration(
                                color: ColorPallet.dataContainer,
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButton(
                              hint: Text(
                                brandName,
                                maxLines: 1,
                                style: TextStyles.textFieldTitle,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              autofocus: focusDropDown,
                              items: brandMenuItems,
                              onChanged: (value) {
                                setState(() {
                                  brandName = value!;
                                });
                                BlocProvider.of<OrderCubit>(context).loadOrders(
                                    brandName: brandName, status: "OPEN");
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  )));
        }

        //? Loading----------------------------------------------------
        if (state is LoadingOrdersState) {
          return SafeArea(
              child: Scaffold(
            drawer: const CustomeDrawer(),
            backgroundColor: ColorPallet.background,
            appBar: customeMainAppBar(
                context: context, title: TextConsts.openOrders),
            body: Center(
              child: lodingWidget(),
            ),
          ));
        }
        //* Fetched----------------------------------------------------
        if (state is FetchedOrdersState) {
          print(state.freshOrders);
          return SafeArea(
              child: Scaffold(
            drawer: const CustomeDrawer(),
            backgroundColor: ColorPallet.background,
            appBar: customeMainAppBar(
                context: context, title: TextConsts.openOrders),
            body: Center(
              child: const Text("data"),
            ),
          ));
        }

        return Container();
      },
    );
  }
}
