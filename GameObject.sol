pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import 'GameObjectInterf.sol';

contract GameObject is GameObjectInterf {

    int internal health = 5;
    int internal protect = 0;

    function addProtect() virtual public checkOwnerAndAccept{
        //Обычные объекты получают по одной защите
        protect += 1;
    }

    function acceptAttack(int powerAttack) external override{
        tvm.accept(); 
        //Если защиты больше чем атаки, то атака не проходит
        if (powerAttack > protect) {
            health -= powerAttack - protect;
        }
        if (checkDeath()){
            doDeath(msg.sender);
        }
    }

    function checkDeath() private view returns(bool){
        return health <= 0;
    }

    function doDeath(address killer) virtual internal{
        selfDestruct(killer);
    }

    function selfDestruct(address killer) internal{ 
        killer.transfer(0, false, 160);
    }

    modifier checkOwnerAndAccept {
        require(msg.pubkey() == tvm.pubkey(), 100);
		tvm.accept();
		_;
	}
    
}