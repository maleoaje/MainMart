import 'package:ijshopflutter/model/general/related_product_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RelatedProductState {}

class InitialRelatedProductState extends RelatedProductState {}

class RelatedProductError extends RelatedProductState {
  final String errorMessage;

  RelatedProductError({
    this.errorMessage,
  });
}

class RelatedProductWaiting extends RelatedProductState {}

class GetRelatedProductSuccess extends RelatedProductState {
  final List<RelatedProductModel> relatedProductData;
  GetRelatedProductSuccess({@required this.relatedProductData});
}