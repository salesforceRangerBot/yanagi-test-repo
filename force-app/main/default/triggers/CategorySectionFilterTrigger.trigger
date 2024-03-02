trigger CategorySectionFilterTrigger on Category_Section_Filter__c (before insert, before update) {
    if(trigger.isBefore){
        if(trigger.isInsert){
            CategorySectionFilterTriggerHelper.validatingDuplicateFilters(trigger.new);
        }if(trigger.isUpdate){
            CategorySectionFilterTriggerHelper.validatingDuplicateFiltersWhenUpdate(trigger.new, trigger.oldMap);
        }
    }
}