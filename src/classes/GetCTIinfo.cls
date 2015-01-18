public  class GetCTIinfo {

 public PageReference redirect() {
    String tempphone = '7326450222' ;
//String tempphone ;
            String ANINumber=ApexPages.currentPage().getParameters().get('ANI'); 
            String DNISNumber= ApexPages.currentPage().getParameters().get('DNIS');
            PageReference pageRef = new PageReference('/00Q/e');
            //pageRef.getParameters().put('lea9',ANINumber); 
            pageRef.getParameters().put('lea9',tempphone);     
            pageRef.setRedirect(true);
            return pageRef ;
    }

}