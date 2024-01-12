import 'package:flutter/material.dart';
import 'package:pipeline/configs/components/appbar/appbar_for_screens_in_drawer.dart';
import 'package:pipeline/configs/components/appbar/section_title.dart';
import 'package:pipeline/configs/components/buttons/floating_action_button.dart';
import 'package:pipeline/configs/components/loadings/loading_for_product_brand.dart';
import 'package:pipeline/configs/components/snack_bars.dart';
import 'package:pipeline/configs/consts/text_consts.dart';
import 'package:pipeline/features/brand_management/data/model/brand_model.dart';
import 'package:pipeline/features/brand_management/data/remote/brand_api_provider.dart';
import 'package:pipeline/features/brand_management/presentation/components/bottome_sheet.dart';
import 'package:pipeline/features/brand_management/presentation/components/brand_card.dart';
import 'package:pipeline/locator.dart';

class BrandSettingScreen extends StatefulWidget {
  const BrandSettingScreen({super.key});

  @override
  State<BrandSettingScreen> createState() => _BrandSettingScreenState();
}

class _BrandSettingScreenState extends State<BrandSettingScreen> {
  BrandsApiProvider brandsApiProvider = locator();
  TextEditingController? controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:
            secondaryAppBar(title: TextConsts.brandsAppBar, context: context),
        body: Column(children: [
          //! title----------------------------------
          const Padding(
            padding: EdgeInsets.all(15),
            child: SectionTitle(
              title: TextConsts.manageBrands,
            ),
          ),
          //! items-----------------------------------
          Expanded(
            child: _loadAndShowBrands(),
          )
        ]),
        //! button------------------------------------

        floatingActionButton: customeActionButton(
            title: TextConsts.addBrand,
            action: () {
              //!opne bottom sheet
              openInsertBrandDialog(
                  context: context,
                  controller: controller!,
                  action: () {
                    _addNewBrandProcess();
                  });

              // brandsBottomSheet(context);
            }),
      ),
    );
  }

  Future<void> _addNewBrandProcess() async {
    if (await brandsApiProvider.isExistBrand(name: controller!.text) == true) {
      if (mounted) {
        showFailedSnackBar(context);
      }
    } else {
      brandsApiProvider.addBrand(brand: BrandModel(name: controller!.text));
      if (mounted) {
        showSuccessSnackBar(context);
      }
    }
  }

  FutureBuilder<List<BrandModel>> _loadAndShowBrands() {
    return FutureBuilder(
        future: brandsApiProvider.getBrands(),
        builder: (context, AsyncSnapshot<List<BrandModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var currentDataIndex = snapshot.data![index];
                  return CardForProductAndBrand(
                    isBrand: true,
                    id: currentDataIndex.id!,
                    title: currentDataIndex.name,
                    longPreesAction: () {
                      openDeleteBrandDialog(
                          context: context,
                          controller: controller!,
                          action: () {
                            brandsApiProvider.deletBrand(
                                name: currentDataIndex.name);
                            if (mounted) {
                              showSuccessSnackBar(context);
                            }
                          });
                    },
                  );
                });
          } else {
            return const LoadingForProductAndBrandCard();
          }
        });
  }
}
