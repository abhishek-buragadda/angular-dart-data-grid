import 'dart:async';
import 'dart:mirrors';

import 'package:angular2/angular2.dart';
import 'package:angular2/core.dart';
import 'package:angular_components/angular_components.dart';
import 'package:polymer_elements/iron_icons.dart';

import './model/table_model.dart';
import './custom-template-outlet/NgTemplateOutlet.dart';

/**
 *    Customizable grid .
 *
 *    This can be used to create own grid .
 *
 *    Usage:
 *
 *    <custom-grid [showSelection]="true" [showActions]="true" (add)="add()" (delete)="delete($event)" [data]="data"
		[colDefs]="colDefs" [rowDetails]="true">
		<template #rowDetail let-item>
			This is detail of {{item.shareName}}
		</template>
	  </custom-grid>
 *
 *
 *    colDefs = [
 *    {
 *    	'columnName':'column1',
 *    	'displayName': 'displayName1',
 *      'isSortable': true
 *    },
 *    {
 *    	'columnName':'column2',
 *    	'displayName': 'displayName2',
 *      'isSortable': false
 *
 *    },
 *    {
 *    	'columnName':'column3',
 *    	'displayName': 'displayName3',
 *      'isSortable': true
 *    }
 *    ]
 *
 *    data = [
 *    {
 *    		'column1':value1,
 *    		'column2': value2,
 *    		'column3': value3
 *    },
 *    {
 *	    	'column1':value3,
 *    		'column2': value4,
 *    		'column3': value5
 *
 *    },
 *    {
 *	    	'column1':value7,
 *    		'column2': value8,
 *    		'column3': value9
 *
 *    }
 *    ]
 *
 *   __Inputs__
 *
 *     `showSelection : bool` -- It will show the checkboxes for each of the rows if true .
 *     `showActions` : bool` --  if true show the add / delete buttons whose functionality is customizable .
 *     							THe delete button is visible only when atleast one of the checkboxes are selected.
 *     `data : List<>` -- Data to be displayed in the grid. Expecting a list here .
 *		`colDefs : List<>` -- List of column definitions that are required to be shown in the grid. We have add other options like
 *								sortable also.
 *
 *
 *		`rowDetails : bool `  -- if true this will make the expand the row on click and user can add a custom template
 *							to show more details of a particular data item.
 *
 *   The template will get the data item into a variable called item shown as below.
 *
 *   Example of sample template.
 *   	<template #rowDetail let-item>
			This is detail of {{item.shareName}}  --- this can be any custom template of your choice  .
		</template>


	__Events __ :

	  	add  -  AsyncAction<Null> -- fired when add button is clicked.


		delete - AsyncAction<List<>>  -- fired with the list of items selected when delete button is clicked.

			user  can write  their own delete function like below.

				(delete)="delete($event)"

					$event - is the list of items selected in the grid . Just iterate the $event to get the individual items.

 */



@Component(
	selector: 'custom-grid',
	styleUrls: const ['custom_grid.css'],
	templateUrl: 'custom_grid.html',
	directives: const [materialDirectives, COMMON_DIRECTIVES,NgTemplateOutletCustom],
)
class CustomGridComponent implements OnInit {



	// variablesexposed to other components
	TableModel tableModel = new TableModel();
	StreamController<List<Object>> addClickController = new StreamController<List<Object>>();
	StreamController<Null> deleteClickController = new StreamController<Null>();
	StreamController<Null> editClickController = new StreamController<Null>();

	@Input("showSelection")
	bool showSelection ;
	@Input("showActions")
	bool showActions;
	@Input("data")
	dynamic  data ;
	@Input("colDefs")
	dynamic colDefs;
	@Input("rowDetails")
	bool rowDetails;
	@Input("isEditable")
	bool isEditable;

	@ContentChild('rowDetail')
	TemplateRef  template ;

	@Output("add")
	Stream<Null> get onAdd => addClickController.stream;
	@Output("delete")
	Stream<Null> get onDelete => deleteClickController.stream;

	@Output("edit")
	Stream<Null> get onEdit => editClickController.stream;

	// binding with the view
	bool isAllSelected = false ;
	int currentSelected=-1;


	/**
		***** action methods *******
	 */
	void performDelete(){
		List<Object> itemsToDelete = new List<Object>();
		List<RowModel> rowModels = tableModel.rowModels;
			for(int i =0 ; i < rowModels.length ; i++){
			if( rowModels[i].isSelected){
				itemsToDelete.add(data[i]);
			}
		}
		deleteClickController.add(itemsToDelete);
		
	}



	void performAdd(){
		addClickController.add(null);
	}

	void selectAll(){
		List<RowModel> rowModels = tableModel.rowModels;
		for(RowModel rowModel in rowModels ){
			rowModel.isSelected = isAllSelected;
		}
	}


	bool showDeleteAction(){
		bool isItemSelected =false ;
		if(!isAllSelected){
			for(RowModel rowModel in tableModel.rowModels){
				isItemSelected = isItemSelected || rowModel.isSelected ;
			}
		}
		return isAllSelected || isItemSelected;
	}


	void sortColumn(dynamic colDef){
		if(colDef.isSortable){
			sortByColumnName(colDef.columnName,colDef.sortDirectionAsc);
			colDef.sortDirectionAsc = !colDef.sortDirectionAsc;
		}
	}

	void sortByColumnName(String columnName,bool sortAsc) {
		if(sortAsc){
			this.data.sort((a,b)=> __compare(a,b,columnName));

		}else{
			this.data.sort((b,a)=> __compare(a,b,columnName));

		}

	}

	updateItem(dynamic item, event , int index){
		tableModel.rowModels[index].inEditMode = ! tableModel.rowModels[index].inEditMode;
		currentSelected = index;

	}

	/**
	 *  binding with UI
	 */


	showDetails(dynamic item, int index){
		currentSelected = currentSelected == index ? -1 : index;
	}
	/**
	 *  *************************** Helper methods ******************
	 */

	dynamic getFieldValue(dynamic object, String fieldName ){
		return reflect(object)
			.getField(new Symbol(fieldName))
			.reflectee;
	}

	//TODO: discuss the approach here .
	dynamic getFieldValueWithoutMirrors(dynamic object , String fieldName){
		return object.getFieldValue(fieldName);
	}

	bool isSelected(int index){
		return currentSelected==index;
	}

	/**
		***************** private methods **********
	 */

	int __compare(a, b, String columnName) {
		return getFieldValue(a, columnName).compareTo(
			getFieldValue(b, columnName));
	}


	@override
	ngOnInit() {
		for(var item in data){
			RowModel rowModel = new RowModel();
			tableModel.rowModels.add(rowModel);
		}
		for(var coldef in colDefs){
			ColHeader header = new ColHeader(coldef.columnName,coldef.displayName,coldef.isSortable);
			tableModel.colHeaders.add(header);
		}
	}

	@override
	ngOnDestroy(){
		addClickController.close();
		deleteClickController.close();
		editClickController.close();
	}
}