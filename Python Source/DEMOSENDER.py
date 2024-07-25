import pickle
import socket
from time import sleep


# Rover Faults
fault_database = {
    0: {"description": "UNKNOWN", "system": "UNKNOWN"},
    1: {"description": "ACAS NO DATALINK", "system": "ACAS"},
    2: {"description": "MAIN BATTERY UNDERVOLT", "system": "ELEC"},
    3: {"description": "MAIN BATTERY OVERVOLT", "system": "ELEC"},
    4: {"description": "MOTOR CAUTION CURRENT", "system": "ELEC"},
    5: {"description": "MOTOR WARNING CURRENT", "system": "ELEC"},
    6: {"description": "MOTOR CRITICAL CURRENT", "system": "ELEC"},
    7: {"description": "LOAD SHED", "system": "ELEC"},
    8: {"description": "POWER DISTRIBUTION FAULT", "system": "ELEC"},
    9: {"description": "DRIVE 1 FAULT", "system": "DRIVE"},
    10: {"description": "DRIVE 2 FAULT", "system": "DRIVE"},
    11: {"description": "DRIVE 3 FAULT", "system": "DRIVE"},
    12: {"description": "DRIVE 4 FAULT", "system": "DRIVE"},
    13: {"description": "DRIVE 5 FAULT", "system": "DRIVE"},
    14: {"description": "DRIVE 6 FAULT", "system": "DRIVE"},
    15: {"description": "ADVISORY PACKET DROP (<10ppm)", "system": "COMMS"},
    16: {"description": "CAUTION PACKET DROP (>10ppm)", "system": "COMMS"},
    17: {"description": "WARNING PACKET DROP (>20ppm)", "system": "COMMS"},
    18: {"description": "CRITICAL PACKET DROP (>40ppm)", "system": "COMMS"},
    19: {"description": "TELEMETRY LOST", "system": "COMMS"},
    20: {"description": "INTERMITTENT TELEMETRY LOSS", "system": "COMMS"},
    21: {"description": "AUTODRIVE FAIL", "system": "AUTONOMOUS"},
    22: {"description": "AUTODRIVE DISCON", "system": "AUTONOMOUS"},
    23: {"description": "NAV NO PATH", "system": "AUTONOMOUS"},
    24: {"description": "SYSTEM DEGRADED", "system": "CONTROL"},
    25: {"description": "ALTERNATE LAW", "system": "CONTROL"},
    26: {"description": "DIRECT LAW", "system": "CONTROL"},
    27: {"description": "", "system": ""},
    28: {"description": "", "system": ""},
    29: {"description": "", "system": ""},
    30: {"description": "", "system": ""},
    31: {"description": "", "system": ""},
    32: {"description": "", "system": ""},
    33: {"description": "", "system": ""},
    34: {"description": "", "system": ""},
    35: {"description": "", "system": ""},
    36: {"description": "", "system": ""},
    37: {"description": "", "system": ""},
    38: {"description": "", "system": ""},
    39: {"description": "", "system": ""},
    40: {"description": "", "system": ""},
    # Add more fault codes as needed
}


def add_fault(systems, system_name, fault_description):
    """
    Add a fault to the specified system.
    If the system doesn't exist, it creates a new entry.
    """
    if system_name in systems:
        systems[system_name].append(fault_description)
    else:
        systems[system_name] = [fault_description]


def add_fault_from_database(warnings, fault_database, fault_codes):
    """
    Add faults to the Warnings array from the fault database based on given fault codes.
    """
    for code in fault_codes:
        if code in fault_database:
            system = fault_database[code]["system"]
            description = fault_database[code]["description"]
            add_fault(warnings, system, description)
        else:
            print(f"Fault code {code} not found in the database.")


warnings = {}  # Initialize Warnings as an empty dictionary

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.setblocking(True)
    while True:
        warnings = {}
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        codes = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26]
        add_fault_from_database(warnings, fault_database, codes)
        s.connect(("127.0.0.1", 5617))

        formatted_warnings = [[[system, faults] for system, faults in warnings.items()],codes]
        #print(formatted_warnings)
        #print(pickle.dumps(formatted_warnings))
        s.sendall(pickle.dumps(formatted_warnings))
        s.close()
        sleep(1)
