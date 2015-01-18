public class ProductPageController {
    
    public Product__c c { get; set; }
    
    
    public ProductPageController() {
        c = new Product__c();
    }
    
//    public PageReference submitProduct() {
    public void submitProduct() {
        List<sObject> products= [SELECT Id FROM Product__c LIMIT 1];
        if (products.size() != 1) {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.FATAL, 'Invalid Product number');
            ApexPages.addMessage(msg);
            //return null;
        } else {
            try {
                c.Id = products.get(0).Id;
                
                // now look for an associated contact with the same email
                //Contact cnt = [SELECT Id FROM Contact WHERE AccountId = :c.AccountId AND Email = :c.SuppliedEmail LIMIT 1];
                //if (cnt != null) 
                //    c.ContactId = cnt.Id;
                    
                // Specify DML options to ensure the assignment rules are executed
                Database.DMLOptions dmlOpts = new Database.DMLOptions();
                dmlOpts.assignmentRuleHeader.useDefaultRule = true;
                c.setOptions(dmlOpts);

                // Insert the case
                UPDATE c;
                //return new PageReference('/thanks');
            } catch (Exception e) {
                ApexPages.addMessages(e);
              //  return null;
            }
        }
    }
}