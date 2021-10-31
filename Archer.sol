pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "MilUnit.sol";

contract Archer is MilUnit{

    constructor(BaseStation baseStation) MilUnit(baseStation)public {
        addAttack();
        addProtect();
    }

    function addAttack() public override checkOwnerAndAccept{
        //Лучники получают по 5 силы атаки
        powerAttack += 5;
    }

    function addProtect() public override checkOwnerAndAccept{
        //Лучники получают по 1 силы защиты
        protect += 1;
    }
   
}