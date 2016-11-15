define( [
	"../var/document",
	"../var/support"
], function( document, support ) {

"use strict";

support.focusin = "onfocusin" in window;

return support;

} );
