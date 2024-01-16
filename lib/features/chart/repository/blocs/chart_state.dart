part of 'chart_cubit.dart';

@immutable
sealed class ChartState {}

final class LoadingChartState extends ChartState {}

final class FetchedChartState extends ChartState {
  final List<Map<String,int>> mapdata;
  FetchedChartState(this.mapdata);
}

class InitialChartState extends ChartState {}
