@Tags(const ['aot'])
@TestOn('browser')
import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_test/angular_test.dart';
import 'package:pageloader/objects.dart';
import 'package:pageloader/src/annotations.dart';
import 'package:skawa_material_components/data_table/data_table.dart';
import 'package:skawa_material_components/data_table/data_table_column.dart';
import 'package:skawa_material_components/data_table/row_data.dart';
import 'package:test/test.dart';

void main() {
  tearDown(disposeAnyRunningTest);
  group('Datatable | ', () {
    test('initialization a non selectable datatable', () async {
      final fixture = await new NgTestBed<NonSelectableDatatableTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      var table = pageObject.dataTable.table;
      expect(await table.rootElement.classes.contains('non-selectable'), isTrue);
      expect(await table.rootElement.classes.contains('selectable'), isFalse);
      expect(await table.tfoot, isNull);
      expect(await table.thead.tr.th.length, 2);
      expect(await table.thead.tr.th[0].rootElement.innerText, 'Car make');
      expect(await table.thead.tr.th[0].rootElement.classes.contains('text-column--header'), isTrue);
      expect(await table.thead.tr.th[1].rootElement.innerText, 'My strong opinion');
      Future.forEach(table.tbody.tr, (trElement) async {
        expect(trElement.td.length, 2);
        int index = pageObject.dataTable.table.tbody.tr.indexOf(trElement);
        expect(await trElement.td[0].rootElement.innerText, (rowData[index] as SampleRowData).name);
        expect(await trElement.td[0].rootElement.classes.contains('text-column'), isTrue);
        expect(await trElement.td[1].rootElement.innerText, (rowData[index] as SampleRowData).opinion);
      });
    });
    test('initialization a non selectable datatable with a custom class on a column', () async {
      final fixture =
          await new NgTestBed<NonSelectableDatatableTestComponent>().create(beforeChangeDetection: (testComponent) {
        testComponent.cssClass = 'new-test-class';
      });
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      var table = pageObject.dataTable.table;
      expect(await table.rootElement.classes.contains('non-selectable'), isTrue);
      expect(await table.rootElement.classes.contains('selectable'), isFalse);
      expect(await table.thead.tr.th.length, 2);
      expect(await table.thead.tr.th[0].rootElement.innerText, 'Car make');
      expect(await table.thead.tr.th[0].rootElement.classes.contains('text-column--header'), isTrue);
      expect(await table.thead.tr.th[1].rootElement.innerText, 'My strong opinion');
      expect(await table.thead.tr.th[1].rootElement.classes.contains('new-test-class--header'), isTrue);
      Future.forEach(table.tbody.tr, (trElement) async {
        expect(trElement.td.length, 2);
        int index = pageObject.dataTable.table.tbody.tr.indexOf(trElement);
        expect(await trElement.td[0].rootElement.innerText, (rowData[index] as SampleRowData).name);
        expect(await trElement.td[0].rootElement.classes.contains('text-column'), isTrue);
        expect(await trElement.td[1].rootElement.innerText, (rowData[index] as SampleRowData).opinion);
        expect(await trElement.td[1].rootElement.classes.contains('new-test-class'), isTrue);
      });
    });
    test('initialization a selectable datatable', () async {
      final fixture = await new NgTestBed<SelectableDatatableTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      var table = pageObject.dataTable.table;
      expect(await table.rootElement.classes.contains('selectable'), isTrue);
      expect(await table.rootElement.classes.contains('non-selectable'), isFalse);
      expect(await table.tfoot.tr[0].td.length, 4);
      expect(await table.thead.tr.th.length, 5);
      expect(await table.thead.tr.th[1].rootElement.innerText, 'Class');
      expect(await table.thead.tr.th[2].rootElement.innerText, 'Male');
      expect(await table.thead.tr.th[3].rootElement.innerText, 'Female');
      expect(await table.thead.tr.th[4].rootElement.innerText, 'All');
      expect(await table.thead.tr.th[0].rootElement.classes.contains('selected'), isFalse);
      expect(await table.thead.tr.th[1].rootElement.classes.contains('text-column--header'), isTrue);
      Future.forEach(table.tbody.tr, (TableRowPO trElement) async {
        int index = pageObject.dataTable.table.tbody.tr.indexOf(trElement);
        int male = (selectableRowData[index] as SampleNumericData).male;
        int female = (selectableRowData[index] as SampleNumericData).female;
        expect(await trElement.rootElement.classes.contains('selected'), isFalse);
        expect(trElement.td.length, 5);
        expect(await trElement.td[1].rootElement.classes.contains('text-column'), isTrue);
        expect(await trElement.td[1].rootElement.innerText, (selectableRowData[index] as SampleNumericData).category);
        expect(await trElement.td[2].rootElement.innerText, male.toString());
        expect(await trElement.td[3].rootElement.innerText, female.toString());
        expect(await trElement.td[4].rootElement.innerText, (male + female).toString());
        expect(await trElement.td[0].rootElement.classes.contains('selected'), isFalse);
        expect(await trElement.td[0].materialCheckbox, isNotNull);
      });
      var trElement = table.tfoot.tr[0];
      expect(await trElement.td[0].rootElement.innerText, 'Total:');
      expect(await trElement.td[0].rootElement.classes.contains('text-column--footer'), isTrue);
      expect(await trElement.td[1].rootElement.innerText, '-');
      expect(await trElement.td[2].rootElement.innerText, '-');
      expect(await trElement.td[3].rootElement.innerText, '-');
    });
    test('selectable datatable then selectall', () async {
      final fixture = await new NgTestBed<SelectableDatatableTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      var table = pageObject.dataTable.table;
      await table.thead.tr.th[0].materialCheckbox.click();
      expect(await table.rootElement.classes.contains('selectable'), isTrue);
      expect(await table.rootElement.classes.contains('non-selectable'), isFalse);
      expect(await table.tfoot.tr[0].td.length, 4);
      expect(await table.thead.tr.th.length, 5);
      expect(await table.thead.tr.th[1].rootElement.innerText, 'Class');
      expect(await table.thead.tr.th[2].rootElement.innerText, 'Male');
      expect(await table.thead.tr.th[3].rootElement.innerText, 'Female');
      expect(await table.thead.tr.th[4].rootElement.innerText, 'All');
      expect(await table.thead.tr.th[0].rootElement.classes.contains('selected'), isFalse);
      expect(await table.thead.tr.th[1].rootElement.classes.contains('text-column--header'), isTrue);
      Future.forEach(table.tbody.tr, (TableRowPO trElement) async {
        int index = pageObject.dataTable.table.tbody.tr.indexOf(trElement);
        int male = (selectableRowData[index] as SampleNumericData).male;
        int female = (selectableRowData[index] as SampleNumericData).female;
        expect(await trElement.rootElement.classes.contains('selected'), isTrue);
        expect(trElement.td.length, 5);
        expect(await trElement.td[1].rootElement.classes.contains('text-column'), isTrue);
        expect(await trElement.td[1].rootElement.innerText,
            (selectableRowData[table.tbody.tr.indexOf(trElement)] as SampleNumericData).category);
        expect(await trElement.td[2].rootElement.innerText, male.toString());
        expect(await trElement.td[3].rootElement.innerText, female.toString());
        expect(await trElement.td[4].rootElement.innerText, (male + female).toString());
        expect(await trElement.td[0].rootElement.classes.contains('selected'), isFalse);
        expect(await trElement.td[0].materialCheckbox, isNotNull);
      });
      var trElement = table.tfoot.tr[0];
      expect(await trElement.td[0].rootElement.innerText, 'Total:');
      expect(await trElement.td[0].rootElement.classes.contains('text-column--footer'), isTrue);
      expect(await trElement.td[1].rootElement.innerText, '59');
      expect(await trElement.td[2].rootElement.innerText, '56');
      expect(await trElement.td[3].rootElement.innerText, '115');
    });
    test('selectable datatable then select second and fourth row', () async {
      final fixture = await new NgTestBed<SelectableDatatableTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      var table = pageObject.dataTable.table;
      await table.tbody.tr[1].td[0].materialCheckbox.click();
      await table.tbody.tr[3].td[0].materialCheckbox.click();
      expect(await table.tbody.tr[0].rootElement.classes.contains('selected'), isTrue);
      expect(await table.tbody.tr[1].rootElement.classes.contains('selected'), isFalse);
      expect(await table.tbody.tr[2].rootElement.classes.contains('selected'), isTrue);
      expect(await table.tbody.tr[3].rootElement.classes.contains('selected'), isFalse);
      expect(await table.rootElement.classes.contains('selectable'), isTrue);
      expect(await table.rootElement.classes.contains('non-selectable'), isFalse);
      expect(await table.tfoot.tr[0].td.length, 4);
      expect(await table.thead.tr.th.length, 5);
      expect(await table.thead.tr.th[1].rootElement.innerText, 'Class');
      expect(await table.thead.tr.th[2].rootElement.innerText, 'Male');
      expect(await table.thead.tr.th[3].rootElement.innerText, 'Female');
      expect(await table.thead.tr.th[4].rootElement.innerText, 'All');
      expect(await table.thead.tr.th[0].rootElement.classes.contains('selected'), isFalse);
      expect(await table.thead.tr.th[1].rootElement.classes.contains('text-column--header'), isTrue);
      Future.forEach(table.tbody.tr, (TableRowPO trElement) async {
        int index = pageObject.dataTable.table.tbody.tr.indexOf(trElement);
        int male = (selectableRowData[index] as SampleNumericData).male;
        int female = (selectableRowData[index] as SampleNumericData).female;
        expect(trElement.td.length, 5);
        expect(await trElement.td[1].rootElement.classes.contains('text-column'), isTrue);
        expect(await trElement.td[1].rootElement.innerText,
            (selectableRowData[table.tbody.tr.indexOf(trElement)] as SampleNumericData).category);
        expect(await trElement.td[2].rootElement.innerText, male.toString());
        expect(await trElement.td[3].rootElement.innerText, female.toString());
        expect(await trElement.td[4].rootElement.innerText, (male + female).toString());
        expect(await trElement.td[0].rootElement.classes.contains('selected'), isFalse);
        expect(await trElement.td[0].materialCheckbox, isNotNull);
      });
      var trElement = table.tfoot.tr[0];
      expect(await trElement.td[0].rootElement.innerText, 'Total:');
      expect(await trElement.td[0].rootElement.classes.contains('text-column--footer'), isTrue);
      expect(await trElement.td[1].rootElement.innerText, '28');
      expect(await trElement.td[2].rootElement.innerText, '25');
      expect(await trElement.td[3].rootElement.innerText, '53');
    });

    test('sortable datatable sort descending by second column', () async {
      final fixture = await new NgTestBed<SelectableDatatableTestComponent>().create();
      final pageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      var table = pageObject.dataTable.table;

      expect(await table.tfoot.tr[0].td.length, 4);
      expect(await table.thead.tr.th.length, 5);
      expect(await table.thead.tr.th[1].rootElement.innerText, 'Class');
      expect(await table.thead.tr.th[2].rootElement.innerText, 'Male');
      expect(await table.thead.tr.th[3].rootElement.innerText, 'Female');
      expect(await table.thead.tr.th[4].rootElement.innerText, 'All');

      expect(await table.thead.tr.th[2].rootElement.classes.contains('sort'), isFalse);
      expect(await table.thead.tr.th[2].rootElement.classes.contains('desc'), isFalse);

      var trElement = table.tbody.tr[0];
      expect(await trElement.td[1].rootElement.innerText, '1. class');
      expect(await trElement.td[2].rootElement.innerText, '15');
      expect(await trElement.td[3].rootElement.innerText, '12');
      expect(await trElement.td[4].rootElement.innerText, '27');

      trElement = table.tbody.tr[3];
      expect(await trElement.td[1].rootElement.innerText, '4. class');
      expect(await trElement.td[2].rootElement.innerText, '20');
      expect(await trElement.td[3].rootElement.innerText, '13');
      expect(await trElement.td[4].rootElement.innerText, '33');

      await table.thead.tr.th[2].sortLink.click();
      expect(await table.thead.tr.th[2].rootElement.classes.contains('sort'), isTrue);
      expect(await table.thead.tr.th[2].rootElement.classes.contains('desc'), isFalse);

      await table.thead.tr.th[2].sortLink.click();
      expect(await table.thead.tr.th[2].rootElement.classes.contains('sort'), isTrue);
      expect(await table.thead.tr.th[2].rootElement.classes.contains('desc'), isTrue);

      final updatedPageObject = await fixture.resolvePageObject/*<TestPO>*/(TestPO);
      table = updatedPageObject.dataTable.table;
      trElement = table.tbody.tr[0];
      expect(await trElement.td[1].rootElement.innerText, '4. class');
      expect(await trElement.td[2].rootElement.innerText, '20');
      expect(await trElement.td[3].rootElement.innerText, '13');
      expect(await trElement.td[4].rootElement.innerText, '33');

      trElement = table.tbody.tr[1];
      expect(await trElement.td[1].rootElement.innerText, '1. class');
      expect(await trElement.td[2].rootElement.innerText, '15');
      expect(await trElement.td[3].rootElement.innerText, '12');
      expect(await trElement.td[4].rootElement.innerText, '27');
    });
  });
}

