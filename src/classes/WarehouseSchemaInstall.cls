global class WarehouseSchemaInstall implements InstallHandler {
  global void onInstall(InstallContext context) {
        //create an example Merchandise object
        Merchandise__c m1 = new Merchandise__c(Name='Tiny Top', Description__c='Small spinning toy', Total_Inventory__c=100, Price__c=2.99);
        insert m1;
       
        //create an example Merchandise object
        Merchandise__c m2 = new Merchandise__c(Name='Small Boat', Description__c='Extremely portable water vehicle', Total_Inventory__c=50, Price__c=3.99);
        insert m2;
      
        Invoice_Statement__c i = new Invoice_Statement__c(Status__c='Open');
        insert i;
      
        Line_Item__c li = new Line_Item__c(Name='001', Merchandise__c = m1.Id, Invoice_Statement__c = i.Id, Unit_Price__c=m1.Price__c, Units_Sold__c=10);
        insert li;
      
        }
    
    global static void deleteAllData() {
      List<Merchandise__c> m = [SELECT ID from Merchandise__c];
      delete m;
      
        
      List<Invoice_Statement__c> i = [SELECT ID from Invoice_Statement__c];
      delete i;
        
      }    
        @isTest
        static void testInstallScript() {
          WarehouseSchemaInstall postinstall = new WarehouseSchemaInstall();
          Test.testInstall(postinstall, null);
          Test.testInstall(postinstall, new Version(1,0), true);
          List<Line_Item__c> li = [Select id, name from Line_Item__c LIMIT 1];
          System.assertEquals(li.size(), 1, 'Line items not found');
          }
}