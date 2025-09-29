class GroupState {
  final bool? isLoading;
  final String? error;
  final bool? created;
  final bool? deleted;
  final bool? archived;
  final bool? unarchived;

  GroupState({
    this.error,
    this.archived,
    this.created,
    this.deleted,
    this.isLoading,
    this.unarchived,
  });

  GroupState copyWith({
    final bool? isLoading,
    final String? error,
    final bool? created,
    final bool? deleted,
    final bool? archived,
    final bool? unarchived,
  }) {
    return GroupState(
      archived: archived,
      created: created,
      deleted: deleted,
      isLoading: isLoading,
      unarchived: unarchived,
    );
  }
}
