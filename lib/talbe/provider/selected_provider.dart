import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_provider.g.dart';

@riverpod
class SelectedRow extends _$SelectedRow {
  @override
  Set<String> build() {
    return {};
  }

  void update(bool? value, String id) {
    // state = value == true ? {...state, id} : state
    //   ..remove(id);
    if (value ?? false) {
      state = {...state, id};
    } else {
      final newState = {...state};
      newState.remove(id);
      state = newState;
    }
  }

  void selectAll(bool? value) {
    if (value ?? false) {
      final allSet = List.generate(5000, (index) => 'ID$index').toSet();
      state = {...state, ...allSet};
    } else {
      final newState = {...state};
      newState.clear();
      state = newState;
    }
    print(state);
  }
}
