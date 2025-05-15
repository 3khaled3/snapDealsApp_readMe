import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_deals/app/home_feature/data/repositories/favorite/i_favorite_repository.dart';

part 'add_to_favorite_state.dart';

class AddToFavoriteCubit extends Cubit<AddToFavoriteState> {
  AddToFavoriteCubit() : super(AddToFavoriteInitial());
  final _favoriteRepository = FavoriteRepository();
  Future<void> addToFavorites(String id) async {
    emit(AddToFavoriteLoading());
    final result = await _favoriteRepository.addToFavorites(id);
    result.fold((l) => emit(AddToFavoriteError()), (r) {
      emit(AddToFavoriteSuccess());
    });
  }
}
