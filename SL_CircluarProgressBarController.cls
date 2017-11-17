/**
* @ClassName    : SL_CircluarProgressBarController;
* @JIRATicket   : HHCCI-93
* @CreatedOn    : 09-11-2017
* @CreatedBy    : Anil
* @ModifiedBy   :
* @Description  : A class which will works on the dynamic values from the fields of the user object and returns wrapper class 
                  to the circular progress bar component.
*/
public class SL_CircluarProgressBarController {
    
    /**
    * @MethodName : fetchProfileProgressWrapper;
    * @param      : No Parameters
    * @Description: A method which checks the contact fields whether the fields are null or not and then returns a profile wrapper class.
    **/
    @AuraEnabled
    public static profileProgressWrapper fetchProfileProgressWrapper(String strFirstStepFields, String strSecondStepFields, String strThirdStepFields, String strFourthStepFields) {

        User objUser = [SELECT Id, ContactId FROM User WHERE Id =: Userinfo.getUserId()];
       
        
        profileProgressWrapper objWrapper = new profileProgressWrapper();
        set<String> setFields1st = new set<String>(strFirstStepFields.split(','));
        set<String> setFields2nd = new set<String>(strSecondStepFields.split(','));
        set<String> setFields3rd = new set<String>(strThirdStepFields.split(','));
        set<String> setFields4th = new set<String>(strFourthStepFields.split(','));
        
        
        String strQuery = 'SELECT '+strFirstStepFields +' , '
                                    +strSecondStepFields + ' , '
                                    +strThirdStepFields+ ' , '
                                    +strFourthStepFields + ' FROM Contact WHERE Id =\''+objUser.ContactId+ '\'';
        List<Contact> lstContact = Database.query(strQuery);
            
        for(Contact objCon: lstContact) {

            objWrapper.isFirstStepCompleted = true;
            objWrapper.isSecondStepCompleted = true;
            objWrapper.isThirdStepCompleted = true;
            objWrapper.isFourthStepCompleted = true;

            for(String strFld: setFields1st) {

                strFld = strFld.trim();
                if(objCon.get(strFld) == null) {// || String.isEmpty(objCon.get(strFld))

                    objWrapper.isFirstStepCompleted = false;
                }
            }
            for(String strFld: setFields2nd) {

                strFld = strFld.trim();
                if(objCon.get(strFld) == null) {// || String.isEmpty(objCon.get(strFld))

                    objWrapper.isSecondStepCompleted = false;
                }
            }
            for(String strFld: setFields3rd) {

                strFld = strFld.trim();
                if(objCon.get(strFld) == null) {// || String.isEmpty(objCon.get(strFld))

                    objWrapper.isThirdStepCompleted = false;
                }
            }
            for(String strFld: setFields4th) {

                strFld = strFld.trim();
                if(objCon.get(strFld) == null) {// || String.isEmpty(objCon.get(strFld))

                    objWrapper.isFourthStepCompleted = false;
                }
            }
        }
        return objWrapper;
    }
    
    /**
    * @MethodName : fetchProfileProgressWrapper;
    * @param      : Np parameters;
    * @Description: A wraper class with set of variables related to custom metadata type.
    **/
    public class profileProgressWrapper {

        @AuraEnabled public Boolean isFirstStepCompleted;
        @AuraEnabled public Boolean isSecondStepCompleted;
        @AuraEnabled public Boolean isThirdStepCompleted;
        @AuraEnabled public Boolean isFourthStepCompleted;
    }
    
    /**
    * @MethodName : getDefaultUserPhoto;
    * @param      : No parameters;
    * @Description: A method will upload the photo choosen from desktop or gallery.
    **/
    @AuraEnabled
    public static string getDefaultUserPhoto() {

        ConnectApi.Photo userImage  =  ConnectApi.ChatterUsers.getPhoto(Network.getNetworkId() , UserInfo.getUserId() );
        return userImage.largePhotoUrl;
    }
}