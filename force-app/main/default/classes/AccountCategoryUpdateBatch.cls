public class AccountCategoryUpdateBatch implements Database.Batchable<sObject>{
    public database.QueryLocator start (Database.BatchableContext Bc){
        return Database.getQueryLocator('SELECT Id,Annual_Revenue__c,Category__c,Credit_Limit__c,Sales_Representative__c FROM Account__c');
        //return Database.getQueryLocator('Select Id,Account_Category__c,Account_Category__r.Name, Value__c,Operator__c  from Category_Section_Filter__c');
    }public void execute(Database.BatchableContext Bc, List<sObject>listOfRecords){
        List<Account__c>AccountList = (List<Account__c>)listOfRecords;
        List<Category_Section_Filter__c> categorySctnLst = [SELECT Account_Category__c,Name,Operator__c,Value__c FROM Category_Section_Filter__c]; 
        Map<Decimal, Category_Section_Filter__c> ctSecMap = new Map<Decimal, Category_Section_Filter__c>();
        for(Category_Section_Filter__c ctRec:categorySctnLst){
            ctSecMap.put(integer.valueOf(ctRec.Value__c), ctRec);
        }
        List<Account__c> accListUpdate = new List<Account__c>();
        for(Account__c accRec : AccountList){
            if(accRec.Credit_Limit__c >= 1000 && accRec.Credit_Limit__c < 10000 && accRec.Annual_Revenue__c == 100000){
                accRec.Category__c = 'Gold';
                accListUpdate.add(accRec);
            }else if(accRec.Credit_Limit__c >= 10000 && accRec.Credit_Limit__c < 20000 && accRec.Annual_Revenue__c == 200000){
                accRec.Category__c = 'Silver';
                accListUpdate.add(accRec);
            }else if(accRec.Credit_Limit__c > 20000 && accRec.Annual_Revenue__c == 300000){
                accRec.Category__c = 'Platinum';
                accListUpdate.add(accRec);
            }
        }
        if(!accListUpdate.isEmpty()){
            update  accListUpdate;
        }
    }public void finish(Database.BatchableContext BC){
        
    }
    
}