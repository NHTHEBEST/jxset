<?php 
/*
 * jxset
 * Copyright (c) 2010 - 2013, Shuki Shukrun (shukrun.shuki at gmail.com).
 * Dual licensed under the MIT and GPL licenses
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.gnu.org/licenses/gpl.html
 */
 include_once("autoload.php");
 jset_page::create(config::jxset);
?>

<head>
<title>DB Explorer</title>
<script src="js/db.js" type="text/javascript"></script>
</head>

<body>
	<table>
		<tr>
			<td><table id="grid_db"></table></td>
			<td><span style="display:inline-block; width:8px"> </span></td>
			<td><table id="grid_table"></table></td>
		</tr>
	</table>
	
	<div style="height:10px"></div>
	<table id="grid"></table>
</body>
</html>