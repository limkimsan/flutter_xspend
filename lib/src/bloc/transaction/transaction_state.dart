part of 'transaction_bloc.dart';

class TransactionState extends Equatable {
  const TransactionState({required this.transactions});

  final List<Transaction> transactions;

  @override
  List<Object> get props => transactions;
}

class TransactionInitialState extends TransactionState {
  TransactionInitialState() : super(transactions: <Transaction>[]);

  @override
  List<Object> get props => [];
}

class TransactionLoadedState extends TransactionState {
  const TransactionLoadedState({ required this.newTransactions }) : super(transactions: newTransactions);
  final List<Transaction> newTransactions;

  @override
  List<Object> get props => newTransactions;
}