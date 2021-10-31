pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "GameObject.sol";
import "MilUnit.sol" as Unit;

contract BaseStation is GameObject{

    address[] units;
    
    function addProtect() public override checkOwnerAndAccept{
        //Станции получают по 2 защиты
        protect += 2;
    }

    function addMilUnit() public {
        units.push(msg.sender);
    }

    function delMilUnit() public {
        uint key = 0;
        while (key < units.length) {
            if (units[key] == msg.sender) {
                delete units[key];
                break;
            }
        }
    }

    function doDeath(address killer) internal override{
        for (uint i = 0; i < units.length; i++){
            Unit.MilUnit(units[i]).doDeathByBase(killer);
        }
        selfDestruct(killer);
    }
}
