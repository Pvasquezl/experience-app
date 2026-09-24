class SaleDetailState {
  final Map<String, dynamic>? sale;
  final bool isLoading;
  final String? errorMessage;

  const SaleDetailState({this.sale, this.isLoading = false, this.errorMessage});

  bool get hasSale => sale != null;

  SaleDetailState copyWith({
    Map<String, dynamic>? sale,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SaleDetailState(
      sale: sale ?? this.sale,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
