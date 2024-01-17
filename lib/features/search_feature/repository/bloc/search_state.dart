
part  of 'search_cubit.dart';

@immutable
sealed class SearchState{}
 class InitialSearchState extends SearchState{

}
final class LoadingSearchState extends SearchState{

}
final class SuccessSearchState extends SearchState{
 final List<OrderModel> items ;
 SuccessSearchState(this.items);
}
final class FailedSearchState extends SearchState{

}
