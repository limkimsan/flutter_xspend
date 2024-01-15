part of 'transaction_bloc.dart';

class TransactionEvent extends Equatable {
  const TransactionEvent();
  
  @override
  List<Object> get props => [];
}

class LoadTransaction extends TransactionEvent {
  const LoadTransaction({ this.transactions = const <Transaction>[] });
  final List<Transaction> transactions;
  @override
  List<Object> get props => transactions;
}

class AddNewTransaction extends TransactionEvent {
  const AddNewTransaction({ required this.transaction });
  final Transaction transaction;
  @override
  List<Object> get props => [transaction];
}