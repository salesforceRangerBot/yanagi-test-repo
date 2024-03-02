public class AccountCategoryTriggerHelperClass {
    public static Boolean isFirstTime = true;
    public static void updateDefalutCategory(Map<Id,Account_Category__c>newAccCtgrMap){
        Boolean isTrueAlready = true;
       Set<Id> accCatIds = new Set<Id>();
        for(Account_Category__c accRec:newAccCtgrMap.Values()){
            if(isTrueAlready){
                if(accRec.Default_Category__c){
                    accCatIds.add(accRec.Id);
                    isTrueAlready = false;
                }
            }else if(isTrueAlready == false && accRec.Default_Category__c){
                accRec.addError('You can not update both records as default');
            }
        }
        List<Account_Category__c>updateAcntCatgr = new List<Account_Category__c>();
        for(Account_Category__c accRec :[SELECT Active__c, Default_Category__c, Id, OwnerId FROM Account_Category__c where Default_Category__c = true AND Id NOT IN:accCatIds]){
            accRec.Default_Category__c = false;
            updateAcntCatgr.add(accRec);
        }
        if(!updateAcntCatgr.isEmpty()){
            update updateAcntCatgr;
        }
    }
    public static void updateDefalutCategoryWhenUpdated(Map<Id,Account_Category__c>newAccCtgrMap, Map<Id,Account_Category__c>oldMap){
        List<Account_Category__c>updateAcntCatgr = new List<Account_Category__c>();
        Boolean isTrueAlready = true;
        Set<Id> accCatIds = new Set<Id>();
        for(Account_Category__c accRec:newAccCtgrMap.Values()){
            if(isTrueAlready){
                if(accRec.Default_Category__c == true && (oldMap.get(accRec.Id).Default_Category__c != accRec.Default_Category__c)){
                    accCatIds.add(accRec.Id);
                    isTrueAlready = false;
                }
            }else if(isTrueAlready == false && (accRec.Default_Category__c == true && oldMap.get(accRec.Id).Default_Category__c != accRec.Default_Category__c)){
                accRec.addError('You are updating multiple Defalut values');
            }
        }
        for(Account_Category__c accRec :[SELECT Active__c, Default_Category__c, Id, OwnerId FROM Account_Category__c where Default_Category__c = true AND Id NOT IN:accCatIds]){
            accRec.Default_Category__c = false;
            updateAcntCatgr.add(accRec);
        }
        if(!updateAcntCatgr.isEmpty()){
            update updateAcntCatgr;
        }    }
}