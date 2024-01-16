import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pipeline/configs/components/appbar/app_bar.dart';
import 'package:pipeline/configs/components/buttons/brand_selector_container.dart';
import 'package:pipeline/configs/components/drawer/custome_drawer.dart';
import 'package:pipeline/configs/consts/text_consts.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';
import 'package:pipeline/configs/theme/icons_path.dart';
import 'package:pipeline/configs/theme/text_styles.dart';
import 'package:pipeline/features/brand_management/data/local/brand_local_db_controller.dart';
import 'package:pipeline/features/brand_management/data/model/brand_model.dart';
import 'package:pipeline/features/chart/repository/blocs/chart_cubit.dart';
import 'package:pipeline/features/product_management/data/local/pants_local_db_controller.dart';
import 'package:pipeline/features/product_management/data/local/scarf_local_db_controller.dart';
import 'package:pipeline/features/product_management/data/local/shirt_local_db_controller.dart';
import 'package:pipeline/features/product_management/data/models/pants_model.dart';
import 'package:pipeline/features/product_management/data/models/scarf_model.dart';
import 'package:pipeline/features/product_management/data/models/shirt_model.dart';
import 'package:pipeline/locator.dart';

class ChartScreeen extends StatefulWidget {
  const ChartScreeen({super.key});

  @override
  State<ChartScreeen> createState() => _ChartScreeenState();
}

class _ChartScreeenState extends State<ChartScreeen> {
  List<BrandModel> listOfBrands = [];
  List<ShirtModel> listOfShirts = [];
  List<PantsModel> listOfPants = [];
  List<ScarfModel> listOfScarf = [];
  List<DropdownMenuItem<String>> brandMenuItems = [];
  BrandLocalDbController brandHiveController = locator();
  ShirtLocalDbController shirtsHiveController = locator();
  PantsLocalDbController pantsHiveController = locator();
  ScarfLocalDbController scarfHiveController = locator();
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

  _productLoader() async {
    listOfShirts = await shirtsHiveController.getShirts();
    listOfPants = await pantsHiveController.getPants();
    listOfScarf = await scarfHiveController.getScarf();
  }

  @override
  void initState() {
    _brandMenuItemsLoader();
    _productLoader();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CahrtCubit, ChartState>(
      builder: (context, state) {
        if (state is InitialChartState) {
          return SafeArea(
              child: DefaultTabController(
            length: 3,
            child: Scaffold(
                drawer: const CustomeDrawer(),
                backgroundColor: ColorPallet.background,
                appBar: customeMainAppBar(
                    isTabView: true,
                    tabItemList: [
                      const Tab(
                        text: "روپوش",
                      ),
                      const Tab(
                        text: "شلوار",
                      ),
                      const Tab(
                        text: "مقنعه",
                      ),
                    ],
                    context: context,
                    title: TextConsts.chart),
                body: Column(
                  children: [
                    BrandSelectorContainer(
                        action: (dynamic value) {
                          setState(() {
                            brandName = value!;
                          });
                          BlocProvider.of<CahrtCubit>(context)
                              .calculateChartForBrand(brandName: brandName);
                        },
                        activator: () {
                          setState(() {
                            focusDropDown = true;
                          });
                        },
                        menuItems: brandMenuItems,
                        controller: brandName,
                        isAutoFocused: focusDropDown),
                    _initialBody()
                  ],
                )),
          ));
        }

        if (state is LoadingChartState) {
          return SafeArea(
            child: DefaultTabController(
          length: 3,
          child: Scaffold(
              drawer: const CustomeDrawer(),
              backgroundColor: ColorPallet.background,
              appBar: customeMainAppBar(
                  isTabView: true,
                  tabItemList: [
                    const Tab(
                      text: "روپوش",
                    ),
                    const Tab(
                      text: "شلوار",
                    ),
                    const Tab(
                      text: "مقنعه",
                    ),
                  ],
                  context: context,
                  title: TextConsts.chart),
              body: Column(
                children: [
                  BrandSelectorContainer(
                      action: (dynamic value) {
                        setState(() {
                          brandName = value!;
                        });
                        BlocProvider.of<CahrtCubit>(context)
                            .calculateChartForBrand(brandName: brandName);
                      },
                      activator: () {
                        setState(() {
                          focusDropDown = true;
                        });
                      },
                      menuItems: brandMenuItems,
                      controller: brandName,
                      isAutoFocused: focusDropDown),
                  const Center(child: CircularProgressIndicator())
                ],
              )),
        ));
        }
        if (state is FetchedChartState) {
         return  SafeArea(
            child: DefaultTabController(
          length: 3,
          child: Scaffold(
              drawer: const CustomeDrawer(),
              backgroundColor: ColorPallet.background,
              appBar: customeMainAppBar(
                  isTabView: true,
                  tabItemList: [
                    const Tab(
                      text: "روپوش",
                    ),
                    const Tab(
                      text: "شلوار",
                    ),
                    const Tab(
                      text: "مقنعه",
                    ),
                  ],
                  context: context,
                  title: TextConsts.chart),
              body: TabBarView(children: [
                _shirt(context, state),
                _pants(context, state),
                _scarf(context, state)
              ],))
        ));

        }

        return Container();
      },
    );
  }

