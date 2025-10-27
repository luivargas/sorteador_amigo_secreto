class ParticipantState {
  bool? isLoading;
  String? error;
  bool? created;
  bool? deleted;
  bool? showed;

  ParticipantState({
    this.showed,
    this.error,
    this.created,
    this.deleted,
    this.isLoading,
  });

  ParticipantState copyWith({
    bool? isLoading,
    String? error,
    bool? created,
    bool? deleted,
    bool? showed,
  }) {
    return ParticipantState(
      created: created,
      deleted: deleted,
      isLoading: isLoading,
      showed: showed,
    );
  }
}
