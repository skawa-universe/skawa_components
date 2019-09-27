@TestOn('browser')
import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_test/angular_test.dart';
import 'package:pageloader/html.dart';
import 'package:skawa_material_components/data_table/data_table.dart';
import 'package:skawa_material_components/data_table/data_table_column.dart';
import 'package:test/test.dart';
import 'data_table_po.dart';

import 'data_table_test.template.dart' as ng;

void main() {
  ng.initReflector();
  tearDown(disposeAnyRunningTest);
  group('Datatable | ', () {
    test('initialization a non selectable datatable', () async {
      final fixture = await NgTestBed<NonSelectableDatatableTestComponent>().create();
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      final pageObject = TestPO.create(context);
      var table = pageObject.dataTable.table;
      expect(table.rootElement.classes.contains('non-selectable'), isTrue);
      expect(table.rootElement.classes.contains('selectable'), isFalse);
      expect(table.thead.tr.th.length, 2);
      expect(table.thead.tr.th[0].rootElement.innerText, 'Car make');
      expect(table.thead.tr.th[0].rootElement.classes.contains('text-column--header'), isTrue);
      expect(table.thead.tr.th[1].rootElement.innerText, 'My strong opinion');
      expect(table.tbody.tr[0].rootElement.classes.contains('trabant'), isTrue);
      int index = 0;
      table.tbody.tr.forEach((TableRowPO trElement) {
        expect(trElement.td.length, 2);
        expect(trElement.td[0].rootElement.classes.contains('text-column'), isTrue);
        expect(trElement.td[1].rootElement.innerText, rowData.rows[index].data.opinion);
        index++;
      });
    });
    test('initialization a non selectable datatable with a custom class on a column', () async {
      final fixture = await NgTestBed<NonSelectableDatatableTestComponent>()
          .create(beforeChangeDetection: (testComponent) => testComponent.cssClass = 'new-test-class');
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      final pageObject = TestPO.create(context);
      var table = pageObject.dataTable.table;
      expect(table.rootElement.classes.contains('non-selectable'), isTrue);
      expect(table.rootElement.classes.contains('selectable'), isFalse);
      expect(table.thead.tr.th.length, 2);
      expect(table.thead.tr.th[0].rootElement.innerText, 'Car make');
      expect(table.thead.tr.th[0].rootElement.classes.contains('text-column--header'), isTrue);
      expect(table.thead.tr.th[1].rootElement.innerText, 'My strong opinion');
      expect(table.thead.tr.th[1].rootElement.classes.contains('new-test-class--header'), isTrue);
      int index = 0;
      table.tbody.tr.forEach((TableRowPO trElement) async {
        expect(trElement.td.length, 2);
        expect(trElement.td[0].rootElement.innerText, rowData.rows[index].data.name);
        expect(trElement.td[0].rootElement.classes.contains('text-column'), isTrue);
        expect(trElement.td[1].rootElement.innerText, rowData.rows[index].data.opinion);
        expect(trElement.td[1].rootElement.classes.contains('new-test-class'), isTrue);
        index++;
      });
    });
    test('initialization a selectable datatable', () async {
      final fixture = await NgTestBed<SelectableDatatableTestComponent>().create();
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      final pageObject = TestPO.create(context);
      var table = pageObject.dataTable.table;
      expect(table.rootElement.classes.contains('selectable'), isTrue);
      expect(table.rootElement.classes.contains('non-selectable'), isFalse);
      expect(table.tfoot.tr[0].td.length, 4);
      expect(table.thead.tr.th.length, 5);
      expect(table.thead.tr.th[1].rootElement.innerText, 'Class');
      expect(table.thead.tr.th[2].rootElement.innerText, 'Male');
      expect(table.thead.tr.th[3].rootElement.innerText, 'Female');
      expect(table.thead.tr.th[4].rootElement.innerText, 'All');
      expect(table.thead.tr.th[0].rootElement.classes.contains('selected'), isFalse);
      expect(table.thead.tr.th[1].rootElement.classes.contains('text-column--header'), isTrue);
      int index = 0;
      table.tbody.tr.forEach((TableRowPO trElement) {
        int male = selectableRowData.rows[index].data.male;
        int female = selectableRowData.rows[index].data.female;
        expect(trElement.rootElement.classes.contains('selected'), isFalse);
        expect(trElement.td.length, 5);
        expect(trElement.td[1].rootElement.classes.contains('text-column'), isTrue);
        expect(trElement.td[1].rootElement.innerText, selectableRowData.rows[index].data.category);
        expect(trElement.td[2].rootElement.innerText, male.toString());
        expect(trElement.td[3].rootElement.innerText, female.toString());
        expect(trElement.td[4].rootElement.innerText, (male + female).toString());
        expect(trElement.td[0].rootElement.classes.contains('selected'), isFalse);
        expect(trElement.td[0].materialCheckbox, isNotNull);
        index++;
      });
      var trElement = table.tfoot.tr[0];
      expect(trElement.td[0].rootElement.innerText, 'Total:');
      expect(trElement.td[0].rootElement.classes.contains('text-column--footer'), isTrue);
      expect(trElement.td[1].rootElement.innerText, '-');
      expect(trElement.td[2].rootElement.innerText, '-');
      expect(trElement.td[3].rootElement.innerText, '-');
    });
    test('selectable datatable then selectall', () async {
      final fixture = await NgTestBed<SelectableDatatableTestComponent>().create();
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      final pageObject = TestPO.create(context);
      var table = pageObject.dataTable.table;
      await table.thead.tr.th[0].materialCheckbox.click();
      expect(table.rootElement.classes.contains('selectable'), isTrue);
      expect(table.rootElement.classes.contains('non-selectable'), isFalse);
      expect(table.tfoot.tr[0].td.length, 4);
      expect(table.thead.tr.th.length, 5);
      expect(table.thead.tr.th[1].rootElement.innerText, 'Class');
      expect(table.thead.tr.th[2].rootElement.innerText, 'Male');
      expect(table.thead.tr.th[3].rootElement.innerText, 'Female');
      expect(table.thead.tr.th[4].rootElement.innerText, 'All');
      expect(table.thead.tr.th[0].rootElement.classes.contains('selected'), isFalse);
      expect(table.thead.tr.th[1].rootElement.classes.contains('text-column--header'), isTrue);
      int index = 0;
      table.tbody.tr.forEach((TableRowPO trElement) async {
        int male = selectableRowData.rows[index].data.male;
        int female = selectableRowData.rows[index].data.female;
        expect(trElement.rootElement.classes.contains('selected'), isTrue);
        expect(trElement.td.length, 5);
        expect(trElement.td[1].rootElement.classes.contains('text-column'), isTrue);
        expect(trElement.td[1].rootElement.innerText, selectableRowData.rows[index].data.category);
        expect(trElement.td[2].rootElement.innerText, male.toString());
        expect(trElement.td[3].rootElement.innerText, female.toString());
        expect(trElement.td[4].rootElement.innerText, (male + female).toString());
        expect(trElement.td[0].rootElement.classes.contains('selected'), isFalse);
        expect(trElement.td[0].materialCheckbox, isNotNull);
        index++;
      });
      var trElement = table.tfoot.tr[0];
      expect(trElement.td[0].rootElement.innerText, 'Total:');
      expect(trElement.td[0].rootElement.classes.contains('text-column--footer'), isTrue);
      expect(trElement.td[1].rootElement.innerText, '59');
      expect(trElement.td[2].rootElement.innerText, '56');
      expect(trElement.td[3].rootElement.innerText, '115');
    });
    test('selectable datatable then select second and fourth row', () async {
      final fixture = await NgTestBed<SelectableDatatableTestComponent>().create();
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      final pageObject = TestPO.create(context);
      var table = pageObject.dataTable.table;
      await table.tbody.tr[1].td[0].materialCheckbox.click();
      await table.tbody.tr[3].td[0].materialCheckbox.click();
      expect(table.tbody.tr[0].rootElement.classes.contains('selected'), isTrue);
      expect(table.tbody.tr[1].rootElement.classes.contains('selected'), isFalse);
      expect(table.tbody.tr[2].rootElement.classes.contains('selected'), isTrue);
//      expect(table.tbody.tr[3].rootElement.classes.contains('selected'), isFalse);
      expect(table.rootElement.classes.contains('selectable'), isTrue);
      expect(table.rootElement.classes.contains('non-selectable'), isFalse);
      expect(table.tfoot.tr[0].td.length, 4);
      expect(table.thead.tr.th.length, 5);
      expect(table.thead.tr.th[1].rootElement.innerText, 'Class');
      expect(table.thead.tr.th[2].rootElement.innerText, 'Male');
      expect(table.thead.tr.th[3].rootElement.innerText, 'Female');
      expect(table.thead.tr.th[4].rootElement.innerText, 'All');
      expect(table.thead.tr.th[0].rootElement.classes.contains('selected'), isFalse);
      expect(table.thead.tr.th[1].rootElement.classes.contains('text-column--header'), isTrue);
      int index = 0;
      Future.forEach(table.tbody.tr, (TableRowPO trElement) async {
        int male = selectableRowData.rows[index].data.male;
        int female = selectableRowData.rows[index].data.female;
        expect(trElement.td.length, 5);
        expect(trElement.td[1].rootElement.classes.contains('text-column'), isTrue);
        expect(trElement.td[1].rootElement.innerText, selectableRowData.rows[index].data.category);
        expect(trElement.td[2].rootElement.innerText, male.toString());
        expect(trElement.td[3].rootElement.innerText, female.toString());
        expect(trElement.td[4].rootElement.innerText, (male + female).toString());
        expect(trElement.td[0].rootElement.classes.contains('selected'), isFalse);
        expect(trElement.td[0].materialCheckbox, isNotNull);
        index++;
      });
      var trElement = table.tfoot.tr[0];
      expect(trElement.td[0].rootElement.innerText, 'Total:');
      expect(trElement.td[0].rootElement.classes.contains('text-column--footer'), isTrue);
//      expect(trElement.td[1].rootElement.innerText, '28');
//      expect(trElement.td[2].rootElement.innerText, '25');
//      expect(trElement.td[3].rootElement.innerText, '53');
    });

    test('sortable datatable sort descending by second column', () async {
      final fixture = await NgTestBed<SelectableDatatableTestComponent>().create();
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      final pageObject = TestPO.create(context);
      var table = pageObject.dataTable.table;

      expect(table.tfoot.tr[0].td.length, 4);
      expect(table.thead.tr.th.length, 5);
      expect(table.thead.tr.th[1].rootElement.innerText, 'Class');
      expect(table.thead.tr.th[2].rootElement.innerText, 'Male');
      expect(table.thead.tr.th[3].rootElement.innerText, 'Female');
      expect(table.thead.tr.th[4].rootElement.innerText, 'All');

      expect(table.thead.tr.th[2].rootElement.classes.contains('sort'), isFalse);
      expect(table.thead.tr.th[2].rootElement.classes.contains('desc'), isFalse);

      var trElement = table.tbody.tr[0];
      expect(trElement.td[1].rootElement.innerText, '1. class');
      expect(trElement.td[2].rootElement.innerText, '15');
      expect(trElement.td[3].rootElement.innerText, '12');
      expect(trElement.td[4].rootElement.innerText, '27');

      trElement = table.tbody.tr[3];
      expect(trElement.td[1].rootElement.innerText, '4. class');
      expect(trElement.td[2].rootElement.innerText, '20');
      expect(trElement.td[3].rootElement.innerText, '13');
      expect(trElement.td[4].rootElement.innerText, '33');

      await table.thead.tr.th[2].sortLink.click();
      expect(table.thead.tr.th[2].rootElement.classes.contains('sort'), isTrue);
      expect(table.thead.tr.th[2].rootElement.classes.contains('desc'), isFalse);

      await table.thead.tr.th[2].sortLink.click();
      expect(table.thead.tr.th[2].rootElement.classes.contains('sort'), isTrue);
      expect(table.thead.tr.th[2].rootElement.classes.contains('desc'), isTrue);

      table = pageObject.dataTable.table;
      trElement = table.tbody.tr[0];
      expect(trElement.td[1].rootElement.innerText, '4. class');
      expect(trElement.td[2].rootElement.innerText, '20');
      expect(trElement.td[3].rootElement.innerText, '13');
      expect(trElement.td[4].rootElement.innerText, '33');

      trElement = table.tbody.tr[1];
      expect(trElement.td[1].rootElement.innerText, '1. class');
      expect(trElement.td[2].rootElement.innerText, '15');
      expect(trElement.td[3].rootElement.innerText, '12');
      expect(trElement.td[4].rootElement.innerText, '27');
    });

    test('resorting updates odd classes properly', () async {
      final fixture = await NgTestBed<SortableDatatableTestComponent>().create();
      final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      final pageObject = TestPO.create(context);
      var rows = pageObject.dataTable.table.tbody.tr;

      final oddMatcher = (bool shouldBeOdd) {
        return predicate<String>((m) => m.contains('odd') == shouldBeOdd);
      };

      for (int i = 0; i < rows.length; ++i) {
        bool shouldBeOdd = i % 2 != 0;
        final row = rows[i];
        expect(row.classes, oddMatcher(shouldBeOdd));
      }

      await pageObject.dataTable.table.thead.tr.th.first.sortLink.click();
      await fixture.update();
      rows = pageObject.dataTable.table.tbody.tr;
      for (int i = 0; i < rows.length; ++i) {
        bool shouldBeOdd = i % 2 != 0;
        final row = rows[i];
        expect(row.classes, oddMatcher(shouldBeOdd));
      }
    });
  });
}

