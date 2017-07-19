class  TableModel{
	List<RowModel> rowModels;
	List<ColHeader> colHeaders ;
	TableModel(){
		rowModels = new List<RowModel>();
		colHeaders = new List<ColHeader>();
	}
	List<RowModel> getRowModels(){
		return rowModels;
	}

}

class RowModel{
	bool isSelected ;
	bool inEditMode;
	RowModel(){
		this.isSelected = false;
		this.inEditMode= false ;
	}
}

class ColHeader{
	bool sortDirectionAsc=false ;
	String columnName ;
	String displayName ;
	bool isSortable;
	ColHeader(this.columnName,this.displayName,this.isSortable);
}

class ColumnModel {
	bool isSortingEnabled;
	bool sortAsc;

	ColumnModel(){
		this.isSortingEnabled =false;
		this.sortAsc = true;
	}
	ColumnModel.withArguments(this.isSortingEnabled,this.sortAsc);
}