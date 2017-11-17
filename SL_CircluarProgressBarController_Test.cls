@isTest
private class SL_CircluarProgressBarController_Test {

    static testMethod void fetchProfileProgressWrapper_Test () {
        
        Id userProfile = [select id from profile where name ='Customer Community Plus User'].id;

        Account objAccount = new Account(name ='test1') ;
        insert objAccount; 
        
        Contact objContact = new Contact(LastName ='testCon',AccountId = objAccount.Id);
        insert objContact;
        
        User objUser = new User ( alias = 'test123', 
                                 email='test123@noemail.com',
                                 emailencodingkey='UTF-8', 
                                 lastname='Testing', 
                                 languagelocalekey='en_US',
                				 localesidkey='en_US', 
                                 profileid = userProfile, 
                                 country='US',
                                 IsActive =true,
                				 ContactId = objContact.Id,
                				 timezonesidkey='America/Los_Angeles', 
                                 username='tester@noemail.com'+DateTime.now().getTime()
                                );
       
        insert objUser;
        
        System.runAs(objUser) {
            
            SL_CircluarProgressBarController.fetchProfileProgressWrapper();
        }
    }
}