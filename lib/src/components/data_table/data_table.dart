import 'package:angular2/angular2.dart';
import 'package:angular2/src/common/pipes/invalid_pipe_argument_exception.dart';
import 'package:angular_components/src/components/material_checkbox/material_checkbox.dart';

import 'data_table_column.dart';
import 'row_data.dart';

@Component(
    selector: 'skawa-data-table',
    templateUrl: 'data_table.html',
    directives: const [MaterialCheckboxComponent, NgIf, NgClass, NgFor],
    pipes: const [UnskippedInFooterPipe],
    styleUrls: const ['data_table.css'],
    changeDetection: ChangeDetectionStrategy.OnPush)
class SkawaDataTableComponent {
  @Input()
  bool selectable;

  @Input('data')
  Iterable<RowData> rows;

  @ContentChildren(SkawaDataTableColComponent)
  QueryList<SkawaDataTableColComponent> columns;

  final ChangeDetectorRef changeDetectorRef;

  SkawaDataTableComponent(this.changeDetectorRef);

  int getColspanFor(SkawaDataTableColComponent col, int skippedIndex) {
    int span = 1;
    if (skippedIndex == 0 && selectable) return 2;
    int colIndex = columns.toList().indexOf(col);
    for (int i = colIndex; i >= 0; i--) {
      int prevIndex = i - 1;
      if (prevIndex < 0) break;
      var prevCol = columns.elementAt(prevIndex);
      if (prevCol.skipFooter) {
        ++span;
      } else {
        break;
      }
    }
    return span;
  }

  void markAllRowsChecked(bool checked) {
    rows.forEach((row) => row.checked = checked);
  }

  bool get isEveryRowChecked => rows.every((row) => row.checked);
}

/// Filters for those [SkawaDataTableColComponent]s, that are not skipped in footer
///
/// Can set a column skipped by setting [skipFooter] to true
@Pipe('unskippedInFooter')
class UnskippedInFooterPipe implements PipeTransform {
  Iterable transform(Iterable data) {
    if (data is! Iterable) {
      throw new InvalidPipeArgumentException(UnskippedInFooterPipe, data);
    }
    return data.where((d) => d.skipFooter != true).toList();
  }
}
