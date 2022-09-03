//task :
//get funds from users 
//withdraw funds
//SET A MINIUM FUNDING VALUE IN USD


// SPDX-License-Identifier: MIT
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
pragma solidity >=0.7.0 <0.9.0;

contract FundMe {

    uint256 public minimumUSD  = 50;
    function  fund() public payable 
    {
        //payable keyword makes button red, it indicates the function can reecive or do payments

        require(msg.value>=minimumUSD,"Minimun required amount not fulfilled"); //1*10**18 wei ==1 ether
        
        //address 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
    }

    function getPrice() public view returns(uint256) {    //gets real time eth to usd value 
        //ABI
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (,int256 price,,,)=priceFeed.latestRoundData();
        return  uint256(price * 1e10);
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256){  //converting given eth to real time usd
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount)/1e18; //remove extra 0 bc in solidity it dont send in decimal value
        return ethAmountInUsd;
    }
}