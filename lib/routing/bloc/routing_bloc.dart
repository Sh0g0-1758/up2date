import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'routing_event.dart';
part 'routing_state.dart';

class RoutingBloc extends Bloc<RoutingEvent, RoutingState> {
  RoutingBloc() : super(RoutingInitial()) {
    on<RoutingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
