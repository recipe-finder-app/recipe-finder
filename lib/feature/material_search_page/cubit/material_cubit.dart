import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/feature/material_search_page/cubit/material_state.dart';
import 'package:recipe_finder/feature/material_search_page/model/material_essential_model.dart';
import 'package:recipe_finder/feature/material_search_page/model/material_vegatable_model.dart';
import 'package:recipe_finder/feature/material_search_page/service/material_service.dart';

import '../../../core/base/model/base_view_model.dart';

class MaterialSearchCubit extends Cubit<IMaterialSearchState>
    implements IBaseViewModel {
  IMaterialSearchService? service;

  MaterialSearchCubit() : super(MaterialSearchInit());

  List<MaterialEssentialModel> essentials = [];
  List<MaterialVegatablesModel> vegatables = [];


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