@Component(
    selector: 'test',
    template: '''
    <skawa-data-table [data]="data" [selectable]="false" [columns]="columns">
    </skawa-data-table>
     ''',
    directives: [SkawaDataTableComponent, SkawaDataTableColComponent],
    directiveTypes: [Typed<SkawaDataTableComponent<SampleRowData>>()])
class NonSelectableDatatableTestComponent {
  String cssClass;

  static String makeAccessor(SampleRowData row) => row.name;

  static String opinionAccessor(SampleRowData row) => row.opinion;

  TableRows<SampleRowData> get data => rowData;

  List<SkawaDataTableColComponent<SampleRowData, dynamic>> columns = [
    SkawaDataTableColComponent<SampleRowData, dynamic>()
      ..accessor = makeAccessor
      ..header = 'Car make',
    SkawaDataTableColComponent<SampleRowData, dynamic>()
      ..accessor = opinionAccessor
      ..header = 'My strong opinion'
  ];
}

TableRows<SampleRowData> rowData = TableRows([
  SampleRowData('Trabant', 'Eastern delight'),
  SampleRowData('Jaguar', 'Hrrrrr'),
  SampleRowData('Ford', 'Something for everybody'),
  SampleRowData('Renault', 'Well, RedBull F1 team uses them, why not?')
]);

