// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class DioHL {
  static Dio? object;
  static CacheStore? cacheStore;
  static CacheOptions? cacheOptions;
  DioHL._conest();
// CacheStore cacheStore = MemCacheStore(maxSize: 10485760, maxEntrySize: 1048576);
//   CacheOptions   cacheOptions ;
  static Dio instance() {
    if (object == null) {
      cacheStore = MemCacheStore(maxSize: 10485760, maxEntrySize: 1048576);
      cacheOptions = CacheOptions(
        store: cacheStore,
        policy: CachePolicy.refreshForceCache,
        hitCacheOnErrorExcept: [],
        maxStale: const Duration(days: 7),
        priority: CachePriority.high,
      );

      object = Dio()
        ..interceptors.add(
          DioCacheInterceptor(options: cacheOptions!),
        );
    }
    return object!;
  }
}
