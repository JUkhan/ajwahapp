import 'package:ajwah_bloc/ajwah_bloc.dart';
import '../models/specialEffectModel.dart';

void registerSpecialEffectState() {
  registerState<SpecialEffectModel>(
    stateName: 'special-effect',
    initialState: SpecialEffectModel(hasEffect: false, hasState: false),
    mapActionToState: (state, action, emit) {
      switch (action.type) {
        case 'registerEffect(effectKey)':
          emit(state.copyWith(hasEffect: true));
          break;
        case 'unregisterEffect(effectKey)':
          emit(state.copyWith(hasEffect: false));
          break;
        case 'registerState(counter)':
          emit(state.copyWith(hasState: true));
          break;
        case 'unregisterState(counter)':
          emit(state.copyWith(hasState: false));
          break;
        default:
      }
    },
  );
}
