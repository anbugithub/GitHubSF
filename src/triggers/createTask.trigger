trigger createTask on Lead (after update){

    List<Task> tasks = new List<Task>();
    List<Lead> leads= Trigger.new;
       
        for (Lead ld : leads) {
        if (ld.Call_Back_Counter__c > 0)
       {
        
          Task tsk = new Task(whoID= ld.ID, Ownerid = ld.OwnerId,ReminderDateTime=system.now());
      tasks.add(tsk);
      insert tasks;
      

}
}

}