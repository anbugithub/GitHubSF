trigger UpdateCallBAckcounter on Task (after delete, after insert) {
    
    // Declare the variables
    public set<Id> LeadIDs = new Set<Id>();
    public list<Lead> LeadsToUpdate = new List<Lead>();
    public List<Task> Tasklist = new List<Task> ();
    Decimal callbackcount ;
      static boolean flag =false;
  // Decimal3 =  Decimal.valueof(Label.CallbackCounterStartValue);
//   Decimal 15 =  Decimal.valueof(Label.15);
    
    // Build the list of Leads to update
    
    if(Trigger.isInsert ||  Trigger.isUpdate)
    {
        for(Task eachTask: Trigger.new)
        {
            if(string.valueOf(eachTask.WhoId).startsWith('00Q') && eachTask.Status == 'Completed' && eachTask.Subject == 'Autotask')
                LeadIDs.add(eachTask.WhoId);
                System.debug('@@@WhoId = ' + eachTask.WhoId);
        }
    }
    
 /*   if(Trigger.isDelete || Trigger.isUpdate)
    {
        for(Task eachTask: Trigger.old)
        {
            if(string.valueOf(eachTask.WhoId).startsWith('00Q'))
                LeadIDs.add(eachTask.WhoId);
                System.debug('@@@WhoId = ' + eachTask.WhoId);
        }
    }*/
    
    // Update the Leads
   //BusinessDays  busidays = new BusinessDays ();
    Datetime dateval = datetime.now();
    if(LeadIDs.size()>0 &&  flag == false){
    List <Lead> Leadlist = new List<Lead>();
    Leadlist = [Select eachLead.Id, eachLead.Status,eachLead.OwnerId, eachLead.Call_Back_Counter__c, 
            (Select Id,Subject ,Priority ,status ,ReminderDateTime,ownerId,createdDate  From Tasks where Status = 'Completed' and Subject = 'Autotask' ) 
            From Lead eachLead where Id in :LeadIDs ];
  if(Leadlist.size()>0) {  
   LeadsToUpdate.add(new Lead(Id=Leadlist[0].Id, Call_Back_Counter__c = Leadlist[0].Tasks.size()));
   callbackcount = Leadlist[0].Tasks.size();
  if( Leadlist[0].Status == 'Open' && Leadlist[0].Call_Back_Counter__c != null){
  if(callbackcount <=3 )
  { 
  
  Task taskObj = new Task( whoid = Leadlist[0].Id,Subject = 'Autotask CallBack',Priority = 'Normal',status = 'Not Started' ,IsReminderSet=TRUE, ReminderDateTime = Datetime.Now().addHours(3));
  Tasklist.add(taskObj);
  Insert Tasklist;
  System.debug('first if');
    System.debug('who id '+ Leadlist[0].Id);
  }
  
  
  if(callbackcount >3  && callbackcount <= 15 ){
            Task taskObj = new Task(whoid = Leadlist[0].Id,Subject = 'Autotask CallBack',Priority = 'Normal',status = 'Not Started' , IsReminderSet=TRUE, ReminderDateTime = Datetime.Now().addHours(7));
            Tasklist.add(taskObj);
              Insert Tasklist;
                System.debug('Second if');
  
  }
 
 }
 update LeadsToUpdate;
 flag = true;
 }
       /* for(Lead eachLead: [Select eachLead.Id, eachLead.Status,eachLead.OwnerId, eachLead.Call_Back_Counter__c, 
            (Select Id,Subject ,Priority ,status ,ReminderDateTime,ownerId  From Tasks where Status = 'Completed') 
            From Lead eachLead where Id in :LeadIDs]){
            LeadsToUpdate.add(new Lead(Id=eachLead.Id, Call_Back_Counter__c = eachLead.Tasks.size()));
            callbackcount = eachLead.Tasks.size();
            if( eachLead.Status == 'Open - Not Contacted' && eachLead.Call_Back_Counter__c != null){
            if(callbackcount <=3 &&  flag == false){            
            Task taskObj = new Task( whoid = eachLead.Id,Subject = 'Autotask',Priority = 'Normal',status = 'Not Started' , ReminderDateTime = Datetime.Now().addHours(3));
            Tasklist.add(taskObj);
              flag = true;
            break;
            }if(callbackcount >3  && callbackcount <= 15 &&  flag == false){
            Task taskObj = new Task(whoid = eachLead.Id, Subject = 'Autotask',Priority = 'Normal',status = 'Not Started' , ReminderDateTime = Datetime.Now().addHours(7));
            Tasklist.add(taskObj);
              flag = true;

            break;
            }
            }
            }*/
    }
      //update LeadsToUpdate;
    //insert TaskList;
      
}