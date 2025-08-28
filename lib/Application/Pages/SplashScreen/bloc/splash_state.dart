import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SplashLoading extends SplashState {}

class SponsorImagesLoaded extends SplashState {
  final List<String> sponsorImageUrls;

  SponsorImagesLoaded(this.sponsorImageUrls);

  @override
  List<Object?> get props => [sponsorImageUrls];
}

class SplashError extends SplashState {
  final String message;

  SplashError(this.message);

  @override
  List<Object?> get props => [message];
}
