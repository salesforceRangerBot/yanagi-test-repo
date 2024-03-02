@isTest
public class CategroySectionTestClass {
    @isTest
    public static void validateFilters(){
        List<Account_Category__c>accCatList = new List<Account_Category__c>();
         for(Integer i=0;i<3; i++){
            if(i==0){
                Account_Category__c accRec = new Account_Category__c();
                accRec.Active__c = true;
                accRec.Default_Category__c = true;
                accRec.Name = 'Gold';
                accRec.Description__c = 'Gold Partner';
                accCatList.add(accRec);
            }else if(i==1){
                Account_Category__c accRec1 = new Account_Category__c();
                accRec1.Active__c = true;
                accRec1.Default_Category__c = false;
                accRec1.Name = 'Silver';
                accRec1.Description__c = 'Silver Partner';
                accCatList.add(accRec1);
            }else if(i==2){
                Account_Category__c accRec2 = new Account_Category__c();
                accRec2.Active__c = true;
                accRec2.Default_Category__c = false;
                accRec2.Name = 'Platinum';
                accRec2.Description__c = 'Platinum Partner';
                accCatList.add(accRec2);
            }
        }
        insert accCatList;
        
        List<Category_Section_Filter__c>catSecList = new List<Category_Section_Filter__c>();
        for(Account_Category__c accRec: accCatList){
            if(accRec.Name == 'Gold'){
                Category_Section_Filter__c ctRec = new Category_Section_Filter__c();
                ctRec.Account_Category__c = accRec.Id;
                ctRec.Name ='Credit_Limit__c';
                ctRec.Value__c = '1000';
                ctRec.Operator__c = 'Greater Than';
                catSecList.add(ctRec);
                
                 Category_Section_Filter__c ctRec1 = new Category_Section_Filter__c();
                ctRec1.Account_Category__c = accRec.Id;
                ctRec1.Name ='Credit_Limit__c';
                ctRec1.Value__c = '10000';
                ctRec1.Operator__c = 'Lesser Than';
                catSecList.add(ctRec1);
                
                 Category_Section_Filter__c ctRec5 = new Category_Section_Filter__c();
                ctRec5.Account_Category__c = accRec.Id;
                ctRec5.Name ='Annul_Revenue__c';
                ctRec5.Value__c = '100000';
                ctRec5.Operator__c = 'Equal to';
                catSecList.add(ctRec5);
            }else if(accRec.Name == 'Silver'){
                Category_Section_Filter__c ctRec2 = new Category_Section_Filter__c();
                ctRec2.Account_Category__c = accRec.Id;
                ctRec2.Name ='Credit_Limit__c';
                ctRec2.Value__c = '10000';
                ctRec2.Operator__c = 'Greater Than';
                catSecList.add(ctRec2);
                Category_Section_Filter__c ctRec3 = new Category_Section_Filter__c();
                ctRec3.Account_Category__c = accRec.Id;
                ctRec3.Name ='Credit_Limit__c';
                ctRec3.Value__c = '20000';
                ctRec3.Operator__c = 'Lesser Than';
                catSecList.add(ctRec3);
                Category_Section_Filter__c ctRec6 = new Category_Section_Filter__c();
                ctRec6.Account_Category__c =accRec.Id;
                ctRec6.Name ='Annul_Revenue__c';
                ctRec6.Value__c = '200000';
                ctRec6.Operator__c = 'Equal to';
                catSecList.add(ctRec6);
            }else if(accRec.Name == 'Platinum'){
                 Category_Section_Filter__c ctRec4 = new Category_Section_Filter__c();
                ctRec4.Account_Category__c = accRec.Id;
                ctRec4.Name ='Credit_Limit__c';
                ctRec4.Value__c = '20000';
                ctRec4.Operator__c = 'Greater Than';
                catSecList.add(ctRec4);
                 Category_Section_Filter__c ctRec7 = new Category_Section_Filter__c();
                ctRec7.Account_Category__c = accRec.Id;
                ctRec7.Name ='Annul_Revenue__c';
                ctRec7.Value__c = '300000';
                ctRec7.Operator__c = 'Equal to';
                catSecList.add(ctRec7);
                
            }
        }
        insert catSecList;
        Category_Section_Filter__c ctRec = new Category_Section_Filter__c();
                ctRec.Account_Category__c = accCatList[2].Id;
                ctRec.Name ='Annul_Revenue__c';
                ctRec.Value__c = '300000';
                ctRec.Operator__c = 'Equal to';
                
        try{
            insert ctRec;
        }catch(exception e){
            Boolean expectedException = (e.getMessage().contains('This filter value exsist') ? true: false);
            system.assertEquals(true,expectedException, e.getmessage());
        }
        List<Category_Section_Filter__c>catList = new List<Category_Section_Filter__c>();
        for(Category_Section_Filter__c ctRecd: [SELECT Id, Account_Category__c,Name,Operator__c,Value__c FROM Category_Section_Filter__c where Value__c = '1000']){
            ctRecd.Value__c = '10000';
            catList.add(ctRecd);
        }
        try{
            update catList;
        }catch(exception e){
            Boolean expectedException = (e.getMessage().contains('This filter value exsist') ? true: false);
            system.assertEquals(true,expectedException, e.getmessage());
        }
        
        
    }
}