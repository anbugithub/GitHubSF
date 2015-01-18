public class WarehouseSchemaController {

    public Boolean noData {get; set;}
    public String redirectString {get; set;}
    public WarehouseSchemaController() {
        Integer items = [SELECT COUNT() from Line_Item__c];
        noData = items == 0;
        redirectString = '/' + Merchandise__c.SObjectType.getDescribe().getKeyPrefix() + '/o';
    }

    
    public PageReference createData() {
            WarehouseSchemaInstall postinstall = new WarehouseSchemaInstall();
            postInstall.onInstall(null);
            
            Integer items = [SELECT COUNT() from Line_Item__c];
            noData = items == 0;
        
            return null;
    }
    
    @IsTest
    public static void TestController() {
                WarehouseSchemaController tc = new WarehouseSchemaController();
                tc.createData();
        }
    
}