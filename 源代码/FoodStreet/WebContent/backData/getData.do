@RequestMapping(value="insertShop", method = RequestMethod.POST)
    @ResponseBody
    public void insertShop( @RequestBody String shopName, 
    HttpServletRequest request){
         System.out.println(shopName);
    }