({
    myAction : function(component, event, helper) {
        var accList = component.get("c.getAccList");
        component.set("v.columnsToDisplay",[
            {label: 'Account name', fieldName: 'Name', type: 'text'},
             {label: 'Email', fieldName: 'Email__c', type: 'email'},
            {label: 'Phone', fieldName: 'Phone', type: 'Integer'},
            {label: 'AccountNumber', fieldName: 'AccountNumber', type: 'text'},
            {label: 'Revenue', fieldName: 'AnnualRevenue', type: 'Integer'},
        ]);
            
        accList.setCallback(this, function(data) 
                            {
                                var state = data.getState();
                                if(state === "SUCCESS"){
                                    component.set("v.Accounts", data.getReturnValue());
                                    component.set("v.showAccountList","true");
                                }else{
                                    alert("Componet has some errors");
                                }
                            });
        $A.enqueueAction(accList);
    },
    CreateRecord : function(component, event, helper){
       // component.set("v.showAccountList", "false");
        component.set("v.showAccCreateFrom", "true");
    },
    Submit : function(component, event, helper){
       component.set("v.showAccCreateFrom", "false");
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'success',
            message: 'Record Created Successfully',
            duration:' 5000',
            key: 'info_alt',
            type: 'success',
            mode: 'dismissible'
        });
        toastEvent.fire();
         var action = component.get("c.myAction");
        $A.enqueueAction(action);
        $A.get('e.force:refreshView').fire();
    },
    Cancel:function(component, event, helper){
        component.set("v.showAccCreateFrom", "false");
        var action = component.get("c.myAction");
        $A.enqueueAction(action);
        $A.get('e.force:refreshView').fire();
    },
      closeAccountForm : function(component, event, helper){
        component.set("v.showAccCreateFrom", "false"); 
            $A.get('e.force:refreshView').fire();
    },
     closeModel : function(component, event, helper){
        component.set("v.showAccCreateFrom", "false");
           $A.get('e.force:refreshView').fire();
    }
    
})