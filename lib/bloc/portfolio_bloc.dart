import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:protfolio/models/project_models.dart';

import 'portfolio_event.dart';
import 'portfolio_state.dart';

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  PortfolioBloc() : super(PortfolioLoading()) {
    on<LoadProjects>((event, emit) async {

      emit(PortfolioLoading());

      await Future.delayed(const Duration(seconds: 2));

      final projects = [
        ProjectModel(
          title: "Event Management App",
          description: "Flutter + Firebase + BLoC",
        ),
        ProjectModel(
          title: "Resume Maker",
          description: "AI Resume Generator",
        ),
        ProjectModel(
          title: "Insurance Claim App",
          description: ".NET API + Flutter",
        ),
      ];

      emit(PortfolioLoaded(projects));
    });
  }
}