  Column _shirt(BuildContext context, FetchedChartState state) {
    return Column(
              children: [
                BrandSelectorContainer(
                    action: (dynamic value) {
                      setState(() {
                        brandName = value!;
                      });
                      BlocProvider.of<CahrtCubit>(context)
                          .calculateChartForBrand(brandName: brandName);
                    },
                    activator: () {
                      setState(() {
                        focusDropDown = true;
                      });
                    },
                    menuItems: brandMenuItems,
                    controller: brandName,
                    isAutoFocused: focusDropDown),
                Expanded(child: ShirtChart(chartNumbers: state.mapdata[0], shirts: listOfShirts))
              ],
            );
  }
Column _pants(BuildContext context, FetchedChartState state) {
    return Column(
              children: [
                BrandSelectorContainer(
                    action: (dynamic value) {
                      setState(() {
                        brandName = value!;
                      });
                      BlocProvider.of<CahrtCubit>(context)
                          .calculateChartForBrand(brandName: brandName);
                    },
                    activator: () {
                      setState(() {
                        focusDropDown = true;
                      });
                    },
                    menuItems: brandMenuItems,
                    controller: brandName,
                    isAutoFocused: focusDropDown),
                Expanded(child: PnatsChart(chartNumbers: state.mapdata[0], pants: listOfPants))
              ],
            );
  }
Column _scarf(BuildContext context, FetchedChartState state) {
    return Column(
              children: [
                BrandSelectorContainer(
                    action: (dynamic value) {
                      setState(() {
                        brandName = value!;
                      });
                      BlocProvider.of<CahrtCubit>(context)
                          .calculateChartForBrand(brandName: brandName);
                    },
                    activator: () {
                      setState(() {
                        focusDropDown = true;
                      });
                    },
                    menuItems: brandMenuItems,
                    controller: brandName,
                    isAutoFocused: focusDropDown),
                Expanded(child: ScarfChart(chartNumbers: state.mapdata[0], scarf: listOfScarf))
              ],
            );
  }

  Column _initialBody() {
    return Column(
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
    );
  }
}

class ShirtChart extends StatelessWidget {
  const ShirtChart(
      {super.key, required this.chartNumbers, required this.shirts});
  final Map<String, int> chartNumbers;
  final List<ShirtModel> shirts;

  @override
  Widget build(BuildContext context) {
    
    return ListView.builder(
      itemCount: shirts.length,
      itemBuilder: (BuildContext context, index) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.only(right: 35, left: 35 , top: 8),
        height: 48,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorPallet.dataContainer),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //!
            Text(
              shirts[index].size,
              style: TextStyles.productBrandCard,
            ),
            Row(
              children: [
                Text(
                  chartNumbers[shirts[index].size].toString(),
                  style: TextStyles.productBrandCard,
                ),
                const Text("عدد",style: TextStyle(fontFamily: "dana"),)
              ],
            ),
          ],
        ),
      );
    });
  }
}

class PnatsChart extends StatelessWidget {
  const PnatsChart({super.key, required this.chartNumbers, required this.pants});
  final Map<String, int> chartNumbers;
  final List<PantsModel> pants;

  @override
  Widget build(BuildContext context) {
    
    return ListView.builder(
      itemCount: pants.length,
      itemBuilder: (BuildContext context, index) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.only(right: 35, left: 35 , top: 8),
        height: 48,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorPallet.dataContainer),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //!
            Text(
              pants[index].size,
              style: TextStyles.productBrandCard,
            ),
            Row(
              children: [
                Text(
                  chartNumbers[pants[index].size].toString(),
                  style: TextStyles.productBrandCard,
                ),
                const Text("عدد",style: TextStyle(fontFamily: "dana"),)
              ],
            ),
          ],
        ),
      );
    });
  }
}

class ScarfChart extends StatelessWidget {
  const ScarfChart({super.key, required this.chartNumbers, required this.scarf});
  final Map<String, int> chartNumbers;
  final List<ScarfModel> scarf;

  @override
  Widget build(BuildContext context) {
    
    return ListView.builder(
      itemCount: scarf.length,
      itemBuilder: (BuildContext context, index) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.only(right: 35, left: 35 , top: 8),
        height: 48,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorPallet.dataContainer),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //!
            Text(
              scarf[index].size,
              style: TextStyles.productBrandCard,
            ),
            Row(
              children: [
                Text(
                  chartNumbers[scarf[index].size].toString(),
                  style: TextStyles.productBrandCard,
                ),
                const Text("عدد",style: TextStyle(fontFamily: "dana"),)
              ],
            ),
          ],
        ),
      );
    });
  }
}
