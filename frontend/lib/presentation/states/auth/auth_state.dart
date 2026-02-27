import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parkflow/models/auth/user_model.dart';
import 'package:parkflow/core/app_exception.dart';

part 'auth_state.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = Initial;
  const factory AuthState.loading() = Loading;
  const factory AuthState.authenticated(UserModel user) = Authenticated;
  const factory AuthState.unauthenticated() = Unauthenticated;
  const factory AuthState.sessionExpired() = SessionExpired;
  const factory AuthState.error(AppException error) = AuthError;

  const AuthState._();

  bool get isAuthenticated => this is Authenticated;
  bool get isLoading => this is Loading;
  AppException? get error =>
      this is AuthError ? (this as AuthError).error : null;
  UserModel? get user =>
      this is Authenticated ? (this as Authenticated).user : null;
  bool get isAdmin => user?.role == 'admin';
}
