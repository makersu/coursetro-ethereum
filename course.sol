pragma solidity ^0.4.18;

contract Owned {
    address owner;
    
    function Owned() public {
        owner = msg.sender;
    }
    
   modifier onlyOwner {
       require(msg.sender == owner);
       _;
   }
}

contract Course is Owned {

    struct Instructor {
        uint age;
        string fName;
        string lName;
    }
    
    mapping (address => Instructor) instructors;
    address[] public instructorAccts;
    
    event instructorInfo(
       string fName,
       string lName,
       uint age
    );
   
    function setInstructor(address _address, uint _age, string _fName, string _lName) onlyOwner public {
        var instructor = instructors[_address];

        instructor.age = _age;
        instructor.fName = _fName;
        instructor.lName = _lName;
        
        instructorAccts.push(_address) -1;
        instructorInfo(_fName, _lName, _age);
    }
    
    function getInstructors() view public returns (address[]) {
        return instructorAccts;
    }

    function getInstructor(address ins) view public returns (uint, string, string) {
        return (instructors[ins].age, instructors[ins].fName, instructors[ins].lName);
    }
    
    function countInstructors() view public returns (uint) {
        return instructorAccts.length;
    }
    
}