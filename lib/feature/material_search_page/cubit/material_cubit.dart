import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/feature/material_search_page/cubit/material_state.dart';

import 'package:recipe_finder/feature/material_search_page/service/material_service.dart';
import 'package:recipe_finder/product/model/ingradient_model.dart';

import '../../../core/base/model/base_view_model.dart';

class MaterialSearchCubit extends Cubit<IMaterialSearchState>
    implements IBaseViewModel {
  IMaterialSearchService? service;

  MaterialSearchCubit() : super(MaterialSearchInit());

  List<IngredientModel> essentials = [];
  List<IngredientModel> vegatables = [];

  @override
  void init() {
    service = MaterialSearchService();
  }

  @override
  BuildContext? context;

  void essentialList() {
    essentials = service!.fetchEssentialList();
    emit(EssentialListLoaded(essentials));
  }

  void vegatablesList() {
    vegatables = service!.fetchVegatablesList();
    emit(VegatableListLoaded(vegatables));
  }

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
