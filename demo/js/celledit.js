$(function(){
	var urlVars = $.getUrlVars();
	var searchDefaults = [];
	var gridOptions = {};
	var liveSettings = {};
	//$.dump(urlVars);
	$.each(urlVars, function(key, value){
		//alert(key + ':' + value + ':' + urlVars[value]);
		switch(value){
			case '_order_by_':
				gridOptions.sortname = urlVars[value];
				break;
			case '_order_direction_':
				gridOptions.sortorder = urlVars[value];
				break;
			default:
				var obj = {};
				obj.name = value;
				obj.value = decodeURIComponent(urlVars[value]);
				searchDefaults.push(obj);
		}
	});
	
	liveSettings.grid = gridOptions;
	liveSettings.search_default = searchDefaults;
	var windowHeight = $(window).height();

	//$.dump(searchDefaults);
	//$( document ).tooltip();
	var grid = $('#grid');
	var settings = {
	  	source: 'demo', //name of table, view or the actual sql that you wish to display in the grid
	  	//source: 'demo', //name of table, view or the actual sql that you wish to display in the grid
		//load_edit_record: true, //reload record before editting
		//row_selection: false,
		//reopen_after_add: true,
		//search_default: searchDefaults,
		row_selection: false,
		afterSaveCell: function (rowid, cellname, value){
			console.log(arguments);
			var grid = $(this);
		    if (cellname === 'decimal') {
		        var id = parseFloat(grid.jqGrid("getCell", rowid, 'id'));
		        grid.jqGrid("setCell", rowid, 'integer', parseFloat(id) + parseFloat(value));
		    }
		},	   
		
		grid: {
			autowidth: true,
			height: windowHeight - 120,
			footerrow : true,
			userDataOnFooter : true,
			cellEdit: true
	  	},
	  	navigation:{
			options : {
				edit: false
				
				//checkOnUpdate:true
			},
			edit:{
				//checkOnSubmit:true,
				checkOnUpdate:true
			},
			add:{
				//checkOnUpdate:true
			},
			del:{
			},
			search:{
				//
			},
			view:{
			}
		}

	};
	
	grid.jset($.extend(true, settings, liveSettings));
});