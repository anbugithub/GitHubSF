global with sharing class RetrieveNextUtils {
    webService static Id retrieveNextCase(String userId)
    {
        //Really we're only specifying the user ID for the sake of the test methods
        if (userId=='') {
            //Use the currently running user
            userId = UserInfo.getUserId();
        }
        
        //First find out which queues this user is a member of
        List<Id> listGroupIds = getQueuesForUser(userId);
        
        if(listGroupIds.size()>0) 
        {
            //Find an open case that is assigned to one of those queues
            Case caseObj = [select c.Id,c.OwnerId from Case c where 
                                                        c.IsClosed=false 
                                                        and c.OwnerId in :listGroupIds 
                                                        limit 1 
                                                        for update];
                                                
            if (caseObj!=null) {        
                //If we found one, assign it to the current user
                caseObj.OwnerId = userId;
                update caseObj;
                
                return caseObj.Id;
            }
        }
        
        return null;
    }
    
    webService static Id retrieveNextLead(String userId)
    {
        //Really we're only specifying the user ID for the sake of the test methods
        if (userId=='') {
            //Use the currently running user
            userId = UserInfo.getUserId();
        }
        
        //First find out which queues this user is a member of
        List<Id> listGroupIds = getQueuesForUser(userId);
        
        if(listGroupIds.size()>0) 
        {
            //Find an open lead that is assigned to one of those queues
            DateTime dt = DateTime.now();
            DateTime pt = DateTime.now();
            System.Debug ('@@@ Current Time Now'+ dt);
            dt=dt.addMinutes(15);
            System.Debug ('@@@ Curr Time after 15 mins'+ dt);
            pt=pt.addMinutes(-60);
            System.Debug ('@@@ Curr Time before 60 mins'+ pt);
            
List<task> p = [select WhoId,OwnerId,ReminderDateTime  From Task where status != 'Completed' and ReminderDateTime != null and ( ReminderDateTime < :dt and ReminderDateTime > :pt) and WhoId in (Select id from Lead)order by ReminderDateTime asc limit 1];
System.Debug ('@@@ Output'+ p);
             List<Lead> leads = [select l.Id,l.OwnerId,l.Lead_Score__c from Lead l where 
                                                        l.IsConverted=false and l.Status='Open' and l.Lead_Score__C != null 
                                                        and l.OwnerId in :listGroupIds  order by l.Lead_Score__C  desc limit 1 ];
                                                        
                                                        
                                                        
                                                        
                                                
            if (leads.size()>0) {       
                //If we found one, assign it to the current user
                leads[0].OwnerId = userId;
                update leads;
                
                return leads[0].Id;
            }
        }
        
        return null;
    }
    
    //Returns a list of ids of queues that this user is a member of
    public static List<Id> getQueuesForUser(String userId) 
    {
        List<Id> listGroupIds = new List<Id>();
        List<GroupMember> listGroupMembers = [Select g.GroupId From GroupMember g 
                                                where g.Group.Type='Queue'
                                                and g.UserOrGroupId=:userId];
                                                
        if (listGroupMembers!=null && listGroupMembers.size()>0) {      
            for (GroupMember gm:listGroupMembers) {
                listGroupIds.add(gm.GroupId);
            }
        }
        
        return listGroupIds;
    }
    
  }