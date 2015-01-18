@isTest

private class lead_task_Trigger_Test_GR 
{  
    public static List<Lead> listOfLeads = new List<Lead>();
    public static List<Task> listOfTask = new List<Task>();
    public static List<Lead> LeadToUpdate ;
    public static Lead lead1 = new Lead();
    public static Lead lead2 = new Lead();
    lead_task_Trigger_Test_GR test = new lead_task_Trigger_Test_GR();
    
    //insert Leads
    public static void testLeads()
    {   
        lead1.Lastname = 'Nole';
        lead1.LeadSource = 'Other';
        lead1.MobilePhone='41524';
        lead1.Company='Tata Steel';
        lead1.Product_Type__c='Direct Auto (1)';
        lead1.Call_Back_Counter__c = 0;
        listOfLeads.add(lead1);
        
        lead2.Lastname = 'Nole';
        lead2.LeadSource = 'Other';
        lead2.MobilePhone='41524';
        lead2.Company='Tata Steel';
        lead2.Product_Type__c='Direct Auto (1)';
        listOfLeads.add(lead2);
        
        insert listOfLeads;
        listOfLeads[1].MobilePhone='2013';
        update listOfLeads;        
    }
    
    public static void testTask()
    {   
        task newTask =new task();
        newTask.WhoId= listOfLeads[0].id;
        newTask.Subject='Donni';
        newTask.Status='New';
        newTask.Priority='Normal';
        newTask.CallType='Outbound'; 
        listOfTask.add(newTask); 
        insert listOfTask; 
        update listOfLeads;
       // listOfLeads[0].Call_Back_Counter__c = listOfTask.size();
        
        //delete listOfTask[0];
        system.debug('@@task'+listOfTask);
         system.debug('@@@LeadRecord::'+listOfLeads[0]);
        system.debug('@@@CallBAckCounter::'+listOfLeads[0].Call_Back_Counter__c);
        
      /*  LeadToUpdate = New List<Lead>();
        LeadToUpdate .add(listOfLeads[0].id,listOfLeads[0].Call_Back_Counter__c=listOfTask.size());
        Update LeadToUpdate ;*/
                   
    }
    
    public static testMethod void testTrigger()
    {
        test.startTest();
        
        testTask();
        System.assertEquals(1,listOfLeads[0].Call_Back_Counter__c);
        test.stopTest();     
              
    }
    
    
    /*public static testMethod void testTrigger()
    {
        List<Lead> listOfLeads= new List<Lead>
        { 
            new Lead
            (
                Lastname = 'Nole',
                LeadSource = 'Other',
                MobilePhone='41524',
                Company='Tata Steel',
                Product_Type_GR__c='Direct Auto (1)'
            ), 
            new Lead
            (
                Lastname = 'Nole',
                LeadSource = 'Other',
                MobilePhone='41524',
                Company='Tata Steel',
                Product_Type_GR__c='Direct Auto (1)'
            )  
        };
                                    
        insert listOfLeads;
        listOfLeads[1].MobilePhone='2013';
        update listOfLeads;
    
        List<task> listOfTasks = new List<task>
        { 
            new task
            (
                WhoId= listOfLeads[0].id,
                Subject='Donni',
                Status='New',
                Priority='Normal',
                CallType='Inbound'
            ) 
        };
    
        insert listOfTasks;
           
        List<task> tasksToUpdate = New List<task>{ [select id from task where id in :listOfTasks ]};
        for(task eachTask:tasksToUpdate )
            eachTask.status = 'Completed';
        Update tasksToUpdate;
     }*/
 }