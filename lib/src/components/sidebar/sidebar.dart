import 'package:angular2/core.dart';
import 'package:angular_components/src/model/ui/toggle.dart';

@Component(
  selector: 'skawa-sidebar',
  styleUrls: const ['sidebar.css'],
  templateUrl: 'sidebar.html',
  inputs: const ['isOn'],
  host: const {'[class.opened]': 'isOn'},
)
class SkawaSidebarComponent extends Toggleable {
}
