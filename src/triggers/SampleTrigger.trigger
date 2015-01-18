trigger SampleTrigger on Opportunity (after insert) {
Opportunity TheOpportunity = trigger.new[0];
if(TheOpportunity.amount>50000){
Account theAccount= [Select  name from Account where id=:theOpportunity.Accountid];
theAccount.type='Featured';
update theAccount;
}
}