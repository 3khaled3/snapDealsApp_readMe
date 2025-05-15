import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_deals/app/home_feature/data/repositories/favorite/i_favorite_repository.dart';

part 'remove_from_favorite_state.dart';

class RemoveFromFavoriteCubit extends Cubit<RemoveFromFavoriteState> {
  RemoveFromFavoriteCubit() : super(RemoveFromFavoriteInitial());
  final _favoriteRepository = FavoriteRepository();
  Future<void> removeFromFavorites(String id) async {
    emit(RemoveFromFavoriteLoading());
    final result = await _favoriteRepository.removeFromFavorites(id);
    result.fold((l) => emit(RemoveFromFavoriteError()), (r) {
      emit(RemoveFromFavoriteSuccess());
    });
  }
}
