part of 'customers_bloc.dart';

abstract class CustomersEvent extends Equatable {
  const CustomersEvent();
  @override
  List<Object> get props => [];
}

class LoadCustomersList extends CustomersEvent {
  const LoadCustomersList();
}
