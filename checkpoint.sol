pragma solidity >=0.4.22 <0.7.0;
pragma experimental ABIEncoderV2;

contract Checkpoint {
    
    address empty_address = 0x0000000000000000000000000000000000000000;
    address owner = 0xDd6d37E29294A985E49fF301Acc80877fC24997F;
    
    event MostrarSender(address msg);
    event MostrarDoctor(Doctor msg);
    event MostrarPatient(address msg);
    event MostrarString(string msg);
    event MostrarActions(Action[] actions);
    
    struct Patient {
        address key;
        Action[] actions;
    }
    
    struct Action {
        address patient;
        address doctor;
        string hospitalName;
        string description;
        uint256 date;
        uint256 hour;
    }
    
    struct Doctor {
        address key;
        string cpf;
    }
    
    constructor() {
        
    }
    
    // key-value **
    mapping (address => Doctor) private doctors;
    
    mapping (address => Patient) private historico;
    
    mapping (address => Doctor) private authorizedViewers;
    // 
    // mapping (address => Patient) private historico;

    // realizar o atendimento
    function performAction(address patient,string memory hospitalName, string memory description, uint256 date, uint256 hour) public returns (bool) {
        // emit MostrarDoctor(containsDoctor(msg.sender));
        // emit MostrarPatient(historico[patient].key);
        // Doctor memory myKey = doctors[msg.sender];
        // emit MostrarPatient(myKey.key);
        // require(myKey != address(0x0000000000000000000000000000000000000000), "Nao e doctor");
        if(doctors[msg.sender].key == address(0x0000000000000000000000000000000000000000)) {
            emit MostrarString('Nao e doctor');
        } else {
            historico[patient].actions.push(Action(patient, msg.sender, hospitalName,description,date,hour));
        }
        // if(historico[patient].key != empty_address){
        //     historico[patient].actions;
        // }
        
        
        // historico[patient].actions = patientActions;
        return true;
    }
    
    function authorizeDoctor(address doctorKey, string memory cpf) public returns (bool) {
        require(msg.sender == owner, "Nao esta autorizado");
        doctors[doctorKey] = Doctor(doctorKey, cpf);
    }
    
    function getActions() public view returns (Action[] memory) {
        // require(patientKey == msg.sender, "So pode visualizar o seu historico");
        // TODO: somente o proprio paciente pode ver o historico e o doutor que ele der acesso
        // emit MostrarActions(historico[msg.sender].actions);
        return historico[msg.sender].actions;
    }
    
    
    
}






