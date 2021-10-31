pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "GameObject.sol";
import "BaseStation.sol";

contract MilUnit is GameObject {

    address private baseStationAddress;
    int internal powerAttack;

    constructor(BaseStation baseStation) public {
        require(msg.pubkey() == tvm.pubkey(), 100);
		tvm.accept();
        baseStation.addMilUnit();
        baseStationAddress = address(baseStation);
    }

    function attack(GameObjectInterf gameObjectInterf) public checkOwnerAndAccept{
        gameObjectInterf.acceptAttack(powerAttack);
    }

    function addAttack() public virtual checkOwnerAndAccept{
        //Все военные юниты получают по 1 атаке.
        powerAttack += 1;
    }

    function addProtect() public override virtual checkOwnerAndAccept{
        //Все военные юниты получают по 1 защиты.
        powerAttack += 1;
    }

    function doDeath(address killer) internal override{
        BaseStation(baseStationAddress).delMilUnit();
        selfDestruct(killer);
    }

    function doDeathByBase(address killer) public {
        require(msg.sender == baseStationAddress, 103);
        selfDestruct(killer);
    }

}