// Copyright (c) 2017, aburagad. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_dart_data_grid/src/model/column_model.dart';
import 'package:angular_dart_data_grid/src/custom-grid/custom_grid.dart';




// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [materialDirectives, CustomGridComponent],
  providers: const [materialProviders],
)
class AppComponent  implements OnInit{

  List<Sample> sampleList;
  List<ColumnDefinition> colDefs;

  List<ColumnDefinition> getColumnDefinitions(){
    List<ColumnDefinition> colDefs = new List<ColumnDefinition>();

    ColumnDefinition def1 = new ColumnDefinition();
    def1.columnName="name";
    def1.displayName='Sample Name';
    def1.isSortable=false;
    colDefs.add(def1);

    ColumnDefinition def2 = new ColumnDefinition();
    def2.columnName="type";
    def2.displayName='Sample Type';
    def2.isSortable=true;
    colDefs.add(def2);


    ColumnDefinition def3 = new ColumnDefinition();
    def3.columnName="valid";
    def3.displayName='Valid';
    def3.isSortable=false;
    colDefs.add(def3);

    ColumnDefinition def4 = new ColumnDefinition();
    def4.columnName="age";
    def4.displayName="Age";
    def4.isSortable=false;
    colDefs.add(def4);
    return colDefs;
  }


  List<Sample> getItemList() {
    List<Sample> sampleList = new List<Sample>();
    for(int i=0; i < 5 ; i ++) {
      Sample  sample = new Sample();
      sample.name="sample"+ i.toString() ;
      sample.type= "test";
      sample.valid=true;
      sample.age= 20 ;
      sampleList.add(sample);
    }

    return sampleList;

  }


  void add(){

  }

  /**
   * gets the list of items that are selected.
   */
  void delete(List<dynamic> event){

    for(var item in event ){
      print(item.shareName);
    }


  }

  @override
  ngOnInit() {
    // TODO: implement ngOnInit
    this.sampleList = getItemList();
    this.colDefs = getColumnDefinitions();
  }

}
