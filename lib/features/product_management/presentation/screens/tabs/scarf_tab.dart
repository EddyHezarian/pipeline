
import 'package:flutter/material.dart';
import 'package:pipeline/configs/components/appbar/section_title.dart';
import 'package:pipeline/configs/components/loadings/loading_for_product_brand.dart';
import 'package:pipeline/configs/components/snack_bars.dart';
import 'package:pipeline/core/models/product_model.dart';
import 'package:pipeline/features/brand_management/presentation/components/brand_card.dart';
import 'package:pipeline/features/locator.dart';
import 'package:pipeline/features/product_management/data/scarf_api_provider.dart';
import 'package:pipeline/features/product_management/presentation/components/delete_dialog.dart';

class ScarfPartition extends StatefulWidget {
  const ScarfPartition({
    super.key,
  });

  @override
  State<ScarfPartition> createState() => _ScarfPartitionState();
}

class _ScarfPartitionState extends State<ScarfPartition> {
  ScarfApiProvider apiProvider = locator();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: SectionTitle(title: "لیست مقنعه‌ها"),
        ),
        Expanded(child: _loadAndShowScarf())
      ],
    );
  }

  FutureBuilder<List<ScarfModel>> _loadAndShowScarf() {
    return FutureBuilder(
        future: apiProvider.getScarf(),
        builder: (context, AsyncSnapshot<List<ScarfModel>> snapshot) {
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
                            apiProvider.deleteScarf(
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
