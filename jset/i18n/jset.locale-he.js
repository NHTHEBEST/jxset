;(function ($) {
/*
 * jset  1.0 - jset
 * Copyright (c) 2010, Shuki Shukrun (shukrun.shuki at gmail.com).
 * Dual licensed under the MIT and GPL licenses
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.gnu.org/licenses/gpl.html
 * Date: 2010-01-01
 */

	// variable settings
	var jset = {
		messages: {
			selectboxItemNotFound: "חסר ערך ברשימה לשדה : '{0}', הערך החסר : '{1}'"
		}
	};

	$.jset = ($.jset == undefined) ? jset : $.extend(true, $.jset, jset);	
})(jQuery);