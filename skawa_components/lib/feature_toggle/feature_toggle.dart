import 'package:angular/angular.dart' show TemplateRef, ViewContainerRef, Directive, Input, Optional;
import 'package:meta/meta.dart' show visibleForTesting;

/// Base class for FeatureToggle directives that is queried
/// if a feature is enabled or not.
///
/// Used by [FeatureToggleEnabledDirective] & [FeatureToggleDisabledDirective]
abstract class FeatureToggleService {
  /// Determines if a feature is enabled or not
  bool isEnabled(String featureName);
}

@visibleForTesting
abstract class FeatureToggleBase {
  final FeatureToggleService toggleService;

  FeatureToggleBase(this.toggleService);

  bool shouldDisplay(String featureName);

  void toggleDisplay(String name, TemplateRef _templateRef, ViewContainerRef _viewContainer) {
    final isFeatureShown = shouldDisplay(name);
    // if feature is the same and its state is the same as previously,
    // do nothing
    if (name == _previousFeature && isFeatureShown == _previouslyShown) {
      return;
    }
    if (isFeatureShown) {
      _viewContainer.createEmbeddedView(_templateRef);
    } else {
      _viewContainer.clear();
    }
    _previouslyShown = isFeatureShown;
    _previousFeature = name;
  }

  bool _previouslyShown;
  String _previousFeature;
}

@Directive(
  selector: '[featureEnabled]',
)
class FeatureToggleEnabledDirective extends FeatureToggleBase {
  final TemplateRef _templateRef;
  final ViewContainerRef _viewContainer;

  FeatureToggleEnabledDirective(this._templateRef, this._viewContainer, @Optional() FeatureToggleService toggleService)
      : assert(toggleService != null),
        super(toggleService);

  @Input('featureEnabled')
  set featureName(String name) {
    toggleDisplay(name, _templateRef, _viewContainer);
  }

  @override
  bool shouldDisplay(String featureName) {
    return toggleService.isEnabled(featureName);
  }
}

@Directive(
  selector: '[featureDisabled]',
)
class FeatureToggleDisabledDirective extends FeatureToggleBase {
  final TemplateRef _templateRef;
  final ViewContainerRef _viewContainer;

  FeatureToggleDisabledDirective(this._templateRef, this._viewContainer, FeatureToggleService toggleService)
      : assert(toggleService != null),
        super(toggleService);

  @Input('featureDisabled')
  set featureName(String name) {
    toggleDisplay(name, _templateRef, _viewContainer);
  }

  @override
  bool shouldDisplay(String featureName) {
    return !toggleService.isEnabled(featureName);
  }
}
