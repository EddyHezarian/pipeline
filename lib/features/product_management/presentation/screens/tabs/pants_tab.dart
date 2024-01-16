
import 'package:flutter/material.dart';
import 'package:pipeline/configs/components/appbar/section_title.dart';
import 'package:pipeline/configs/components/loadings/loading_for_product_brand.dart';
import 'package:pipeline/configs/components/snack_bars.dart';

import 'package:pipeline/features/brand_management/presentation/components/brand_card.dart';
import 'package:pipeline/locator.dart';
import 'package:pipeline/features/product_management/data/models/pants_model.dart';
import 'package:pipeline/features/product_management/data/remote/pants_api_provider.dart';
import 'package:pipeline/features/product_management/presentation/components/delete_dialog.dart';

class PantsPartition extends StatefulWidget {
  const PantsPartition({
    super.key,
  });

  @override
  State<PantsPartition> createState() => _PantsPartitionState();
}

class _PantsPartitionState extends State<PantsPartition> {
  PantsApiProvider apiProvider = locator();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: SectionTitle(title: "لیست شلوار‌ها"),
        ),
        Expanded(child: _loadAndShowPants())
      ],
    );
  }

  _loadAndShowPants() {
    return FutureBuilder(
        future: apiProvider.getPants(),
        builder: (context, AsyncSnapshot<List<PantsModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var currentDataIndex = snapshot.data![index];
                  return CardForProductAndBrand(
                    isBrand: true,
                    id: currentDataIndex.id!,
                    title: currentDataIndex.size,
                    longPreesAction: () {
                      openDeleteProductDialog(
                          context: context,
                          controller: controller,
                          action: () {
                            apiProvider.deletePants(
                                name: currentDataIndex.size);
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
