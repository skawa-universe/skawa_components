import 'package:angular/angular.dart';
import 'package:diff_match_patch/diff_match_patch.dart';

/// This is an angular wrapper around the `https://github.com/jheyne/diff-match-patch`

@Component(
    selector: 'diff',
    templateUrl: 'diff.html',
    styleUrls: ['diff.css'],
    directives: [NgIf, NgFor],
    exports: [DIFF_DELETE, DIFF_EQUAL, DIFF_INSERT],
    changeDetection: ChangeDetectionStrategy.OnPush)
class DiffComponent {
  @Input()
  List<Diff> diffList;
}
