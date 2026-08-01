import 'package:dartz/dartz.dart';
import '../../core/exceptions/app_exception.dart';

abstract interface class IUseCase<T, Params> {
  Future<Either<AppException, T>> call(Params params);
}