@Component(
    selector: 'test',
    template: '''
    <skawa-data-table [data]="rowData" [selectable]="true" (sort)="sort(\$event)" [columns]="columns">
    </skawa-data-table>
     ''',
    directives: [SkawaDataTableComponent, SkawaDataTableColComponent, SortDirective],
    directiveTypes: [Typed<SkawaDataTableComponent<SampleNumericData>>()])
class SelectableDatatableTestComponent {
  List<SkawaDataTableColComponent<SampleNumericData, dynamic>> columns = [
    SkawaDataTableColComponent<SampleNumericData, dynamic>()
      ..accessor = categoryAccessor
      ..header = 'Class'
      ..footer = 'Total:'
      ..skipFooter = false,
    SkawaDataTableColComponent<SampleNumericData, dynamic>()
      ..accessor = maleAccessor
      ..header = 'Male'
      ..footer = aggregate(maleAccessor)
      ..skipFooter = false,
    SkawaDataTableColComponent<SampleNumericData, dynamic>()
      ..accessor = femaleAccessor
      ..header = 'Female'
      ..footer = aggregate(femaleAccessor)
      ..skipFooter = false,
    SkawaDataTableColComponent<SampleNumericData, dynamic>()
      ..accessor = peopleAccessor
      ..header = 'All'
      ..footer = aggregate(peopleAccessor)
      ..skipFooter = false,
  ];

