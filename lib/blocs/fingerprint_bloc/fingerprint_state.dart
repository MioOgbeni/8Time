import 'package:equatable/equatable.dart';

abstract class FingerprintState extends Equatable {
  const FingerprintState();

  @override
  List<Object> get props => [];
}

class FpAuthenticated extends FingerprintState {}

class FpUnauthenticated extends FingerprintState {}
