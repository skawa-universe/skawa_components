import 'package:angular/angular.dart';
import 'package:angular_components/model/ui/toggle.dart';

import '../sidebar/sidebar.dart';

/// Drawer serves as a navigational side panel. (See more at)[https://material.io/guidelines/patterns/navigation-drawer.html#]
///
/// __Example usage:__
///     <skawa-drawer></skawa-drawer>
///     <skawa-drawer [isOn]="sidebarIsOpen"></skawa-drawer>
///     <skawa-drawer><logo-cmp class=".logo-area"></logo-cmp></skawa-drawer>
///     <skawa-drawer><some-cmp></some-cmp></skawa-drawer>
///     <skawa-drawer><logo-cmp class=".logo-area"></logo-cmp><some-cmp></some-cmp></skawa-drawer>
///
/// __Properties:__
/// - `isOn: bool` -- Whether to display the sidebar. Defaults to false.
///
@Component(
  selector: 'skawa-drawer',
  styleUrls: const ['drawer.css'],
  templateUrl: 'drawer.html',
  host: const {'[class.opened]': 'isOn'},
  inputs: const ['isOn'],
  directives: const [SkawaSidebarComponent, NgClass],
)
class SkawaDrawerComponent extends Toggleable {}
