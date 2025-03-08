part of 'customers_bloc.dart';

@immutable
sealed class CustomersState {}

final class CustomersInitial extends CustomersState {}

class LoadCustomersSuccess extends CustomersState {
  final List<Customer> response;

  LoadCustomersSuccess(this.response);
}

class LoadCustomersFailure extends CustomersState {
  final String error;

  LoadCustomersFailure(this.error);
}

class LoadingCustomers extends CustomersState {
  LoadingCustomers();
}
