public class ScheduleAccountBatch implements Schedulable{
    public void execute(SchedulableContext sc){
        AccountCategoryUpdateBatch bc = new AccountCategoryUpdateBatch();
        Database.executeBatch(bc);
    }

}