import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_magang/data/models/industry_model.dart';
import 'package:sistem_magang/domain/usecases/get_indusrty.dart';
import 'package:sistem_magang/presenstation/student/profile/bloc/industry_event.dart';
import 'package:sistem_magang/presenstation/student/profile/bloc/industry_state.dart';

class IndustryBloc extends Bloc<IndustryEvent, IndustryState> {
  final GetIndustryInfo getIndustryInfo;

  IndustryBloc(this.getIndustryInfo) : super(const IndustryInitial()) {
    on<FetchIndustryData>((event, emit) async {
      emit(const IndustryLoading());
      
      try {
        final industry = await getIndustryInfo.execute();
        emit(IndustryLoaded(industry as IndustryModel));
            } catch (e) {
        emit(IndustryError(e.toString()));
      }
    });
  }
}