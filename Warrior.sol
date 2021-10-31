pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "MilUnit.sol";

contract Warrior is MilUnit{

    constructor(BaseStation baseStation) MilUnit(baseStation) public {
        addAttack();
        addProtect();
    }

    function addAttack() public override checkOwnerAndAccept{
        //Воины получают по 5 силы атаки
        powerAttack += 3;
    }

    function addProtect() public override checkOwnerAndAccept{
        //Воины получают по 5 силы защиты
        protect += 3;
    }
   
}