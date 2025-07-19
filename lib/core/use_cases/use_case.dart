// to standardize the use cases method signature ,
// Generic Use Case
// type is a input parameter cause it is generic ,and i can resue it with another different type
// <> is a called generic
import 'package:booklycleanarch/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Type, Parameters> {
  Future<Either<Failure, Type>> call([Parameters parameters]);
}

// void is a return type , make it more readable than void
class NoParam {}
