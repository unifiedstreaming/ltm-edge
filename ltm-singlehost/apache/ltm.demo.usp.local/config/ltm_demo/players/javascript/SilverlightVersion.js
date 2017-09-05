function isSilverlightInstalled(){
	var isSilverlightInstalled = false;
	try {
		//check on IE
		try {
			var slControl = new ActiveXObject('AgControl.AgControl');
			isSilverlightInstalled = true;
		} 
		catch (e) {
			//either not installed or not IE. Check Firefox
			if (navigator.plugins["Silverlight Plug-In"]) {
				isSilverlightInstalled = true;
			}
		}
	} 
	catch (e) {
		//we don't want to leak exceptions. However, you may want
		//to add exception tracking code here.
	}
	
	return isSilverlightInstalled;
}