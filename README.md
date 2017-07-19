
[Demo](https://abhishek-buragadda.github.io/angular-dart-data-grid/)

# angular-dart-data-grid

This is a custom grid build in angular dart with material design. 

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites
#### Softwares
* SASS  -- need to install SASS in the machine for this to work.
#### Dart packages

* Polymer
* Polymer elements
* dart sass transformer

```
dependencies :
  polymer: 1.0.0-rc.19
  polymer_elements: 1.0.0-rc.10

transformers:
- dart_sass_transformer

```

### Installing

Copy the custom-grid folder into your lib folder.
Udpate the pubspec.yaml file.
Include the custom-grid in the imports .
```
import 'package:angular_dart_data_grid/src/custom-grid/custom_grid.dart';
```
Add the CustomGridComponent in the  directives 
```
  directives: const [materialDirectives, CustomGridComponent],
```

Get the dependecies and run pub build/serve. 


### Using it in the HTML. 

#### Inputs :

    `showSelection : bool` 
          --  It will show the checkboxes for each of the rows if true .
    `showActions : bool` 
          --  if true show the add / delete buttons whose functionality is customizable. 
              The delete button is visible only when atleast one of the checkboxes are selected.   
    `data : List<>` 
          -- Data to be displayed in the grid. Expecting a list here.
    `colDefs : List<>` 
          -- List of column definitions that are required to be shown in the grid. 
             We have add other options like	sortable also.
     `rowDetails : bool ` 
          -- if true this will make the expand the row on click and user can add a custom template
             to show more details of a particular data item.
 #### Events :
 
 	 add  : AsyncAction<Null> 
      -- fired when add button is clicked.
	 delete : AsyncAction<List<>>  
      -- fired with the list of items selected when delete button is clicked.
		     User  can write  their own delete function like below.
          (delete)="delete($event)"
              -- $event is the list of items selected in the grid.
                 Just iterate the $event to get the individual items.

 #### Basic Usage : 
```
<custom-grid [showSelection]="true" [showActions]="true" (add)="add()" (delete)="delete($event)" [data]="sampleList"
             [colDefs]="colDefs">
</custom-grid>

```

The above example will show the checkboxes for each of the row, add/delete button and columns as per the column definitions.

### Show Grid with custom template:
   ```
     <custom-grid [showSelection]="true" [showActions]="true" (add)="add()" (delete)="delete($event)" [data]="sampleList"
               [colDefs]="colDefs" [rowDetails]="true">
      <template #rowDetail let-item>
          This is detail of {{item.name}}
      </template>
    </custom-grid>

   ```
   In the above example we can enclose what we want to show as row detail in the  template tag.
   The data item object will be passed to the 'item' and we can access its fields as item.<fieldName>. 
   
### Sample List and Column Definitions. 
  
  #### Column Definitions:
  
  ```
   colDefs = [
     {
     	 'columnName':'column1',
     	 'displayName': 'displayName1',
       'isSortable': true      // this will make the column sortable. 
     },
     {
      'columnName':'column2',
     	'displayName': 'displayName2',
      'isSortable': false
     },
     {
      'columnName':'column3',
     	'displayName': 'displayName3',
      'isSortable': true
     }
     ]
  ```
  
  #### Sample Data to be displayed in the grid. 
  
  ```
   data = [
     {
     		'column1':value1,
     		'column2': value2,
     		'column3': value3
     },
     {
        'column1':value3,
     		'column2': value4,
     		'column3': value5
     },
     {
        'column1':value7,
     		'column2': value8,
     		'column3': value9
 
     }
     ]
 
  ```
