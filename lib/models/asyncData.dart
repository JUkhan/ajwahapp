enum AsyncStatus { Loading, Loaded, Error }

class AsyncData<T> {
  final T data;
  final AsyncStatus asyncStatus;
  final String error;
  AsyncData({this.data, this.asyncStatus, this.error});

  AsyncData.loaded(T data)
      : this(
          data: data,
          asyncStatus: AsyncStatus.Loaded,
          error: null,
        );

  AsyncData.error(String errorMessage, T data)
      : this(
          data: data,
          asyncStatus: AsyncStatus.Error,
          error: errorMessage,
        );
  AsyncData.loading(T data)
      : this(
          data: data,
          asyncStatus: AsyncStatus.Loading,
          error: null,
        );

  @override
  String toString() {
    return 'AsyncData(data: $data, asyncStatus: $asyncStatus, error: $error)';
  }
}