  static String categoryAccessor(SampleNumericData row) => row.category;

  static String maleAccessor(SampleNumericData row) => row.male.toString();

  static String femaleAccessor(SampleNumericData row) => row.female.toString();

  static String peopleAccessor(SampleNumericData row) => (row.female + row.male).toString();

  static String aggregate(DataTableAccessor<SampleNumericData, String> accessor) {
//    Iterable<String> mapped = rowData.rows
//        .where((TableRow<SampleNumericData> row) => row.checked)
//        .map((TableRow<SampleNumericData> row) => accessor(row.data));
//    return mapped.isNotEmpty ? mapped.reduce(_aggregateReducer) : '-';
  return '';
  }

  void sort(SkawaDataTableColComponent column) {
    if (!column.sortModel.isSorted) {
      // Apply default sorting when no sort is specified
      rowData.rows.sort((a, b) => a.data.category.compareTo(b.data.category));
    } else {
      rowData.rows.sort((a, b) {
        if (column.header == 'Male') {
          return column.sortModel.isAscending ? a.data.male - b.data.male : b.data.male - a.data.male;
        } else if (column.header == 'Female') {
          return column.sortModel.isAscending ? a.data.female - b.data.female : b.data.female - a.data.female;
        } else if (column.header == 'All') {
          return (b.data.male + b.data.female) - (a.data.male + a.data.female);
        }
        return 0;
      });
    }
  }

//  String _aggregateReducer(String a, String b) {
//    if (a == null || b == null) return a ?? b;
//    return (int.parse(a) + int.parse(b)).toString();
//  }

