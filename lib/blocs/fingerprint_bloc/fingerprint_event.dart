import 'package:equatable/equatable.dart';

abstract class FingerprintEvent extends Equatable {
  const FingerprintEvent();

  @override
  List<Object> get props => [];
}

class FpInitialized extends FingerprintEvent {}

class FpApproved extends FingerprintEvent {}
