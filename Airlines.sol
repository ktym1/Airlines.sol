pragma solidity ^0.6.0;


contract Airlines {
address chairperson;


// Airlines data structures
struct details (
  uint escrow; // deposit for payment settlement
  uint status;
  uint hashOfDetails;
)

// Airline account payments and membership mapping
mapping (address=>details) public balanceDetails;
mapping (address=>uint) membership;


//modifier for onlyChairperson rule
modifier onlyChairperson{
  require(msg.sender == chairperson);
  _;
}

//modifier onlyMember{
  require(membership[msg.sender]==1);
  _;
}

//constructor function
constructor () public payable {
  chairperson == msg.sender;
  
  // Usage of msg.sender and msg.value for a payable function
  membership[msg.sender] = 1; //automatically registered
  balanceDetails[msg.sender].escrow = msg.value; 
}

function register() public payable {
  address AirlineA = msg.sender;
  membership[AirlineA] = 1;
  balanceDetails[msg.sender].escrow = msg.value;
}

function unregister (address payable AirlineZ) onlyChairperson public {
  if(chairperson != msg.sender) {
    revert();
   }
  membership[AirlineZ] = 0;
  // return escrow to leaving airline: verify other conditions
  AirlineZ.transfer(balanceDetails[AirlineZ].escrow);
  balanceDetails[AirlineZ].escrow = 0;
  }
}

function request(address toAirline, uint hashOfDetails) onlyMember public {
  if(membership[toAirline]!=1) {
    revert();  
  }
   balanceDetails[msg.sender].status=0;
   balanceDetails[msg.sender].hashOfDetails = hashOfDetails;
}

function response(address fromAirline, uinthasOfDetails, uint done) } onlyMember public {
  if(membership[fromAirline]!=1) {
    revert();
  } 
  balanceDetails[msg.sender].status=done;
  balanceDetails[fromAirline].hashofDetails = hashOfDetails;
  }
}

function settlePayment (address payable toAirline) onlyMember payable public {
  address fromAirline=msg.sender;
  uint amt = msg.value;
  balanceDetails[toAirline].escrow - balanceDetails[toAirline].escrow + amt;
  balanceDetails[fromAirline].escrow = balanceDetails[fromAirline].escrow - amt;
  
  //amt subtracted from msg.sender and given to toAirline
  toAirline.transfer(amt);
}
}
