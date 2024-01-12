import 'package:flutter/material.dart';
import 'package:pipeline/configs/components/appbar/appbar_for_screens_in_drawer.dart';
import 'package:pipeline/configs/components/buttons/main_button.dart';
import 'package:pipeline/configs/components/snack_bars.dart';
import 'package:pipeline/configs/components/textfields/long_textfield.dart';
import 'package:pipeline/configs/components/textfields/selector_container.dart';
import 'package:pipeline/configs/components/textfields/small_textfield.dart';
import 'package:pipeline/configs/consts/text_consts.dart';
import 'package:pipeline/configs/extensions/custome_extensetion.dart';
import 'package:pipeline/configs/theme/color_pallet.dart';
import 'package:pipeline/configs/theme/icons_path.dart';
import 'package:pipeline/configs/theme/text_styles.dart';
import 'package:pipeline/core/database/supabase/order/order_api_provider.dart';
import 'package:pipeline/core/model/order_model.dart';
import 'package:pipeline/features/add_order/presentation/components/quantity_container.dart';
import 'package:pipeline/features/add_order/repository/validator.dart';
import 'package:pipeline/features/brand_management/data/local/brand_local_db_controller.dart';
import 'package:pipeline/features/brand_management/data/model/brand_model.dart';
import 'package:pipeline/features/product_management/data/local/pants_local_db_controller.dart';
import 'package:pipeline/features/product_management/data/local/scarf_local_db_controller.dart';
import 'package:pipeline/features/product_management/data/local/shirt_local_db_controller.dart';
import 'package:pipeline/features/product_management/data/models/pants_model.dart';
import 'package:pipeline/features/product_management/data/models/scarf_model.dart';
import 'package:pipeline/features/product_management/data/models/shirt_model.dart';
import 'package:pipeline/locator.dart';

class AddOrderScreen extends StatefulWidget {
  const AddOrderScreen({super.key});

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController purchaseController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController selectedBrandController = TextEditingController();
  TextEditingController selectedShirtSize = TextEditingController();
  TextEditingController selectedPantsSize = TextEditingController();
  TextEditingController selectedScarfSize = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  int shirtQTY = 1;
  int pantsQTY = 1;
  int scarfQTY = 0;

  BrandLocalDbController brandHiveController = locator();
  ShirtLocalDbController shirtHiveController = locator();
  PantsLocalDbController pantsHiveController = locator();
  ScarfLocalDbController scarfHiveController = locator();
  OrderApiProvider orderApiProvider = locator();

  List<BrandModel> listOfBrands = [];
  List<ShirtModel> listOfShirts = [];
  List<PantsModel> listOfPants = [];
  List<ScarfModel> listOfScarf = [];

  List<DropdownMenuItem<String>> brandMenuItems = [];
  List<DropdownMenuItem<String>> shirtMenuItems = [];
  List<DropdownMenuItem<String>> pantsMenuItems = [];
  List<DropdownMenuItem<String>> scarfMenuItems = [];

  _brandMenuItemsLoader() async {
    listOfBrands = await brandHiveController.getBrands();
    for (int index = 0; index < listOfBrands.length; index++) {
      brandMenuItems.add(DropdownMenuItem(
        value: listOfBrands[index].name,
        child: Text(listOfBrands[index].name),
      ));
    }
  }

  _shirtMenuItemLoader() async {
    listOfShirts = await shirtHiveController.getShirts();
    for (int index = 0; index < listOfShirts.length; index++) {
      shirtMenuItems.add(DropdownMenuItem(
        value: listOfShirts[index].size,
        child: Text(listOfShirts[index].size),
      ));
    }
  }

  _pantsMenuItemLoader() async {
    listOfPants = await pantsHiveController.getPants();
    for (int index = 0; index < listOfPants.length; index++) {
      pantsMenuItems.add(DropdownMenuItem(
        value: listOfPants[index].size,
        child: Text(listOfPants[index].size),
      ));
    }
  }

  _scarfMenuItemLoader() async {
    listOfScarf = await scarfHiveController.getScarf();
    for (int index = 0; index < listOfScarf.length; index++) {
      scarfMenuItems.add(DropdownMenuItem(
        value: listOfScarf[index].size,
        child: Text(listOfScarf[index].size),
      ));
    }
  }

  @override
  initState() {
    _brandMenuItemsLoader();
    _shirtMenuItemLoader();
    _pantsMenuItemLoader();
    _scarfMenuItemLoader();
    super.initState();
  }