@Component(
    selector: 'test',
    template: '''
    <skawa-data-table [data]="data" [selectable]="false">
       <skawa-data-table-col [accessor]="makeAccessor" header="Car make" class="text-column"></skawa-data-table-col>
       <skawa-data-table-col [accessor]="opinionAccessor" header="My strong opinion" [class]="cssClass"></skawa-data-table-col>
    </skawa-data-table>
     ''',
    directives: const [SkawaDataTableComponent, SkawaDataTableColComponent])
class NonSelectableDatatableTestComponent {
  String cssClass;

  String makeAccessor(SampleRowData row) => row.name;

  String opinionAccessor(SampleRowData row) => row.opinion;

  List<RowData> get data => rowData;
}

List<RowData> rowData = <SampleRowData>[
  new SampleRowData('Trabant', 'Definitely not!'),
  new SampleRowData('Barkasz', 'Same as Trabant!'),
  new SampleRowData('Lada', 'Let the Russians have it!'),
  new SampleRowData('Renault', 'Well, RedBull F1 team uses them, why not?'),
];

@Component(
    selector: 'test',
    template: '''
    <skawa-data-table [data]="rowData" [selectable]="true" (sort)="sort(\$event)">
      <skawa-data-table-col [accessor]="categoryAccessor" header="Class" footer="Total:" class="text-column"
                          [skipFooter]="false"></skawa-data-table-col>
      <skawa-data-table-col [accessor]="maleAccessor" sortable header="Male" [footer]="aggregate(maleAccessor)"
                          [skipFooter]="false"></skawa-data-table-col>
      <skawa-data-table-col [accessor]="femaleAccessor" sortable="desc, asc" header="Female" [footer]="aggregate(femaleAccessor)"
                          [skipFooter]="false"></skawa-data-table-col>
      <skawa-data-table-col [accessor]="peopleAccessor" sortable="desc"  header="All" [footer]="aggregate(peopleAccessor)"
                          [skipFooter]="false"></skawa-data-table-col>
    </skawa-data-table>
     ''',
    directives: const [SkawaDataTableComponent, SkawaDataTableColComponent, SkawaDataTableSortDirective])
