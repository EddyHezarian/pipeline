import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:pipeline/configs/components/appbar/app_bar.dart';
import 'package:pipeline/configs/components/buttons/brand_selector_container.dart';
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
                context: context, title: TextConsts.openOrders),
            body: Column(
              children: [
                BrandSelectorContainer(
                    action: (dynamic value) {
                      setState(() {
                        brandName = value!;
                      });
                      BlocProvider.of<OrderCubit>(context)
                          .loadOrders(brandName: brandName, status: "OPEN");
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
          return Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(right: 16, left: 16, top: 14),
            height: MediaQuery.of(context).size.height * 0.269,
            decoration: BoxDecoration(
              color: ColorPallet.dataContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //!data
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //*customer details
                    Column(
                      children: [
                        //?name
                        SizedBox(
                            height: 100,
                            width: 150,
                            child: Center(
                                child: Text(
                              model.customerName,
                              style: TextStyles.nameOrderCard,
                              textAlign: TextAlign.center,
                            ))),
                        //? date
                        Row(
                          children: [
                            const Text(
                              "تاریخ:",
                              style: TextStyles.secondaryDataOrderCart,
                            ),
                            8.0.sizedBoxWidthExtension,
                            Text(
                              DateFormat(
                                'yyyy-MM-DD',
                              )
                                  .format(model.createdAt)
                                  .toString()
                                  .toPersianDate(),
                              style: TextStyles.littleDataOrderCart,
                            )
                            //Text(datefor)
                          ],
                        ),
                        //? description
                        Column(
                          children: [
                            const Text(
                              "توضیحات:",
                              style: TextStyles.secondaryDataOrderCart,
                            ),
                            10.0.sizedBoxWidthExtension,
                            SizedBox(
                              width: 180,
                              child: Text(
                                model.description,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: ColorPallet.subtext,
                                    fontFamily: "dana",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    //* cart info
                    Column(
                      children: [
                        //!shirts
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          margin: const EdgeInsets.only(top: 4),
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorPallet.background),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "روپوش",
                                    style: TextStyles.cartDetailsParameter,
                                  ),
                                  4.0.sizedBoxWidthExtension,
                                  Text(
                                    model.shirtSize,
                                    style: TextStyles.cartDetailsvalue,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "|",
                                    style: TextStyle(
                                        color: ColorPallet.subtext,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text("تعداد:",
                                      style: TextStyles.cartDetailsParameter2),
                                  Text(
                                    model.shirtQTY.toString().toPersianDigit(),
                                    style: TextStyles.cartDetailsvalue,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        //!pants
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          margin: const EdgeInsets.only(top: 4),
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorPallet.background),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "روپوش",
                                    style: TextStyles.cartDetailsParameter,
                                  ),
                                  4.0.sizedBoxWidthExtension,
                                  Text(
                                    model.shirtSize,
                                    style: TextStyles.cartDetailsvalue,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "|",
                                    style: TextStyle(
                                        color: ColorPallet.subtext,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text("تعداد:",
                                      style: TextStyles.cartDetailsParameter2),
                                  Text(
                                    model.shirtQTY.toString().toPersianDigit(),
                                    style: TextStyles.cartDetailsvalue,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        //! scarfs
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          margin: const EdgeInsets.only(top: 4),
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorPallet.background),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "روپوش",
                                    style: TextStyles.cartDetailsParameter,
                                  ),
                                  4.0.sizedBoxWidthExtension,
                                  Text(
                                    model.shirtSize,
                                    style: TextStyles.cartDetailsvalue,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "|",
                                    style: TextStyle(
                                        color: ColorPallet.subtext,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text("تعداد:",
                                      style: TextStyles.cartDetailsParameter2),
                                  Text(
                                    model.shirtQTY.toString().toPersianDigit(),
                                    style: TextStyles.cartDetailsvalue,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                //! purchase
                Column(
                  children: [
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "مبلغ پرداختی:",
                              style: TextStyles.secondaryDataOrderCart,
                            ),
                            Text(
                              model.purchase
                                  .toString()
                                  .toPersianDigit()
                                  .seRagham(),
                              style: TextStyles.littleDataOrderCart,
                            ),
                            const Text(
                              " تومان",
                              style: TextStyles.toman,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: ColorPallet.error),
                            ),
                            const Text(
                              "سفارش جاری",
                              style: TextStyles.openOrderStatuts,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  _emptyState() {
    return Column(
      children: [
      SvgPicture.asset(IconsPath.empty),
      const Text("هنوز سفارشی برای این برند ثبت نشده",style: TextStyle(fontFamily: "dana",fontSize: 18,fontWeight: FontWeight.w700,color: ColorPallet.primary),),
    ],);
  }

  _loadingView(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: const CustomeDrawer(),
      backgroundColor: ColorPallet.background,
      appBar: customeMainAppBar(context: context, title: TextConsts.openOrders),
      body: Column(
        children: [
          BrandSelectorContainer(
              action: (dynamic value) {
                setState(() {
                  brandName = value!;
                });
                BlocProvider.of<OrderCubit>(context)
                    .loadOrders(brandName: brandName, status: "OPEN");
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
                context: context, title: TextConsts.openOrders),
            body: Column(
              children: [
                BrandSelectorContainer(
                    action: (dynamic value) {
                      setState(() {
                        brandName = value!;
                      });
                      BlocProvider.of<OrderCubit>(context)
                          .loadOrders(brandName: brandName, status: "OPEN");
                    },
                    activator: () {
                      setState(() {
                        focusDropDown = true;
                      });
                    },
                    menuItems: brandMenuItems,
                    controller: brandName,
                    isAutoFocused: focusDropDown)
              ],
            )));
  }
}

class DateFormattedText extends StatelessWidget {
  final DateTime dateTime;
  final String formatPattern;

  const DateFormattedText(
      {super.key, required this.dateTime, required this.formatPattern});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat(formatPattern).format(dateTime);

    return Text(
      formattedDate,
      style: const TextStyle(fontSize: 18),
    );
  }
}
