trigger AccountCategoryTrigger on Account_Category__c (after insert,after update){
    if(trigger.isafter){
        if(trigger.isInsert){
            AccountCategoryTriggerHelperClass.updateDefalutCategory(trigger.newMap);
        }if(trigger.isUpdate){
            if(AccountCategoryTriggerHelperClass.isFirstTime){
            AccountCategoryTriggerHelperClass.isFirstTime = false;
           AccountCategoryTriggerHelperClass.updateDefalutCategoryWhenUpdated(trigger.newMap, trigger.oldMap);
        }
        }
    }
}