  @override
  build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: secondaryAppBar(title: TextConsts.addOrder, context: context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          //! custmer info form-------------------
          _customerInfoForm(context),
          //! cart list info----------------------
          _cartInfo(context),
          //!description--------------------------
          _description(context),
          //! apply button--------------------------
          _applyButton()
        ]),
      ),
    ));
  }

  _applyButton() {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: MainButton(
            action: () {
              //! validate data
              Map<String, dynamic> parameters = {
                'name': nameController.text,
                'phone': phoneController.text,
                'brand': selectedBrandController.text,
                'shirt': selectedShirtSize.text,
                'pants': selectedPantsSize.text,
                'scarf': selectedScarfSize.text,
              };
              if (validateOrderParameters(parameters)) {
                //* insert process
                OrderModel model = OrderModel(
                    customerName: nameController.text,
                    customerPhone: phoneController.text,
                    brandName: selectedBrandController.text,
                    purchase: int.parse(purchaseController.text),
                    status: 'OPEN',
                    description: descriptionController.text,
                    createdAt: DateTime.now(),
                    shirtSize: selectedShirtSize.text,
                    shirtQTY: shirtQTY,
                    pantsSize: selectedPantsSize.text,
                    pantsQTY: pantsQTY,
                    scarfSize: selectedScarfSize.text,
                    scarfQTY: scarfQTY);
                orderApiProvider.addOrder(order: model,context: context);
              } else {
                //! show failed snackbar
                showFailedSnackBar(context);
              }
            },
            title: "ثبت سفارش"));
  }

  _description(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      margin: const EdgeInsets.only(top: 15, right: 16, left: 16),
      child: TextField(
        controller: descriptionController,
        style: TextStyles.insideTextFields,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: ColorPallet.shadowBox)),
          labelStyle: TextStyles.textFieldTitle,
          labelText: 'توضیحات سفارش ',
          hintText: 'توضیحات',
        ),
      ),
    );
  }

  _cartInfo(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(right: 16, top: 12, left: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorPallet.dataContainer,
            boxShadow: const [
              BoxShadow(
                  blurRadius: 4,
                  blurStyle: BlurStyle.normal,
                  offset: Offset(0, 4),
                  color: ColorPallet.shadowBox)
            ]),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.35,
        child: Column(children: [
          //!shirts
          Row(
            children: [
              SelectorContainer(
                dropListItem: shirtMenuItems,
                controller: selectedShirtSize,
                title: TextConsts.shirtSize,
                hint: "",
              ),
              10.0.sizedBoxWidthExtension,
              QuantityContainer(
                  increase: () {
                    setState(() {
                      shirtQTY++;
                    });
                  },
                  decrease: () {
                    setState(() {
                      if (shirtQTY != 0) {
                        shirtQTY--;
                      }
                    });
                  },
                  controller: shirtQTY,
                  title: "تعداد")
            ],
          ),
          //! pants
          Row(
            children: [
              SelectorContainer(
                dropListItem: pantsMenuItems,
                controller: selectedPantsSize,
                title: TextConsts.pantsSize,
                hint: "",
              ),
              10.0.sizedBoxWidthExtension,
              QuantityContainer(
                  increase: () {
                    setState(() {
                      pantsQTY++;
                    });
                  },
                  decrease: () {
                    setState(() {
                      if (pantsQTY != 0) {
                        pantsQTY--;
                      }
                    });
                  },
                  controller: pantsQTY,
                  title: "تعداد")
            ],
          ),
          //! scarf
          Row(
            children: [
              SelectorContainer(
                dropListItem: scarfMenuItems,
                controller: selectedScarfSize,
                title: TextConsts.scarfSize,
                hint: "",
              ),
              10.0.sizedBoxWidthExtension,
              QuantityContainer(
                  increase: () {
                    setState(() {
                      scarfQTY++;
                    });
                  },
                  decrease: () {
                    setState(() {
                      if (scarfQTY != 0) {
                        scarfQTY--;
                      }
                    });
                  },
                  controller: scarfQTY,
                  title: "تعداد")
            ],
          ),
        ])
        //! description-------------------------
        //! apply button------------------------
        );
  }

  @override
  dispose() {
    selectedBrandController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  _customerInfoForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(right: 16, top: 23, left: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorPallet.infoContainer,
          boxShadow: const [
            BoxShadow(
                blurRadius: 4,
                blurStyle: BlurStyle.normal,
                offset: Offset(0, 4),
                color: ColorPallet.shadowBox)
          ]),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.39,
      child: Column(
        children: [
          //! name of customer
          LongTextfied(
              controller: nameController,
              iconPath: IconsPath.person,
              title: TextConsts.nameOfCustomer,
              hint: ""),
          //! phone customer
          LongTextfied(
              controller: phoneController,
              iconPath: IconsPath.phone,
              title: TextConsts.phoneOfCustomer,
              hint: ""),
          //!Brand selector
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SelectorContainer(
                dropListItem: brandMenuItems,
                controller: selectedBrandController,
                title: TextConsts.addBrandName,
                hint: "",
              ),
              8.0.sizedBoxWidthExtension,
              //! purchase field
              SmallTextField(
                controller: purchaseController,
                iconPath: IconsPath.cash,
                title: TextConsts.purchae,
                hint: "",
                readOnly: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
