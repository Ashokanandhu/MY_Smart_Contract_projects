pragma solidity ^0.8.9 ; 

contract medicineSupplyChain {

    struct medicine {  // user defined data type

        uint medicineId ;
        string medicineName ; 
        uint manufacturerId ;
        uint distributerId ;
        uint retailerId ; 

    }

    struct manufacturer {

        uint manufacturerId ;
        string mAddress ;
  
    }

    struct distributer {

        uint distributerId ;
        string dAddress ;
    }

    struct retailer {

        uint retailerId ;
        string rAddress ;
    }

    mapping (uint => medicine )  medicineMap ;   // user defined data type 
    mapping (uint => manufacturer) manufacturerMap ;
    mapping (uint => distributer) distributerMap ;
    mapping (uint => retailer) retailerMap ; 

    function enrollManufacturer( uint _mid , string memory _mAddress  ) public {
        require (  manufacturerMap[_mid].manufacturerId  !=  _mid , "Id already exists " ) ;
         manufacturerMap[_mid].manufacturerId = _mid ;
         manufacturerMap[_mid].mAddress = _mAddress ;

    }

    function enrollDistributer( uint _did , string memory _dAddress  ) public {
        require (  distributerMap[_did].distributerId !=  _did , "Id already exists " ) ;
        distributerMap[_did].distributerId = _did ;
         distributerMap[_did].dAddress = _dAddress ;

    }

    function enrollRetailer( uint _rid , string memory _rAddress  ) public {
       require (  retailerMap[_rid].retailerId !=  _rid , "Id already exists " ) ;
         retailerMap[_rid].retailerId = _rid ;
         retailerMap[_rid].rAddress = _rAddress ;

    }


    function insertMedicineManufacturInfo ( uint _id  , uint _mid ,  string memory  _name) public {

        require (  medicineMap[_id].medicineId  !=  _id , "Id already exists " ) ;
        medicineMap[_id].medicineId = _id  ; 
        medicineMap[_id].medicineName = _name ;
        medicineMap[_id].manufacturerId = _mid ;
        // medicineMap[_id].distributerId = _did ;
        // medicineMap[_id].retailerId = _rid ; 

    }

    function insertDistributerInfo (  uint _id  , uint _did ) public {
                medicineMap[_id].distributerId = _did ;

                
                
    }

    function insertRetailerInfo ( uint _id  ,  uint _rid  )  public {

            medicineMap[_id].retailerId = _rid ;

    }

    function getInfoManufacturer (uint _mid) view public returns (uint , string memory ) {
    return ( manufacturerMap[_mid].manufacturerId , 
             manufacturerMap[_mid].mAddress )  ;    

    }

        function getInfoDistributer (uint _did) view public returns (uint , string memory ) {
    return (  distributerMap[_did].distributerId  , 
              distributerMap[_did].dAddress)  ;    

    }

        function getInfoRetailer (uint _rid) view public returns (uint , string memory ) {
    return ( retailerMap[_rid].retailerId , 
             retailerMap[_rid].rAddress )  ;    

    }

    function getMedicineInfo(  uint _id ) view public returns( uint  , string memory , uint , uint ,uint ) {

            return ( medicineMap[_id].medicineId ,
                     medicineMap[_id].medicineName ,
                     medicineMap[_id].manufacturerId ,
                     medicineMap[_id].distributerId  ,
                     medicineMap[_id].retailerId    ) ; 
    }

}
