**specialEffectModel.dart**

```dart
class SpecialEffectModel {
  final bool hasEffect;
  final bool hasState;
  SpecialEffectModel({
    this.hasEffect,
    this.hasState,
  });

  SpecialEffectModel copyWith({
    bool hasEffect,
    bool hasState,
  }) {
    return SpecialEffectModel(
      hasEffect: hasEffect ?? this.hasEffect,
      hasState: hasState ?? this.hasState,
    );
  }

  @override
  String toString() =>
      'SpecialEffectModel(hasEffect: $hasEffect, hasState: $hasState)';
}
```
