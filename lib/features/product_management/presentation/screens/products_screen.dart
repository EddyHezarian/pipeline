
import 'package:flutter/material.dart';
import 'package:pipeline/configs/components/buttons/floating_action_button.dart';
import 'package:pipeline/configs/components/snack_bars.dart';
import 'package:pipeline/configs/theme/text_styles.dart';
import 'package:pipeline/locator.dart';
import 'package:pipeline/features/product_management/data/models/pants_model.dart';
import 'package:pipeline/features/product_management/data/models/scarf_model.dart';
import 'package:pipeline/features/product_management/data/models/shirt_model.dart';
import 'package:pipeline/features/product_management/data/remote/pants_api_provider.dart';
import 'package:pipeline/features/product_management/data/remote/scarf_api_provider.dart';
import 'package:pipeline/features/product_management/data/remote/shirts_api_provider.dart';
import 'package:pipeline/features/product_management/presentation/components/insert_dialog.dart';
import 'package:pipeline/features/product_management/presentation/screens/tabs/pants_tab.dart';
import 'package:pipeline/features/product_management/presentation/screens/tabs/scarf_tab.dart';
import 'package:pipeline/features/product_management/presentation/screens/tabs/shirt_tab.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  ShirtsApiProvider shirtsApiProvider = locator();
  ScarfApiProvider scarfApiProvider = locator();
  PantsApiProvider pantsApiProvider = locator();
  @override
  void dispose() {
    typeController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
          length: 3,
          child: Scaffold(
            floatingActionButton: customeActionButton(
                title: "افزودن محصول",
                action: () {
                  openInsertProductDialog(
                    context: context,
                    controller: titleController,
                    productType: typeController,
                    action: () {
                      switch (typeController.text) {
                        case "SHIRT":
                          shirtsApiProvider.addShirt(
                              product: ShirtModel(size: titleController.text));
                        case "SCARF":
                          scarfApiProvider.addScarf(
                              product: ScarfModel(size: titleController.text));
                        case "PANTS":
                          pantsApiProvider.addPants(
                              product: PantsModel(size: titleController.text));
                      }
                      if (mounted) {
                        showSuccessSnackBar(context);
                      }
                    },
                  );
                }),
            appBar: _tabAppBar(),
            body: const TabBarView(children: [
              ShirtPartition(),
              PantsPartition(),
              ScarfPartition()
            ]),
          )),
    );
  }

  AppBar _tabAppBar() {
    return AppBar(
      title: const Text(
        "محصولات",
        style: TextStyles.appbarHeading,
      ),
      bottom:
          TabBar(labelStyle: TextStyles.bottomNavItems, tabs: tabItemList()),
    );
  }

  List<Widget> tabItemList() {
    List<Tab> items = [
      const Tab(
        text: "روپوش",
      ),
      const Tab(
        text: "شلوار",
      ),
      const Tab(
        text: "مقنعه",
      ),
    ];
    return items;
  }
}
