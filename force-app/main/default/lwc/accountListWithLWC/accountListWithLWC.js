import { LightningElement, wire} from 'lwc';
import accounts from '@salesforce/apex/AccountList.getAccList';
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
import ACCOUNT_EMAIL from '@salesforce/schema/Account.Email__c';
import {refreshApex} from '@salesforce/apex';
import {RefreshEvent} from 'lightning/refresh';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
const columns = [
    {label: 'Account name', fieldName: 'Name'},
     {label: 'Email', fieldName: 'Email__c'},
            {label: 'PhoneNumber', fieldName: 'Phone'},
            {label: 'AccountNumber', fieldName: 'AccountNumber'},
            {label: 'Revenue', fieldName: 'AnnualRevenue'},
           
           ];
export default class AccountListWithLWC extends LightningElement {
//selectedFields=[ACCOUNT_NAME,ACCOUNT_EMAIL];
showDataTable;
accountList = [];
columns = columns;
openAccountFrom;
accountsData = [];
errors;

@wire(accounts)
accountsData(result){
this.accountsData = result;
if(this.accountsData.data){
this.accountList = this.accountsData.data;
this.showDataTable = true;
}else if(this.accountsData.error){
this.errors = this.accountsData.error;
this.accountList = undefined;
}
}

createAccount(){
//this.showDataTable = false;
this.openAccountFrom = true;
}
closeAccountModal(){
this.openAccountFrom = false;
this.showDataTable = true;
}
submit(){
    this.openAccountFrom = false;
 refreshApex(this.accountsData);
 this.dispatchEvent(new RefreshEvent());
      const event = new ShowToastEvent({
        variant: 'success',
        message: 'Record Created succssfully',
        mode: 'dismissible'
    }); 
    this.dispatchEvent(event);
    }

cancel(){
this.openAccountFrom = false;
this.showDataTable = true;
}
closeModel(){
    this.openAccountFrom = false;
this.showDataTable = true;
}
}