part of 'all_post_bloc.dart';

enum StatusPage { loaded, loading, failure }

class AllPostState extends Equatable {
  const AllPostState(
      {this.error = '',
      this.status = StatusPage.loading,
      this.postList = const []});
  final Object error;

  final StatusPage status;

  final List<LocalEntityPost> postList;

  @override
  List<Object> get props => [error, status, postList];

  AllPostState copyWith({
    Object? error,
    StatusPage? status,
    List<LocalEntityPost>? postList,
  }) {
    return AllPostState(
      error: error ?? this.error,
      status: status ?? this.status,
      postList: postList ?? this.postList,
    );
  }
}
