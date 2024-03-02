public class CategorySectionFilterTriggerHelper {
    public static void validatingDuplicateFilters(List<Category_Section_Filter__c>categoryFilterList){
        set<String> categorySet = new Set<String>();
        for(Category_Section_Filter__c ctSecRec : categoryFilterList){
            if(ctSecRec.Value__c != null){
                categorySet.add(ctSecRec.Value__c);
            }
        }
        Map<String,Category_Section_Filter__c>catSecMap =new Map<String,Category_Section_Filter__c>();
        for(Category_Section_Filter__c ctSecRec: [Select Id,Account_Category__c, Value__c, Operator__c from Category_Section_Filter__c where Value__c IN : categorySet]){
            if(ctSecRec.Value__c != null){
                catSecMap.put(ctSecRec.Value__c, ctSecRec);
            }
        }
        for(Category_Section_Filter__c catSecRec:categoryFilterList){
            if(catSecMap.ContainsKey(catSecRec.Value__c) && (catSecMap.get(catSecRec.Value__c).Operator__c == catSecRec.Operator__c 
                                                             && catSecMap.get(catSecRec.Value__c).Account_Category__c == catSecRec.Account_Category__c)){
                catSecRec.addError('This filter value exsist');
            }
        }
    }
    public static void validatingDuplicateFiltersWhenUpdate(List<Category_Section_Filter__c>categoryFilterList, Map<Id,Category_Section_Filter__c>oldMap){
        set<String> categorySet = new Set<String>();
        for(Category_Section_Filter__c ctSecRec : categoryFilterList){
            if(ctSecRec.Value__c != null &&(oldMap.get(ctSecRec.Id).Value__c != ctSecRec.Value__c)){
                categorySet.add(ctSecRec.Value__c);
            }
        }
        Map<String,Category_Section_Filter__c>catSecMap =new Map<String,Category_Section_Filter__c>();
        for(Category_Section_Filter__c ctSecRec: [Select Id,Account_Category__c, Value__c,Operator__c  from Category_Section_Filter__c where Value__c IN : categorySet]){
            if(ctSecRec.Value__c != null){
                catSecMap.put(ctSecRec.Value__c, ctSecRec);
            }
        }
        for(Category_Section_Filter__c catSecRec:categoryFilterList){
            if(catSecMap.ContainsKey(catSecRec.Value__c) && (catSecMap.get(catSecRec.Value__c).Operator__c == catSecRec.Operator__c 
                                                             && catSecMap.get(catSecRec.Value__c).Account_Category__c == catSecRec.Account_Category__c)){
                catSecRec.addError('This filter value exsist');
            }
        }
    }
}