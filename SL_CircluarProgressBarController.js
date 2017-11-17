({
	doInit : function(component, event, helper) {
        helper.checkProfileProgress(component, event, helper);
        helper.setUserImage(component,event);
        // checking the browser type.
        var ua = navigator.userAgent.toLowerCase(); 
        if (ua.indexOf('safari') != -1) { 
            if (ua.indexOf('chrome') > -1) {
               
                component.set("v.isSafari", 'float:left;  padding: 12px;  margin-left: -23px;' );
            } else {
        
                component.set("v.isSafari", 'float:left;  padding: 12px;  margin-left: -23px; margin-top:-25px;');
            }
        }
	},
    
    displayContactForm: function(component, event, helper) {
        component.set("v.isDisplayContactForm" , !component.get('v.isDisplayContactForm'));
        helper.checkProfileProgress(component, event, helper);
        if(!component.get('v.isDisplayContactForm')){
            
       		helper.setUserImage(component,event);
        }
    },
})