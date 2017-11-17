({
    computeProgress : function(component, event, helper)  {
        var totalVal = component.get("v.totalProgress");
        var actualVal = component.get("v.actualProgress"); 
        
        if(totalVal && (actualVal || actualVal== 0) && !isNaN(parseInt(totalVal)) && isFinite(totalVal) && !isNaN(parseInt(actualVal)) && isFinite(actualVal)){
            //parameter is number 
            var percVal = parseInt(actualVal) / parseInt(totalVal) ;
            var progressVal = parseInt(  percVal * 360  ) ;
            
            component.set("v.cirDeg" , progressVal );
            component.set("v.perText" , parseInt(percVal * 100)  +'%' ); 
        }
    },
    checkProfileProgress: function(component, event, helper) {
        
        var action = component.get("c.fetchProfileProgressWrapper");
        action.setParams({ 
            "strFirstStepFields" : component.get("v.fieldApiNamesForFirstStep"),
            "strSecondStepFields" : component.get("v.fieldApiNamesForSecondStep"),
            "strThirdStepFields" : component.get("v.fieldApiNamesForThreeStep"),
            "strFourthStepFields" : component.get("v.fieldApiNamesForFourStep")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                
                console.log("From server: ",response.getReturnValue());
                component.set("v.profileCompleteInfo", response.getReturnValue());
                var proProgress = response.getReturnValue();
                var actualProg = 0;
                if(proProgress.isFirstStepCompleted) {
                    
                    actualProg += 25;
                }
                if(proProgress.isSecondStepCompleted) {
                    
                    actualProg += 25;
                }
                if(proProgress.isThirdStepCompleted) {
                    
                    actualProg += 25;
                }
                if(proProgress.isFourthStepCompleted) {
                    
                    actualProg += 25;
                }
                component.set("v.actualProgress", actualProg ); 
                
                var appEvent = $A.get("e.c:SL_evnt_UpdateProfileComplete");
                appEvent.setParams({
                    "message" : (actualProg/25)+"/4 Complete"  
                });
                appEvent.fire();
                helper.computeProgress(component, event, helper);
            }
        });
        $A.enqueueAction(action);
    },
    
    
    setUserImage : function(component, event) {
        var action = component.get("c.getDefaultUserPhoto");
 
        // set call back 
        action.setCallback(this, function(response) {
           
            var state = response.getState();
            if (state === "SUCCESS") {
                    component.set("v.userProfileImage",response.getReturnValue() ); 
                   
                // handel the response errors        
            } else if (state === "INCOMPLETE") {
                alert("From server: " + response.getReturnValue());
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
            component.set("v.loaded",false);
        });
        // enqueue the action
        $A.enqueueAction(action);
    }
})