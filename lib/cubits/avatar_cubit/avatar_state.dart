part of 'avatar_cubit.dart';

@immutable
sealed class AvatarState {
  final int currentIndex;
  AvatarState(this.currentIndex);
}
class AvatarInitial extends AvatarState {
  AvatarInitial() : super(0);
}
class AvatarUpdate extends AvatarState {
  AvatarUpdate(super.currentIndex);
}

