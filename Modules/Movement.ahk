#Requires AutoHotkey v2.0  ; Ensures the script runs only on AutoHotkey version 2.0, which supports the syntax and functions used in this script.

; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; MOVEMENT/PATHS CONFIGURATION FILE
; ----------------------------------------------------------------------------------------
; This file contains all of the character movement paths to various areas within the game.
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; GLOBAL VARIABLES
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

SHINY_HOVERBOARD_MODIFIER := (GetSetting("HasShinyHoverboard") = "true") ? 20 / 27 : 1 ; Calculate a modifier for shiny hoverboard use.

; Movement settings.
BEST_ZONE_TRAVEL_DIRECTION := GetSetting("BestZoneTravelDirection")
BEST_ZONE_TRAVEL_TIME := GetSetting("BestZoneTravelTime")
BEST_EGG_TRAVEL_DIRECTION := GetSetting("BestEggTravelDirection")
BEST_EGG_TRAVEL_TIME := GetSetting("BestEggTravelTime")
AWAY_FROM_BEST_EGG_DIRECTION := GetSetting("AwayFromEggsDirection")
AWAY_FROM_BEST_EGG_TIME := GetSetting("AwayFromEggsTime")

; ---------------------------------------------------------------------------------
; DIRECTION Map
; Description: Stores key mappings for different directions, including single keys for up, down, left, and right, as well as combinations of keys for diagonal movements.
; Operation:
;   - Defines a map named DIRECTION to store key mappings.
;   - Sets default value to an empty string.
;   - Maps single keys for basic directions: Up, Down, Left, and Right.
;   - Maps combinations of keys for diagonal movements: Up-Right, Up-Left, Down-Right, and Down-Left.
; Dependencies:
;   - Map: AHK object to store key-value pairs.
; Return: None; the map stores key mappings for various directions.
; ---------------------------------------------------------------------------------
DIRECTION := Map()
DIRECTION.Default := ""  ; Set default value to an empty string.
DIRECTION["Up"] := "W"  ; Map key for moving up.
DIRECTION["Down"] := "S"  ; Map key for moving down.
DIRECTION["Left"] := "A"  ; Map key for moving left.
DIRECTION["Right"] := "D"  ; Map key for moving right.
DIRECTION["UpRight"] := ["D", "W"]  ; Map keys for moving up-right.
DIRECTION["UpLeft"] := ["A", "W"]  ; Map keys for moving up-left.
DIRECTION["DownRight"] := ["D", "S"]  ; Map keys for moving down-right.
DIRECTION["DownLeft"] := ["A", "S"]  ; Map keys for moving down-left.


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; MOVEMENT VARIABLES
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; moveToCentreOfTheBestZone Function
; Description: Moves the character to the center of the best zone by using the hoverboard and updating the current action.
; Operation:
;   - Sets the current action to "Moving To Zone Centre".
;   - Activates the hoverboard.
;   - Stabilizes the hoverboard by simulating key presses.
;   - Moves in the specified direction for the calculated duration, factoring in the shiny hoverboard modifier.
;   - Deactivates the hoverboard.
;   - Resets the current action.
; Dependencies:
;   - setCurrentAction: Function to update the current action in the GUI.
;   - clickHoverboard: Function to activate or deactivate the hoverboard.
;   - stabiliseHoverboard: Function to stabilize the hoverboard.
;   - moveDirection: Function to simulate movement by pressing and releasing a key.
;   - DIRECTION: Map storing key mappings for different directions.
;   - BEST_ZONE_TRAVEL_DIRECTION: Key representing the direction to travel to the center of the best zone.
;   - BEST_ZONE_TRAVEL_TIME: Base duration in milliseconds to travel to the center of the best zone.
;   - SHINY_HOVERBOARD_MODIFIER: Modifier to adjust the travel time based on hoverboard type.
;   - Sleep: AHK command to pause execution for a specified duration.
; Return: None; the function moves the character to the center of the best zone.
; ---------------------------------------------------------------------------------
moveToCentreOfTheBestZone() {
    setCurrentAction("Moving To Zone Centre")  ; Set the current action.

    clickHoverboard(true)  ; Activate the hoverboard.
    stabiliseHoverboard(DIRECTION[BEST_ZONE_TRAVEL_DIRECTION])  ; Stabilize the hoverboard.
    moveDirection(DIRECTION[BEST_ZONE_TRAVEL_DIRECTION], BEST_ZONE_TRAVEL_TIME * SHINY_HOVERBOARD_MODIFIER)  ; Move in the specified direction for the calculated duration.
    clickHoverboard(false)  ; Deactivate the hoverboard.

    setCurrentAction("-")  ; Reset the current action.
}


