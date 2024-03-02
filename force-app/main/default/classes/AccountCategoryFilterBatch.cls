public class AccountCategoryFilterBatch implements Database.Batchable<sObject>, Database.stateful {
    public List<sObject> start(Database.BatchableContext BC){
        List<sObject> sob = new List<sObject>();
        sob.addAll([Select id, Credit_Limit__c, Annual_Revenue__c, Category__c from Account__c where Credit_Limit__c !=null AND Annual_Revenue__c != null  ]);
        sob.addAll([Select id,Name, Account_Category__r.Name,Account_Category__r.Active__c, Account_Category__r.Default_Category__c, Operator__c, Value__c from Category_Section_Filter__c]);
        return sob;
    } 
    public void Execute(Database.BatchableContext Bc, List<sObject> listOfRecords){
        Map<Decimal,Map<Decimal,List<Account__c>>> accMap = new Map<Decimal, Map<Decimal,List<Account__c>>>();
        Map<string,List<Category_Section_Filter__c>> CategoryMap = new Map<string,List<Category_Section_Filter__c>>();
        Map<String,List<Category_Section_Filter__c>> AnnualRevenueMap = new Map<String,List<Category_Section_Filter__c>>();
        Map<String,Map<String,String>> categoryNewMap = new Map<String,Map<String,String>>();
        List<Category_Section_Filter__c> csfList = new List<Category_Section_Filter__c>();
        string defaultCategory = '';
        for(sObject sob: listOfRecords){
            switch on sob {
                when Category_Section_Filter__c csf{
                    csfList.add(csf);
                    if((csf.Name =='Annual Revenue' && categoryNewMap.containsKey(csf.Value__c))){
                        
                    }
                }
                When Account__c accRec{
                   string accString = accRec.Annual_Revenue__c+' '+accRec.Credit_Limit__c;
                }
            }
        }
        for(Category_Section_Filter__c csf: csfList){
        
    }
    }public void finish(Database.BatchableContext Bc){
    }
}