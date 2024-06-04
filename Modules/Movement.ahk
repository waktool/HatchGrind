#Requires AutoHotkey v2.0

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


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; MOVEMENT VARIABLES
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; moveToBestEgg Function
; Description: Moves the character to the location of the best egg.
; ----------------------------------------------------------------------------------------
moveToBestEgg() {
    ; Modify the current status to indicate moving to the best egg.
    setCurrentAction("Moving To Best Egg")
    
    clickHoverboard(true)

    ; ========================================
    ; Edit the following in need.
    ; ========================================      
    Sleep 500
    moveLeft(1425 * SHINY_HOVERBOARD_MODIFIER)
    Sleep 500
    ; ========================================
    
    clickHoverboard(false)

    ; Modify the current status back to default.
    setCurrentAction("-")
}

moveAwayFromEggs() {
    setCurrentAction("Moving away from eggs...")

    ; ========================================
    ; Edit the following in need.
    ; ========================================  
    MoveRight(2250)
    ; ========================================

    setCurrentAction("-") 
}

moveToBestEggFromBestArea() {
    ; Modify the current status to indicate moving to the best egg.
    setCurrentAction("Moving To Best Egg")
    
    clickHoverboard(true)

    ; ========================================
    ; Edit the following in need.
    ; ========================================      
    Sleep 500
    moveLeft(700 * SHINY_HOVERBOARD_MODIFIER)
    Sleep 500
    ; ========================================
    
    clickHoverboard(false)

    ; Modify the current status back to default.
    setCurrentAction("-")    
}

moveToBestAreaFromBestEgg() {
    ; Modify the current status to indicate moving to the best egg.
    setCurrentAction("Moving To Best Area")
    
    clickHoverboard(true)

    ; ========================================
    ; Edit the following in need.
    ; ========================================      
    Sleep 500
    moveRight(700 * SHINY_HOVERBOARD_MODIFIER)
    Sleep 500
    ; ========================================
    
    clickHoverboard(false)

    ; Modify the current status back to default.
    setCurrentAction("-")    
}

; ----------------------------------------------------------------------------------------
; moveToCentreOfTheBestZone Function
; Description: Moves the character to the center of the best zone.
; ----------------------------------------------------------------------------------------
moveToCentreOfTheBestZone() {
    ; Modify the current status to indicate moving to the zone center.
    setCurrentAction("Moving To Zone Centre")
    
    clickHoverboard(true)

    ; ========================================
    ; Edit the following in need.
    ; ========================================    
    moveLeft(650 * SHINY_HOVERBOARD_MODIFIER)
    ; ========================================
    
    clickHoverboard(false)

    ; Modify the current status back to default.
    setCurrentAction("-")
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; MOVEMENT FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; moveRight Function
; Description: Simulates moving right by pressing and holding the 'd' key.
; Parameters:
;   - milliseconds: Duration to hold the 'd' key.
; Operation:
;   - Presses and holds the 'd' key, sleeps for specified milliseconds, then releases the key.
; Return: None; directly interacts with keyboard inputs.
; ----------------------------------------------------------------------------------------
moveRight(milliseconds) {
    Send "{d down}"
    Sleep milliseconds
    Send "{d up}"
}

; ----------------------------------------------------------------------------------------
; moveLeft Function
; Description: Simulates moving left by pressing and holding the 'a' key.
; Parameters:
;   - milliseconds: Duration to hold the 'a' key.
; Operation:
;   - Presses and holds the 'a' key, sleeps for specified milliseconds, then releases the key.
; Return: None; directly interacts with keyboard inputs.
; ----------------------------------------------------------------------------------------
moveLeft(milliseconds) {
    Send "{a down}"
    Sleep milliseconds
    Send "{a up}"
}

; ----------------------------------------------------------------------------------------
; moveUp Function
; Description: Simulates moving up by pressing and holding the 'w' key.
; Parameters:
;   - milliseconds: Duration to hold the 'w' key.
; Operation:
;   - Presses and holds the 'w' key, sleeps for specified milliseconds, then releases the key.
; Return: None; directly interacts with keyboard inputs.
; ----------------------------------------------------------------------------------------
moveUp(milliseconds) {
    Send "{w down}"
    Sleep milliseconds
    Send "{w up}"
}

; ----------------------------------------------------------------------------------------
; moveDown Function
; Description: Simulates moving down by pressing and holding the 's' key.
; Parameters:
;   - milliseconds: Duration to hold the 's' key.
; Operation:
;   - Presses and holds the 's' key, sleeps for specified milliseconds, then releases the key.
; Return: None; directly interacts with keyboard inputs.
; ----------------------------------------------------------------------------------------
moveDown(milliseconds) {
    Send "{s down}"
    Sleep milliseconds
    Send "{s up}"
}

; ----------------------------------------------------------------------------------------
; moveUpLeft Function
; Description: Simulates moving diagonally up-left by pressing and holding the 'w' and 'a' keys.
; Parameters:
;   - milliseconds: Duration to hold the 'w' and 'a' keys.
; Operation:
;   - Presses and holds both the 'w' and 'a' keys, sleeps for specified milliseconds, then releases the keys.
; Return: None; directly interacts with keyboard inputs.
; ----------------------------------------------------------------------------------------
moveUpLeft(milliseconds) {
    Send "{w down}{a down}"
    Sleep milliseconds
    Send "{w up}{a up}"
}

; ----------------------------------------------------------------------------------------
; moveUpRight Function
; Description: Simulates moving diagonally up-right by pressing and holding the 'w' and 'd' keys.
; Parameters:
;   - milliseconds: Duration to hold the 'w' and 'd' keys.
; Operation:
;   - Presses and holds both the 'w' and 'd' keys, sleeps for specified milliseconds, then releases the keys.
; Return: None; directly interacts with keyboard inputs.
; ----------------------------------------------------------------------------------------
moveUpRight(milliseconds) {
    Send "{w down}{d down}"
    Sleep milliseconds
    Send "{w up}{d up}"
}

; ----------------------------------------------------------------------------------------
; moveDownLeft Function
; Description: Simulates moving diagonally down-left by pressing and holding the 's' and 'a' keys.
; Parameters:
;   - milliseconds: Duration to hold the 's' and 'a' keys.
; Operation:
;   - Presses and holds both the 's' and 'a' keys, sleeps for specified milliseconds, then releases the keys.
; Return: None; directly interacts with keyboard inputs.
; ----------------------------------------------------------------------------------------
moveDownLeft(milliseconds) {
    Send "{s down}{a down}"
    Sleep milliseconds
    Send "{s up}{a up}"
}

; ----------------------------------------------------------------------------------------
; moveDownRight Function
; Description: Simulates moving diagonally down-right by pressing and holding the 's' and 'd' keys.
; Parameters:
;   - milliseconds: Duration to hold the 's' and 'd' keys.
; Operation:
;   - Presses and holds both the 's' and 'd' keys, sleeps for specified milliseconds, then releases the keys.
; Return: None; directly interacts with keyboard inputs.
; ----------------------------------------------------------------------------------------
moveDownRight(milliseconds) {
    Send "{s down}{d down}"
    Sleep milliseconds
    Send "{s up}{d up}"
}