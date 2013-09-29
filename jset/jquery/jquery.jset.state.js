;(function ($) {
	$.extend($.jset.fn, {
	    saveObjectInLocalStorage: function (storageItemName, object) {
	        if (typeof window.localStorage !== 'undefined') {
	            window.localStorage.setItem(storageItemName, JSON.stringify(object));
	        }
	    },
	    removeObjectFromLocalStorage: function (storageItemName) {
	        if (typeof window.localStorage !== 'undefined') {
	            window.localStorage.removeItem(storageItemName);
	        }
	    },
	    getObjectFromLocalStorage: function (storageItemName) {
	        if (typeof window.localStorage !== 'undefined') {
	            return JSON.parse(window.localStorage.getItem(storageItemName));
	        }
	    },
	    
	    myColumnStateName: function (grid) {
	        return window.location.pathname + '#' + grid[0].id;
	    },
	    
	    saveGridState: function () {
	       var state = {
                //search: this.jqGrid('getGridParam', 'search'),
                //page: this.jqGrid('getGridParam', 'page'),
                sortname: this.jqGrid('getGridParam', 'sortname'),
                sortorder: this.jqGrid('getGridParam', 'sortorder'),
                colStates: {},
                otherState: {
                	permutation: this.jqGrid("getGridParam", "remapColumns")
                }
	        };

	        var colModel = this.jqGrid('getGridParam', 'colModel'), i, l = colModel.length, colItem, cmName;
	        for (i = 0; i < l; i++) {
	            colItem = colModel[i];
	            cmName = colItem.name;
	            if (cmName !== 'rn' && cmName !== 'cb' && cmName !== 'subgrid') {
	                state.colStates[cmName] = {
	                    width: colItem.width,
	                    hidden: colItem.hidden
	                };
	            }
	        }
	        $.jset.fn.saveObjectInLocalStorage($.jset.fn.myColumnStateName(this), state);
	    },
	    
	    restoreGridState: function (settings){
	    	var columnsState = $.jset.fn.getObjectFromLocalStorage($.jset.fn.myColumnStateName(this));
	    	if(!columnsState)
	    		return settings;
	    		
	    	var colModel = settings.colModel;
			
	        if (columnsState.colStates) {
	            var colStates = columnsState.colStates;
	        	var colItem, i, l = colModel.length, cmName;
	            for (i = 0; i < l; i++) {
	                colItem = colModel[i];
	                cmName = colItem.name;
	                if (cmName !== 'rn' && cmName !== 'cb' && cmName !== 'subgrid')
	                    $.extend(true, colModel[i], colStates[cmName]);
	            }
	            delete columnsState.colStates;
	        }
	        
	        this.data('persist_state', $.extend(true, {}, columnsState));
	        delete columnsState.otherState;
	        
	        return $.extend(true, settings, columnsState);
	    },
	});
})(jQuery);