class SelectableDatatableTestComponent {
  String categoryAccessor(SampleNumericData row) => row.category;

  String maleAccessor(SampleNumericData row) => row.male.toString();

  String femaleAccessor(SampleNumericData row) => row.female.toString();

  String peopleAccessor(SampleNumericData row) => (row.female + row.male).toString();

  String aggregate(DataTableAccessor<RowData> accessor) {
    Iterable mapped = rowData.where((row) => row.checked).map(accessor);
    return mapped.isNotEmpty ? mapped.reduce(_aggregateReducer) : '-';
  }

  void sort(SkawaDataTableColComponent column) {
    if (!column.sortModel.isSorted) {
      // Apply default sorting when no sort is specified
      rowData.sort((a, b) => (a as SampleNumericData).category.compareTo((b as SampleNumericData).category));
    } else {
      rowData.sort((a, b) {
        if (column.header == 'Male') {
          return column.sortModel.isAscending
              ? (a as SampleNumericData).male - (b as SampleNumericData).male
              : (b as SampleNumericData).male - (a as SampleNumericData).male;
        } else if (column.header == 'Female') {
          return column.sortModel.isAscending
              ? (a as SampleNumericData).female - (b as SampleNumericData).female
              : (b as SampleNumericData).female - (a as SampleNumericData).female;
        } else if (column.header == 'All') {
          return ((b as SampleNumericData).male + (b as SampleNumericData).female) -
              ((a as SampleNumericData).male + (a as SampleNumericData).female);
        }
      });
    }
  }