; ---------------------------------------------------------------------------------
; moveToBestEggFromBestArea Function
; Description: Moves the character from the best area to the best egg by using the hoverboard and updating the current action.
; Operation:
;   - Sets the current action to "Moving To Best Egg".
;   - Activates the hoverboard.
;   - Stabilizes the hoverboard by simulating key presses.
;   - Moves in the specified direction for the calculated duration, factoring in the shiny hoverboard modifier.
;   - Deactivates the hoverboard.
;   - Resets the current action.
; Dependencies:
;   - setCurrentAction: Function to update the current action in the GUI.
;   - clickHoverboard: Function to activate or deactivate the hoverboard.
;   - stabiliseHoverboard: Function to stabilize the hoverboard.
;   - moveDirection: Function to simulate movement by pressing and releasing a key.
;   - DIRECTION: Map storing key mappings for different directions.
;   - BEST_EGG_TRAVEL_DIRECTION: Key representing the direction to travel to the best egg.
;   - BEST_EGG_TRAVEL_TIME: Base duration in milliseconds to travel to the best egg.
;   - SHINY_HOVERBOARD_MODIFIER: Modifier to adjust the travel time based on hoverboard type.
;   - Sleep: AHK command to pause execution for a specified duration.
; Return: None; the function moves the character from the best area to the best egg.
; ---------------------------------------------------------------------------------
moveToBestEggFromBestArea() {
    setCurrentAction("Moving To Best Egg")  ; Set the current action.
    clickHoverboard(true)  ; Activate the hoverboard.
    stabiliseHoverboard(DIRECTION[BEST_EGG_TRAVEL_DIRECTION])  ; Stabilize the hoverboard.
    moveDirection(DIRECTION[BEST_EGG_TRAVEL_DIRECTION], BEST_EGG_TRAVEL_TIME * SHINY_HOVERBOARD_MODIFIER)  ; Move in the specified direction for the calculated duration.
    Sleep 500
    clickHoverboard(false)  ; Deactivate the hoverboard.
    setCurrentAction("-")  ; Reset the current action.
}


; ---------------------------------------------------------------------------------
; moveAwayFromEggs Function
; Description: Moves the character away from the eggs by calling the moveDirection function and updating the current action.
; Operation:
;   - Sets the current action to "Moving away from eggs...".
;   - Calls the moveDirection function to move in the specified direction for a specified time.
;   - Resets the current action.
; Dependencies:
;   - setCurrentAction: Function to update the current action in the GUI.
;   - moveDirection: Function to simulate movement by pressing and releasing a key.
;   - DIRECTION: Map storing key mappings for different directions.
;   - AWAY_FROM_BEST_EGG_DIRECTION: Key representing the direction to move away from the best egg.
;   - AWAY_FROM_BEST_EGG_TIME: Duration in milliseconds to move away from the best egg.
; Return: None; the function moves the character away from the eggs and updates the current action.
; ---------------------------------------------------------------------------------
moveAwayFromEggs() {
    setCurrentAction("Moving away from eggs...")  ; Set the current action.
    moveDirection(DIRECTION[AWAY_FROM_BEST_EGG_DIRECTION], AWAY_FROM_BEST_EGG_TIME)  ; Move in the specified direction for the specified time.
    setCurrentAction("-")  ; Reset the current action.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; MOVEMENT FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; stabiliseHoverboard Function
; Description: Simulates pressing a movement key three times with short intervals and then waits for 1000 milliseconds to stabilize the hoverboard.
; Operation:
;   - Loops three times to send a key down event, wait for a short interval, and send a key up event.
;   - Waits for 1000 milliseconds after the loop to allow the hoverboard to stabilize.
; Dependencies:
;   - Send: AHK command to send key events.
;   - Sleep: AHK command to pause execution for a specified duration.
; Return: None; the function stabilizes the hoverboard by simulating key presses.
; ---------------------------------------------------------------------------------
stabiliseHoverboard(moveKey) {
    Loop 3 {
        moveDirection(moveKey, 10)
    }
    Sleep 1000  ; Wait for 1000 milliseconds to stabilize the hoverboard.
}

; ---------------------------------------------------------------------------------
; moveDirection Function
; Description: Simulates movement by sending a key down event, waiting for a specified time, and then sending a key up event.
; Operation:
;   - Sends a key down event for the specified movement key.
;   - Waits for the specified duration in milliseconds.
;   - Sends a key up event to stop the movement.
; Dependencies:
;   - Send: AHK command to send key events.
;   - Sleep: AHK command to pause execution for a specified duration.
; Return: None; the function simulates movement by pressing and releasing a key.
; ---------------------------------------------------------------------------------
moveDirection(moveKey, timeMs) {
    if IsObject(moveKey)
        Send "{" moveKey[1] " down}{" moveKey[2] " down}"
    else
        Send "{" moveKey " down}"  ; Send the key down event for the specified movement key.

    Sleep timeMs  ; Wait for the specified duration in milliseconds.

    if IsObject(moveKey)
        Send "{" moveKey[1] " up}{" moveKey[2] " up}"
    else
        Send "{" moveKey " up}"  ; Send the key down event for the specified movement key.    

}