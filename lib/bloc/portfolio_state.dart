import 'package:equatable/equatable.dart';
import 'package:protfolio/models/project_models.dart';

abstract class PortfolioState extends Equatable {
  @override
  List<Object> get props => [];
}

class PortfolioLoading extends PortfolioState {}

class PortfolioLoaded extends PortfolioState {
  final List<ProjectModel> projects;

  PortfolioLoaded(this.projects);

  @override
  List<Object> get props => [projects];
}