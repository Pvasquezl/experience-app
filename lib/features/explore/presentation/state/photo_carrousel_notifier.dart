
import 'package:experience_app/features/explore/domain/use_cases/get_preferred_products.dart';
import 'package:experience_app/features/explore/presentation/state/photo_carrousel_state.dart';
import 'package:riverpod/legacy.dart';


final photoCarrouselNotifierProvider =
    StateNotifierProvider<PhotoCarrouselNotifier, PhotoCarrouselState>(
      (ref) => PhotoCarrouselNotifier(),
    );

class PhotoCarrouselNotifier extends StateNotifier<PhotoCarrouselState>{
  final GetPreferredProductsUseCase _getPreferredProductsUseCase;

  PhotoCarrouselNotifier({GetPreferredProductsUseCase? getPreferredProductsUseCase})
      : _getPreferredProductsUseCase = getPreferredProductsUseCase ?? GetPreferredProductsUseCase(),
        super(PhotoCarrouselInitialState()){
    loadPreferredProducts();
  }

void setCurrentPage(int page) {
    state = PhotoCarrouselLoadedState(
      preferredItems: state is PhotoCarrouselLoadedState
          ? (state as PhotoCarrouselLoadedState).preferredItems
          : [],
      currentPage: page,
    );
  }
  Future<void> loadPreferredProducts() async {
    try {
      final preferredProducts = await _getPreferredProductsUseCase();
      state = PhotoCarrouselLoadedState(preferredItems: preferredProducts, currentPage: 0);
    } catch (e) {
      print('Error loading preferred products: $e');
    }
  }
}