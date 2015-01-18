trigger CompanyTrigger on Lead(before insert, before update)
{
    /* TEMP -- REMOVE */
    /* Comment written in Eclipse */
    for (Lead c : Trigger.new)
    {

            If (c.Email == 'anbu123@yahoo.com')
            
{
 c.addError('invalid email id');

        
        

    }
}
}