  String _aggregateReducer(String a, String b) {
    if (a == null || b == null) return a ?? b;
    return (int.parse(a) + int.parse(b)).toString();
  }

  List<RowData> get rowData => selectableRowData;
}

List<RowData> selectableRowData = <SampleNumericData>[
  new SampleNumericData('1. class', 15, 12, false),
  new SampleNumericData('2. class', 11, 18, false),
  new SampleNumericData('3. class', 13, 13, false),
  new SampleNumericData('4. class', 20, 13, false),
];

@EnsureTag('test')
class TestPO {
  @ByTagName('skawa-data-table')
  DatatablePO dataTable;
}

class DatatablePO {
  @ByTagName('table')
  TablePO table;
}

class TablePO {
  @root
  PageLoaderElement rootElement;

  @ByTagName('thead')
  TableHeaderSectionPO thead;

  @ByTagName('tbody')
  TableSectionPO tbody;

  @ByTagName('tfoot')
  @optional
  TableSectionPO tfoot;
}

class TableHeaderSectionPO {
  @ByTagName('tr')
  TableHeaderRowPO tr;
}

class TableHeaderRowPO {
  @ByTagName('th')
  List<TableHeaderCellPO> th;
}

class TableSectionPO {
  @ByTagName('tr')
  List<TableRowPO> tr;
}

class TableRowPO {
  @root
  PageLoaderElement rootElement;

  @ByTagName('td')
  List<TableCellPO> td;
}

class TableCellPO {
  @inject
  PageLoader loader;

  @root
  PageLoaderElement rootElement;

  @optional
  @ByTagName('material-checkbox')
  PageLoaderElement materialCheckbox;
}

class TableHeaderCellPO {
  @root
  PageLoaderElement rootElement;

  @optional
  @ByTagName('material-checkbox')
  PageLoaderElement materialCheckbox;

  @optional
  @ByTagName('a')
  PageLoaderElement sortLink;
}

class SampleRowData implements RowData {
  /// Default to unchecked
  @override
  bool checked = false;

  final String name;

  final String opinion;

  SampleRowData(this.name, this.opinion);
}

class SampleNumericData extends RowData {
  final String category;
  final int male;
  final int female;

  SampleNumericData(this.category, this.male, this.female, bool selected) : super(selected);
}
