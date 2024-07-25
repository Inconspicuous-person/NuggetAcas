import mariadb
import pickle
import socket
from time import sleep

codes = []

battVolt = 13.8
battCurrent = 15
totalMotorCurrent = 0

test = 0

lastUpdate = 0

# connection parameters
conn_param_faults = {
    "user": "ACAS",
    "password": "acas",
    "host": "127.0.0.1",
    "database": "FAULTS"
}

conn_param_limits = {
    "user": "ACAS",
    "password": "acas",
    "host": "127.0.0.1",
    "database": "CONDITIONS"
}

# Establish a connection
connection_faults = mariadb.connect(**conn_param_faults)


def is_between(number, lower_bound, upper_bound):
    return lower_bound <= number <= upper_bound


def add_fault(systems, system_name, fault_description, level, fixes):
    """
    Add a fault to the specified system.
    If the system doesn't exist, it creates a new entry.
    """
    if system_name in systems:
        systems[system_name].append([fault_description, level,fixes])

    else:
        systems[system_name] = [[fault_description, level, fixes]]


def add_fault_from_database(warnings, fault_codes):
    """
    Add faults to the Warnings array from the fault database based on given fault codes.
    """
    connection_faults = mariadb.connect(**conn_param_faults)

    cursor = connection_faults.cursor()
    for code in fault_codes:
        cursor.execute("SELECT `ID` FROM `Rover_Faults` WHERE `ID` = (?)", [code])
        returned = cursor.fetchone()
        if returned:
            cursor.execute("SELECT `SYSTEM` FROM `Rover_Faults` WHERE `ID` = (?)", [code])
            system = cursor.fetchone()[0]
            cursor.execute("SELECT `SHORT` FROM `Rover_Faults` WHERE `ID` = (?)", [code])
            description = cursor.fetchone()[0]
            cursor.execute("SELECT `LEVEL` FROM `Rover_Faults` WHERE `ID` = (?)", [code])
            level = cursor.fetchone()[0]
            cursor.execute("SELECT `FIXES` FROM `Rover_Faults` WHERE `ID` = (?)", [code])
            fixes = cursor.fetchone()[0]
            add_fault(warnings, system, description, level, fixes)
        else:
            print(f"Fault code {code} not found in the database.")
    cursor.close()
    connection_faults.close()


def checkParams():
    global codes
    connection_limits = mariadb.connect(**conn_param_limits)
    cursor_limits = connection_limits.cursor()

    cursor_limits.execute("SELECT `VALUE` FROM `Rover_Limits` WHERE `NAME` = 'BATTERY_VOLT_MAX' ")
    maxBatteryVolt = cursor_limits.fetchone()[0]

    cursor_limits.execute("SELECT `VALUE` FROM `Rover_Limits` WHERE `NAME` = 'BATTERY_VOLT_MIN' ")
    minBatteryVolt = cursor_limits.fetchone()[0]

    cursor_limits.execute("SELECT `VALUE` FROM `Rover_Limits` WHERE `NAME` = 'BATTERY_CURRENT_MAX' ")
    maxBatteryCurrent = cursor_limits.fetchone()[0]

    cursor_limits.execute("SELECT `VALUE` FROM `Rover_Limits` WHERE `NAME` = 'MOTOR_CURRENT_MAX' ")
    maxMotorCurrent = cursor_limits.fetchone()[0]

    cursor_limits.execute("SELECT `VALUE` FROM `Rover_Limits` WHERE `NAME` = 'ACAS_TIMEOUT' ")
    acasTimeout = cursor_limits.fetchone()[0]

    if battVolt > float(maxBatteryVolt):    codes.append(3)  #MAIN BATTERY OVERVOLT
    if battVolt < float(minBatteryVolt):    codes.append(2)  #MAIN BATTERY UNDERVOLT
    if battCurrent > float(maxBatteryCurrent):  codes.append(27)  #BATTERY OVERCURRENT
    if totalMotorCurrent > float(maxMotorCurrent):  codes.append(6)  #MOTOR CRITICAL CURRENT
    if lastUpdate > float(acasTimeout): codes.append(1)
    if test == 1:   codes = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27]

    cursor_limits.close()
    connection_limits.close()


warnings = {}  # Initialize Warnings as an empty dictionary

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.setblocking(True)
    while True:
        codes = []
        checkParams()
        warnings = {}
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        add_fault_from_database(warnings, codes)
        formatted_warnings = [[[system, faults] for system, faults in warnings.items()], codes]
        print(formatted_warnings)
        s.connect(("127.0.0.1", 5617))

        #print(formatted_warnings)
        #print(pickle.dumps(formatted_warnings))
        s.sendall(pickle.dumps(formatted_warnings))
        s.close()
        sleep(0.5)
        lastUpdate=lastUpdate+0.5  # Make sure it is the same as the sleep