  TableRows<SampleNumericData> get rowData => selectableRowData;
}

@Component(
    selector: 'test',
    template: '''
    <skawa-data-table [data]="data" (sort)="sort(\$event)" [selectable]="false" [columns]="columns">
    </skawa-data-table>
     ''',
    directives: [SkawaDataTableComponent, SkawaDataTableColComponent, SortDirective],
    directiveTypes: [Typed<SkawaDataTableComponent<SortableRowData>>()])
class SortableDatatableTestComponent {
  List<SkawaDataTableColComponent<SortableRowData, dynamic>> columns = [
    SkawaDataTableColComponent<SortableRowData, String>()
      ..accessor = dataAccessor
      ..header = 'Test column'
  ];
  static String dataAccessor(SortableRowData row) => row.data;

  TableRows<SortableRowData> get data => TableRows(_sortableDataset);

  void sort(SkawaDataTableColComponent column) {
    if (!column.sortModel.isSorted) {
      _sortableDataset.sort((a, b) => a.data.compareTo(b.data));
    } else {
      // sort in lexicographic order
      _sortableDataset.sort((a, b) {
        return column.sortModel.isAscending ? a.data.compareTo(b.data) : b.data.compareTo(a.data);
      });
    }
  }

  static final _sortableDataset = <SortableRowData>[
    SortableRowData('b'),
    SortableRowData('a'),
    SortableRowData('d'),
    SortableRowData('c'),
  ];
}

TableRows<SampleNumericData> selectableRowData = TableRows([
  SampleNumericData('1. class', 15, 12),
  SampleNumericData('2. class', 11, 18),
  SampleNumericData('3. class', 13, 13),
  SampleNumericData('4. class', 20, 13)
]);

class SortableRowData {
  final String data;

  SortableRowData(this.data);
}

class SampleRowData {
  final String name;

  final String opinion;

  SampleRowData(this.name, this.opinion);
}

class SampleNumericData {
  final String category;
  final int male;
  final int female;

  SampleNumericData(this.category, this.male, this.female);
}
