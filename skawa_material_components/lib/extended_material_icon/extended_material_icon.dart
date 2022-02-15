import 'package:angular/angular.dart';

/// A material styled icon component. On the top of the official icons it is containing
/// at least 3000 icons from the community. Currently this component supports only the dead-weight way.
///
/// This stylesheet should be included at the top of the page:
///
/// ```html
/// <link
///     rel="stylesheet"
///     type="text/css"
///     href="https://cdn.materialdesignicons.com/3.4.93/css/materialdesignicons.min.css">
/// ```
///
/// __Attributes:__
///
/// - `size: String` -- The size of the icon. Options are: `x-small`, `small`,
///   `medium`, `large`, and `x-large`, corresponding to 12px, 13px, 16px, 18px,
///    and 20px, respectively. If no size is specified, the default of 24px is
///    used.
/// - `flipVertical` -- Whether the icon should be flipped vertically.
/// - `flipHorizontal` -- Whether the icon should be flipped horizontally.
/// - `rotate` -- With how many degree should the icon rotated. Usable only with multiple of 45.
///             Works only if flipVertical and flipHorizontal false.
/// - `spin` -- Should the icon spinning.
///
@Component(
    selector: 'extended-material-icon',
    templateUrl: 'extended_material_icon.html',
    styleUrls: ['extended_material_icon.css'],
    directives: [NgClass],
    changeDetection: ChangeDetectionStrategy.OnPush)
class ExtendedMaterialIconComponent {
  @Input()
  String? icon;

  @Input()
  bool flipVertical = false;

  @Input()
  bool flipHorizontal = false;

  @Input()
  bool spin = false;

  @Input()
  int? rotate;

  Map<String, bool> get extraClasses => {
        "mdi-flip-h": flipHorizontal,
        "mdi-flip-v": flipVertical,
        "mdi-spin": spin,
        'mdi-rotate-${(rotate ?? 0) % 360}': !flipHorizontal && !flipVertical && rotate != null && rotate! % 45 == 0
      };
}
