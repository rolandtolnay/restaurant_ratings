import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import 'request_state.dart';

Logger _log = Logger('$RequestNotifier');

abstract class RequestNotifier<Value> with ChangeNotifier {
  RequestNotifier({
    RequestState<Value, Exception> initial = const RequestState.initial(),
  }) : _requestState = initial;

  RequestState<Value, Exception> _requestState;
  bool _mounted = true;

  RequestState<Value, Exception> get state => _requestState;

  // ignore: avoid_setters_without_getters
  set _state(RequestState<Value, Exception> newState) {
    if (newState == _requestState) return;
    _requestState = newState;
    if (_mounted) notifyListeners();
  }

  Future<RequestState<Value, Exception>> executeRequest(
    ValueGetter<Future<Value>> requestBuilder, {
    bool Function(dynamic exception)? shouldLogError,
    Exception? Function(Exception)? mapError,
    Value Function(Value)? mapValue,
  }) async {
    try {
      _state = _requestState.maybeMap(
        success: (result) => RequestState.loading(resultMaybe: result.value),
        orElse: RequestState<Value, Exception>.loading,
      );

      final value = await requestBuilder();
      return _state = RequestState.success(mapValue?.call(value) ?? value);
    } catch (e, st) {
      if (kIsWeb) {
        debugPrint('[ERROR] $e');
        debugPrint('$st');
      } else {
        if (shouldLogError?.call(e) ?? true) _log.severe('[ERROR] $e', e, st);
      }
      final exception = (e is Exception) ? e : Exception('$e');
      final stateException = mapError != null ? mapError(exception) : exception;
      if (stateException != null) {
        return _state = RequestState.failure(stateException);
      } else {
        return _state = const RequestState.initial();
      }
    }
  }

  void reset() => _state = const RequestState.initial();

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
