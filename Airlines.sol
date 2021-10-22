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

}
