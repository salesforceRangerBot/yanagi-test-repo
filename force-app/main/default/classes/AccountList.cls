public class AccountList {
   @AuraEnabled (cacheable=true)
    public static List<Account> getAccList(){
        List<Account>accountList = [SELECT Id, Name, Phone, AccountNumber,AnnualRevenue, Rating,Email__c FROM Account];
        return accountList;
    }

}