; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; HATCH & GRIND
; ----------------------------------------------------------------------------------------
; AutoHotKey 2.0 Macro For Pet Simulator 99 (PS99) by waktool
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; DIRECTIVES & CONFIGURATIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

#Requires AutoHotKey v2.0
#SingleInstance Force
CoordMode "Mouse", "Window"
CoordMode "Pixel", "Window"
SetMouseDelay 10


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; GLOBAL VARIABLES
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

global MACRO_TITLE := "Hatch & Grind"
global MACRO_VERSION := "0.9.1"
global SETTINGS_INI := A_ScriptDir "\Settings.ini"
global ONE_SECOND := 1000
global SHOW_OCR_OUTLINE := getSetting("ShowOcrOutline")
global DARK_MODE := getSetting("DarkMode")

; Zone settings.
global FIRST_ZONE := 210
global BEST_ZONE := 214


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; LIBRARIES
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; Third-party Libraries:
#Include <OCR>
#Include <Pin>
#Include <JXON>
#Include <DarkMode>

; Macro Related Libraries:
#Include "%A_ScriptDir%\Modules"
#Include "Coords.ahk"
#Include "Delays.ahk"
#Include "Movement.ahk"
#Include "Timers.ahk"
#Include "Zones.ahk"


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; TIMERS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

SetTimer updateFlagTimer, ONE_SECOND
SetTimer updateSprinklerTimer, ONE_SECOND
SetTimer updateFruitTimer, ONE_SECOND


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; MACRO START
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

runMacro()


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; FUNCTIONS & PROCEDURES
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; runMacro Function
; Description: Completes initial tasks, shows the main GUI, activates Roblox, applies auto hatch settings, and enters a loop to perform various game actions.
; Operation:
;   - Completes initialization tasks including activating Roblox, setting the application icon, initializing the Roblox window, changing to fullscreen, and setting hotkeys.
;   - Shows the main GUI.
;   - Activates the Roblox window.
;   - Applies auto hatch settings based on values from the INI file.
;   - Enters an infinite loop to:
;       - Check for disconnection and reconnect if necessary.
;       - Claim free gifts if they are ready.
;       - Eat fruit items to gain boosts.
;       - Grind the last zone for resources.
;       - Move to the best egg area from the best grinding area.
;       - Hatch eggs to gain pets or items.
;       - Stop hatching after completing the hatching process.
; Dependencies:
;   - completeInitialisationTasks: Function to complete initial tasks.
;   - showMainGui: Function to show the main GUI.
;   - activateRoblox: Function to activate the Roblox window.
;   - applyAutoHatchSettings: Function to apply auto hatch settings.
;   - checkForDisconnection: Function to check for disconnection and reconnect if necessary.
;   - claimFreeGifts: Function to claim free gifts if they are ready.
;   - eatFruit: Function to eat fruit items to gain boosts.
;   - grindLastZone: Function to grind the last zone for resources.
;   - moveToBestEggFromBestArea: Function to move to the best egg area from the best grinding area.
;   - hatchEgg: Function to hatch eggs to gain pets or items.
;   - stopHatching: Function to stop hatching after completing the hatching process.
; Return: None; the function performs various game actions in a loop.
; ---------------------------------------------------------------------------------
runMacro() {
    completeInitialisationTasks()  ; Complete initial tasks.
    showMainGui()  ; Show the main GUI.
    activateRoblox()  ; Activate the Roblox window.
    applyAutoHatchSettings()  ; Apply auto hatch settings.
    Loop {
        checkForDisconnection()  ; Check for disconnection and reconnect if necessary.
        claimFreeGifts()  ; Claim free gifts if they are ready.
        eatFruit()  ; Eat fruit items to gain boosts.
        grindLastZone()  ; Grind the last zone for resources.
        moveToBestEggFromBestArea()  ; Move to the best egg area from the best grinding area.
        hatchEgg()  ; Hatch eggs to gain pets or items.
        stopHatching()  ; Stop hatching after completing the hatching process.
    }
}

; ---------------------------------------------------------------------------------
; showMainGui Function
; Description: Initializes the main GUI with "AlwaysOnTop" property, sets its title and font, adds a ListView and buttons, and handles events and dark mode settings.
; Operation:
;   - Creates the main GUI and sets it to always stay on top.
;   - Sets the title and font for the GUI.
;   - Adds a ListView to display flag, sprinkler, fruit, and action status.
;   - Adds buttons for pausing the macro and accessing the wiki.
;   - Displays the GUI and positions it at the top-right of the screen.
;   - Attaches event handlers to the buttons for pausing the macro and opening the wiki.
;   - Applies dark mode settings if enabled.
; Dependencies:
;   - Gui: AHK command to create a new GUI.
;   - AddListView: AHK command to add a ListView to the GUI.
;   - AddButton: AHK command to add a button to the GUI.
;   - Show, GetPos, Move: AHK commands to display, position, and move the GUI.
;   - OnEvent: AHK command to attach an event handler to a GUI control.
;   - SetWindowAttribute, SetWindowTheme: Functions to apply dark mode settings.
; Return: None; the function initializes and displays the main GUI.
; ---------------------------------------------------------------------------------
showMainGui() {

    global guiMain := Gui("+AlwaysOnTop")  ; Create the main GUI with "AlwaysOnTop" property.
    guiMain.Title := MACRO_TITLE " " MACRO_VERSION  ; Set the GUI title.
    guiMain.SetFont(, "Segoe UI")  ; Set the GUI font.

    ; Add a ListView to display flag, sprinkler, fruit, and action status.
    global lvCurrent := guiMain.AddListView("Section r1 w400", ["Flag", "Sprinkler", "Fruit", "Action"])
    lvCurrent.Add(, "0", "0", "0", "-")  ; Add a default row to the ListView.
    lvCurrent.ModifyCol(1, 60)  ; Set the width of the first column.
    lvCurrent.ModifyCol(2, 60)  ; Set the width of the second column.
    lvCurrent.ModifyCol(3, 60)  ; Set the width of the third column.
    lvCurrent.ModifyCol(4, 150)  ; Set the width of the fourth column.

    ; Add buttons for pausing the macro and accessing the wiki.
    btnPause := guiMain.AddButton("xs", "⏸ &Pause")
    btnHelp := guiMain.AddButton("yp", "🌐 &Wiki")

    guiMain.Show()  ; Display the GUI.
    guiMain.GetPos(,, &Width,)  ; Get the current width of the GUI.
    guiMain.Move(A_ScreenWidth - Width + 8, 0)  ; Move the GUI to the top-right corner of the screen.

    ; Attach event handlers to the buttons.
    btnPause.OnEvent("Click", pauseMacro)  ; Attach the pause event handler to the pause button.
    btnHelp.OnEvent("Click", openWiki)  ; Attach the wiki event handler to the help button.

    ; Apply dark mode settings if enabled.
    if (DARK_MODE == "true") {
        SetWindowAttribute(guiMain)
        SetWindowTheme(guiMain)
    }

}

; ---------------------------------------------------------------------------------
; pauseMacro Function
; Description: Pauses the macro indefinitely until it is resumed.
; Operation:
;   - Uses the Pause command with the -1 parameter to pause the script indefinitely.
; Dependencies: None.
; Return: None; the function pauses the macro and waits for a resume action.
; ---------------------------------------------------------------------------------
pauseMacro(*) {
    Pause -1  ; Pause the macro indefinitely until resumed.
}

; ---------------------------------------------------------------------------------
; exitMacro Function
; Description: Exits the macro execution.
; Operation:
;   - Uses the ExitApp command to terminate the script.
; Dependencies: None.
; Return: None; the function terminates the script execution.
; ---------------------------------------------------------------------------------
exitMacro(*) {
    ExitApp  ; Exit the macro.
}

; ---------------------------------------------------------------------------------
; openWiki Function
; Description: Opens the help text file in Notepad.
; Operation:
;   - Uses the Run command to open the specified URL in the default web browser.
; Dependencies: None.
; Return: None; the function opens the URL in the web browser.
; ---------------------------------------------------------------------------------
openWiki(*) {
    Run "https://github.com/waktool/HatchGrind/wiki"  ; Open the help text file URL.
}

; ---------------------------------------------------------------------------------
; setCurrentAction Function
; Description: Updates the current action displayed in the GUI.
; Operation:
;   - Modifies the text of the first row in the ListView to display the provided action.
; Dependencies:
;   - lvCurrent: A global variable representing the ListView control to be updated.
; Return: None; the function updates the ListView with the new action.
; ---------------------------------------------------------------------------------
setCurrentAction(currentAction) {
    lvCurrent.Modify(1, , , , , currentAction)  ; Update the ListView with the provided action.
}

; ---------------------------------------------------------------------------------
; setFlagTimer Function
; Description: Updates the flag timer displayed in the GUI.
; Operation:
;   - Modifies the text of the first row in the ListView to display the provided time.
; Dependencies:
;   - lvCurrent: A global variable representing the ListView control to be updated.
; Return: None; the function updates the ListView with the new time.
; ---------------------------------------------------------------------------------
setFlagTimer(newTime) {
    lvCurrent.Modify(1, , newTime)  ; Update the ListView with the provided time.
}

; ---------------------------------------------------------------------------------
; setSprinklerTimer Function
; Description: Updates the sprinkler timer displayed in the GUI.
; Operation:
;   - Modifies the text of the first row in the ListView to display the provided time.
; Dependencies:
;   - lvCurrent: A global variable representing the ListView control to be updated.
; Return: None; the function updates the ListView with the new time.
; ---------------------------------------------------------------------------------
setSprinklerTimer(newTime) {
    lvCurrent.Modify(1, , , newTime)  ; Update the ListView with the provided time.
}

; ---------------------------------------------------------------------------------
; setFruitTimer Function
; Description: Updates the fruit timer displayed in the GUI.
; Operation:
;   - Modifies the text of the first row in the ListView to display the provided time.
; Dependencies:
;   - lvCurrent: A global variable representing the ListView control to be updated.
; Return: None; the function updates the ListView with the new time.
; ---------------------------------------------------------------------------------
setFruitTimer(newTime) {
    lvCurrent.Modify(1, , , , newTime)  ; Update the ListView with the provided time.
}

; ---------------------------------------------------------------------------------
; grindLastZone Function
; Description: Automates the process of grinding in the last zone.
; Operation:
;   - Teleports to the first zone.
;   - Teleports to the best zone.
;   - Clicks the auto farm button.
;   - Moves to the center of the best zone.
;   - Clicks the auto farm button again.
;   - Uses the flag.
;   - Uses the sprinkler.
;   - Uses the ultimate ability.
; Dependencies:
;   - teleportToZone: Function to teleport to a specified zone.
;   - clickAutoFarmButton: Function to click the auto farm button.
;   - moveToCentreOfTheBestZone: Function to move to the center of the best zone.
;   - useFlag: Function to use the flag.
;   - useSprinkler: Function to use the sprinkler.
;   - useUltimate: Function to use the ultimate ability.
; Return: None; the function performs a series of actions to automate grinding in the last zone.
; ---------------------------------------------------------------------------------
grindLastZone() {
    teleportToZone(FIRST_ZONE)  ; Teleport to the first zone.
    teleportToZone(BEST_ZONE)  ; Teleport to the best zone.
    clickAutoFarmButton()  ; Click the auto farm button.
    moveToCentreOfTheBestZone()  ; Move to the center of the best zone.
    clickAutoFarmButton()  ; Click the auto farm button again.
    useFlag()  ; Use the flag.
    useSprinkler()  ; Use the sprinkler.
    useUltimate()  ; Use the ultimate ability.
}

; ---------------------------------------------------------------------------------
; useFlag Function
; Description: Uses a flag item if it is ready, updates the flag's usage data, and sets the next time it will be ready to use.
; Operation:
;   - Checks if the current tick count is greater than or equal to the ready-to-use time for the flag.
;   - Retrieves the flag item to use, the amount to use, and the boost length from settings.
;   - Uses the specified flag item.
;   - Updates the last used time and calculates the next ready-to-use time.
;   - Stores the updated usage data in the FLAG_DATA map.
; Dependencies:
;   - FLAG_DATA: Map storing data related to flag usage.
;   - getSetting: Function to retrieve specific settings for the flag.
;   - useItem: Function to use a specified item.
; Return: None; the function uses the flag and updates its usage data.
; ---------------------------------------------------------------------------------
useFlag() {
    if (A_TickCount >= FLAG_DATA.Get("ReadyToUse")) {  ; Check if the flag is ready to use.
        flagToUse := getSetting("FlagToUse")  ; Retrieve the flag item to use.
        amountToUse := getSetting("FlagAmountToUse")  ; Retrieve the amount to use.
        boostLength := getSetting("FlagBoostLengthSeconds") * ONE_SECOND  ; Retrieve the boost length in seconds.
        useItem(flagToUse, 2, amountToUse)  ; Use the specified flag item.
        lastUsed := A_TickCount  ; Update the last used time.
        readyToUse := lastUsed + (amountToUse * boostLength)  ; Calculate the next ready-to-use time.
        FLAG_DATA["LastUsed"] := lastUsed  ; Store the last used time.
        FLAG_DATA["ReadyToUse"] := readyToUse  ; Store the next ready-to-use time.
    }
}

; ---------------------------------------------------------------------------------
; useSprinkler Function
; Description: Uses a sprinkler item if it is ready, updates the sprinkler's usage data, and sets the next time it will be ready to use.
; Operation:
;   - Checks if the current tick count is greater than or equal to the ready-to-use time for the sprinkler.
;   - Retrieves the amount to use and the boost length from settings.
;   - Uses the sprinkler item.
;   - Updates the last used time and calculates the next ready-to-use time.
;   - Stores the updated usage data in the SPRINKLER_DATA map.
; Dependencies:
;   - SPRINKLER_DATA: Map storing data related to sprinkler usage.
;   - getSetting: Function to retrieve specific settings for the sprinkler.
;   - useItem: Function to use a specified item.
; Return: None; the function uses the sprinkler and updates its usage data.
; ---------------------------------------------------------------------------------
useSprinkler() {
    if (A_TickCount >= SPRINKLER_DATA.Get("ReadyToUse")) {  ; Check if the sprinkler is ready to use.
        amountToUse := getSetting("SprinklerAmountToUse")  ; Retrieve the amount to use.
        boostLength := getSetting("SprinklerBoostLengthSeconds") * ONE_SECOND  ; Retrieve the boost length in seconds.
        useItem("Sprinkler", 2, amountToUse)  ; Use the sprinkler item.
        lastUsed := A_TickCount  ; Update the last used time.
        readyToUse := lastUsed + (amountToUse * boostLength)  ; Calculate the next ready-to-use time.
        SPRINKLER_DATA["LastUsed"] := lastUsed  ; Store the last used time.
        SPRINKLER_DATA["ReadyToUse"] := readyToUse  ; Store the next ready-to-use time.
    }
}

; ---------------------------------------------------------------------------------
; checkForDisconnection Function
; Description: Checks for disconnection, attempts to reconnect if disconnected, and reloads the script.
; Operation:
;   - Updates the current action to "Checking Connection".
;   - Checks for disconnection using the checkForDisconnect function.
;   - If disconnected, calls the reconnectClient function and reloads the script.
;   - Resets the current action.
; Dependencies:
;   - checkForDisconnect: Function to check if the client is disconnected.
;   - reconnectClient: Function to attempt to reconnect the client.
;   - setCurrentAction: Function to update the current action in the GUI.
; Return: None; the function handles disconnection and attempts reconnection if necessary.
; ---------------------------------------------------------------------------------
checkForDisconnection() {
    setCurrentAction("Checking Connection")  ; Update the current action.

    isDisconnected := checkForDisconnect()  ; Check for disconnection.

    if (isDisconnected == true) {  ; If disconnected.
        reconnectClient()  ; Attempt to reconnect the client.
        Reload  ; Reload the script.
    }

    setCurrentAction("-")  ; Reset the current action.
}

; ---------------------------------------------------------------------------------
; closeErrorMessage Function
; Description: Attempts to close an error message by clicking a specified coordinate and waits for a specified time.
; Operation:
;   - Uses a loop to click the error message close button twice.
;   - Waits for a specified time after the error message is closed.
; Dependencies:
;   - COORDS: Map storing coordinates for various controls and buttons.
;   - leftClickMouseAndWait: Function to click a specified coordinate and wait.
;   - waitTime: Function to wait for a specified time.
; Return: None; the function attempts to close the error message and waits for the specified time.
; ---------------------------------------------------------------------------------
closeErrorMessage() {
    Loop 2 {  ; Loop to click the error message close button twice.
        leftClickMouseAndWait(COORDS["Errors"]["X"], 50)  ; Click the specified coordinate and wait.
    }
    waitTime("ErrorAfterClosed")  ; Wait for a specified time after the error message is closed.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; HATCHING FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; hatchEgg Function
; Description: Automates the process of hatching an egg.
; Operation:
;   - Sends a key event to hatch an egg.
;   - Clicks to buy the maximum number of eggs.
;   - Continuously clicks to hatch the eggs while checking for disconnection and readiness of any item to use.
; Dependencies:
;   - COORDS: Map storing coordinates for various controls and buttons.
;   - leftClickMouseAndWait: Function to click a specified coordinate and wait.
;   - leftClickMouse: Function to click a specified coordinate.
;   - checkForDisconnection: Function to check for disconnection.
;   - setCurrentAction: Function to update the current action in the GUI.
;   - isSomethingReadyToUse: Function to check if any item is ready to use.
; Return: None; the function performs a series of actions to automate egg hatching.
; ---------------------------------------------------------------------------------
hatchEgg() {
    SendEvent "{e}"  ; Send a key event to hatch an egg.
    Sleep 400
    leftClickMouseAndWait(COORDS["BuyEggs"]["BuyMax"], 200)  ; Click to buy the maximum number of eggs.
    Loop {
        setCurrentAction("Hatching Egg")  ; Update the current action.
        Loop 50 {
            leftClickMouse(COORDS["Other"]["HatchSpamClick"])  ; Click to hatch the eggs.
        }
        checkForDisconnection()  ; Check for disconnection.
        if (isSomethingReadyToUse() == true) {  ; Check if any item is ready to use.
            break
        }
    }
}

; ---------------------------------------------------------------------------------
; stopHatching Function
; Description: Stops the egg hatching process by activating Roblox, moving away from eggs, and performing a series of clicks.
; Operation:
;   - Activates the Roblox window.
;   - Updates the current action to "Stopping Hatching".
;   - Moves the character away from the eggs.
;   - Uses a loop to perform a series of clicks to stop the hatching process.
;   - Waits for a specified time after stopping the hatching process.
; Dependencies:
;   - activateRoblox: Function to activate the Roblox window.
;   - setCurrentAction: Function to update the current action in the GUI.
;   - moveAwayFromEggs: Function to move the character away from the eggs.
;   - leftClickMouse: Function to click a specified coordinate.
;   - waitTime: Function to wait for a specified time.
; Return: None; the function stops the egg hatching process.
; ---------------------------------------------------------------------------------
stopHatching() {
    activateRoblox()  ; Activate the Roblox window.
    setCurrentAction("Stopping Hatching")  ; Update the current action.
    moveAwayFromEggs()  ; Move the character away from the eggs.
    Loop 75 {
        leftClickMouse(COORDS["Other"]["HatchSpamClick"])  ; Perform a series of clicks to stop the hatching process.
    }
    waitTime(1500)  ; Wait for a specified time after stopping the hatching process.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; CONNECTION FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; checkForDisconnect Function
; Description: Checks for a disconnection message by performing OCR on a specified area and returns whether the message is found.
; Operation:
;   - Activates the Roblox window.
;   - Performs OCR on the specified area to detect a disconnection message.
;   - Returns true if the disconnection message is found, otherwise false.
; Dependencies:
;   - activateRoblox: Function to activate the Roblox window.
;   - COORDS: Map storing coordinates for various controls and buttons.
;   - OCR.FromRect: Function to perform OCR on a specified rectangular area.
;   - RegExMatch: AHK function to match a regular expression against a string.
; Return: 
;   - true if the disconnection message is found.
;   - false if the disconnection message is not found.
; ---------------------------------------------------------------------------------
checkForDisconnect() {
    activateRoblox()  ; Activate the Roblox window.
    ocrStart := COORDS["OCR"]["DisconnectMessageStart"]
    ocrSize := COORDS["OCR"]["DisconnectMessageSize"]
    ocrObjectResult := OCR.FromRect(ocrStart[1], ocrStart[2], ocrSize[1], ocrSize[2])  ; Perform OCR on the specified area.
    return (RegExMatch(ocrObjectResult.Text, "Disconnected|Reconnect|Leave"))  ; Return whether the disconnection message is found.
}

; ---------------------------------------------------------------------------------
; reconnectClient Function
; Description: Attempts to reconnect the client using a private server link code if available, and updates the current action during the reconnection process.
; Operation:
;   - Retrieves the reconnect time and private server link code from settings.
;   - If the private server link code is not available, runs the Roblox place ID directly.
;   - If the private server link code is available, runs the Roblox place ID with the link code.
;   - Uses a loop to update the current action and wait for the reconnect time.
; Dependencies:
;   - getSetting: Function to retrieve specific settings for the reconnect time and private server link code.
;   - setCurrentAction: Function to update the current action in the GUI.
; Return: None; the function attempts to reconnect the client.
; ---------------------------------------------------------------------------------
reconnectClient(*) {
    reconnectTime := getSetting("ReconnectTimeSeconds")  ; Retrieve the reconnect time.
    privateServerLinkCode := getSetting("PrivateServerLinkCode")  ; Retrieve the private server link code.
    if (privateServerLinkCode == "") {
        try Run "roblox://placeID=8737899170"  ; Run the Roblox place ID directly if no link code is available.
    }
    else {
        try Run "roblox://placeID=8737899170&linkCode=" privateServerLinkCode  ; Run the Roblox place ID with the link code if available.
    }
    Loop reconnectTime {
        setCurrentAction("Reconnecting " A_Index "/" reconnectTime)  ; Update the current action.
        Sleep ONE_SECOND  ; Wait for one second.
    }
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; ULTIMATE FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; useUltimate Function
; Description: Uses the ultimate ability and updates the current action.
; Operation:
;   - Sets the current action to "Using Ultimate".
;   - Sends a left-click event to use the ultimate ability at the specified coordinates.
;   - Waits for a specified time after using the ultimate.
; Dependencies:
;   - setCurrentAction: Function to update the current action in the GUI.
;   - COORDS: Map storing coordinates for various controls and buttons.
;   - leftClickMouseAndWait: Function to click a specified coordinate and wait.
; Return: None; the function uses the ultimate ability and updates the current action.
; ---------------------------------------------------------------------------------
useUltimate() {
    setCurrentAction("Using Ultimate")  ; Update the current action.
    leftClickMouseAndWait(COORDS["Controls"]["Ultimate"], "UltimateAfterUsed")  ; Click to use the ultimate ability and wait.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; TIMER FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; isSomethingReadyToUse Function
; Description: Checks if either a flag or a sprinkler is ready to use.
; Operation:
;   - Calls the isFlagReadyToUse function to check if a flag is ready to use.
;   - Calls the isSprinklerReadyToUse function to check if a sprinkler is ready to use.
;   - Returns true if either a flag or a sprinkler is ready to use.
; Dependencies:
;   - isFlagReadyToUse: Function to check if a flag is ready to use.
;   - isSprinklerReadyToUse: Function to check if a sprinkler is ready to use.
; Return: 
;   - true if either a flag or a sprinkler is ready to use.
;   - false if neither a flag nor a sprinkler is ready to use.
; ---------------------------------------------------------------------------------
isSomethingReadyToUse() {
    isFlagReady := isFlagReadyToUse()  ; Check if a flag is ready to use.
    isSprinklerReady := isSprinklerReadyToUse()  ; Check if a sprinkler is ready to use.
    return (isFlagReady == true || isSprinklerReady == true)  ; Return true if either is ready to use.
}

; ---------------------------------------------------------------------------------
; isFlagReadyToUse Function
; Description: Checks if flags are enabled and if a flag is ready to use.
; Operation:
;   - Retrieves the flag usage setting.
;   - Returns false if flag usage is disabled.
;   - Checks if the current tick count is greater than or equal to the ready-to-use time for the flag.
; Dependencies:
;   - getSetting: Function to retrieve specific settings for flag usage.
;   - FLAG_DATA: Map storing data related to flag usage.
; Return: 
;   - true if flags are enabled and a flag is ready to use.
;   - false if flags are disabled or not ready to use.
; ---------------------------------------------------------------------------------
isFlagReadyToUse() {
    if (getSetting("useFlags") == "false")
        return false    
    return (A_TickCount >= FLAG_DATA.Get("ReadyToUse"))  ; Check if a flag is ready to use.
}

; ---------------------------------------------------------------------------------
; isSprinklerReadyToUse Function
; Description: Checks if sprinklers are enabled and if a sprinkler is ready to use.
; Operation:
;   - Retrieves the sprinkler usage setting.
;   - Returns false if sprinkler usage is disabled.
;   - Checks if the current tick count is greater than or equal to the ready-to-use time for the sprinkler.
; Dependencies:
;   - getSetting: Function to retrieve specific settings for sprinkler usage.
;   - SPRINKLER_DATA: Map storing data related to sprinkler usage.
; Return: 
;   - true if sprinklers are enabled and a sprinkler is ready to use.
;   - false if sprinklers are disabled or not ready to use.
; ---------------------------------------------------------------------------------
isSprinklerReadyToUse() {
    if (getSetting("UseSprinklers") == "false")
        return false
    return (A_TickCount >= SPRINKLER_DATA.Get("ReadyToUse"))  ; Check if a sprinkler is ready to use.
}

; ---------------------------------------------------------------------------------
; updateFlagTimer Function
; Description: Updates the flag timer displayed in the GUI.
; Operation:
;   - Checks if the flag was used.
;   - Calculates the time remaining until the flag is ready to use.
;   - Converts the remaining time to minutes and seconds format.
;   - Updates the flag timer in the GUI.
; Dependencies:
;   - FLAG_DATA: Map storing data related to flag usage.
;   - convertTimeToMinutesSeconds: Function to convert time to minutes and seconds format.
;   - setFlagTimer: Function to update the flag timer in the GUI.
; Return: None; the function updates the flag timer in the GUI.
; ---------------------------------------------------------------------------------
updateFlagTimer() {
    if (FLAG_DATA.Get("LastUsed") != 0) {  ; Check if the flag was used.
        timeRemaining := FLAG_DATA.Get("ReadyToUse") - A_TickCount  ; Calculate the time remaining.
        timeRemaining := timeRemaining >= 0 ? timeRemaining : 0  ; Ensure the remaining time is not negative.
        timeRemainingText := convertTimeToMinutesSeconds(timeRemaining)  ; Convert to minutes and seconds format.
        setFlagTimer(timeRemainingText)  ; Update the flag timer in the GUI.
    }
}

; ---------------------------------------------------------------------------------
; updateSprinklerTimer Function
; Description: Updates the sprinkler timer displayed in the GUI.
; Operation:
;   - Checks if the sprinkler was used.
;   - Calculates the time remaining until the sprinkler is ready to use.
;   - Converts the remaining time to minutes and seconds format.
;   - Updates the sprinkler timer in the GUI.
; Dependencies:
;   - SPRINKLER_DATA: Map storing data related to sprinkler usage.
;   - convertTimeToMinutesSeconds: Function to convert time to minutes and seconds format.
;   - setSprinklerTimer: Function to update the sprinkler timer in the GUI.
; Return: None; the function updates the sprinkler timer in the GUI.
; ---------------------------------------------------------------------------------
updateSprinklerTimer() {
    if (SPRINKLER_DATA.Get("LastUsed") != 0) {  ; Check if the sprinkler was used.
        timeRemaining := SPRINKLER_DATA.Get("ReadyToUse") - A_TickCount  ; Calculate the time remaining.
        timeRemaining := timeRemaining >= 0 ? timeRemaining : 0  ; Ensure the remaining time is not negative.
        timeRemainingText := convertTimeToMinutesSeconds(timeRemaining)  ; Convert to minutes and seconds format.
        setSprinklerTimer(timeRemainingText)  ; Update the sprinkler timer in the GUI.
    }
}

; ---------------------------------------------------------------------------------
; updateFruitTimer Function
; Description: Updates the fruit timer displayed in the GUI.
; Operation:
;   - Checks if the fruit was used.
;   - Calculates the time remaining until the fruit is ready to use.
;   - Converts the remaining time to minutes and seconds format.
;   - Updates the fruit timer in the GUI.
; Dependencies:
;   - FRUIT_DATA: Map storing data related to fruit usage.
;   - convertTimeToMinutesSeconds: Function to convert time to minutes and seconds format.
;   - setFruitTimer: Function to update the fruit timer in the GUI.
; Return: None; the function updates the fruit timer in the GUI.
; ---------------------------------------------------------------------------------
updateFruitTimer() {
    if (FRUIT_DATA.Get("LastUsed") != 0) {  ; Check if the fruit was used.
        timeRemaining := FRUIT_DATA.Get("ReadyToUse") - A_TickCount  ; Calculate the time remaining.
        timeRemaining := timeRemaining >= 0 ? timeRemaining : 0  ; Ensure the remaining time is not negative.
        timeRemainingText := convertTimeToMinutesSeconds(timeRemaining)  ; Convert to minutes and seconds format.
        setFruitTimer(timeRemainingText)  ; Update the fruit timer in the GUI.
    }
}

; ---------------------------------------------------------------------------------
; convertTimeToMinutesSeconds Function
; Description: Converts time from milliseconds to a format of minutes and seconds.
; Operation:
;   - Calculates the number of minutes by dividing the milliseconds by the number of milliseconds in a second and then by 60.
;   - Calculates the remaining seconds using the modulus operator.
;   - Returns the time in "Xm Ys" format.
; Dependencies:
;   - ONE_SECOND: Constant representing the number of milliseconds in one second.
; Return: 
;   - A string representing the time in "Xm Ys" format.
; ---------------------------------------------------------------------------------
convertTimeToMinutesSeconds(milliseconds) {
    minutes := Floor(milliseconds / ONE_SECOND / 60)  ; Calculate the number of minutes.
    seconds := Round(Mod(milliseconds / ONE_SECOND, 60))  ; Calculate the remaining seconds.
    return minutes "m " seconds "s"  ; Return the time in "Xm Ys" format.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; TELEPORT FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; teleportToZone Function
; Description: Teleports to a specified zone number, updating the current action, handling the teleport menu, and verifying the teleportation.
; Operation:
;   - Activates the Roblox window.
;   - Updates the current action to indicate the teleportation process.
;   - Closes and opens the teleport menu.
;   - Clicks the search box and enters the zone name.
;   - Moves the mouse to the zone's coordinates and activates mouse hover.
;   - Checks the pixel color to verify teleportation.
;   - Closes the teleport menu and error messages if any.
;   - Returns true if the zone is already selected, otherwise false.
; Dependencies:
;   - activateRoblox: Function to activate the Roblox window.
;   - setCurrentAction: Function to update the current action in the GUI.
;   - closeTeleportMenu: Function to close the teleport menu.
;   - openTeleportMenu: Function to open the teleport menu.
;   - leftClickMouseAndWait: Function to click a specified coordinate and wait.
;   - COORDS: Map storing coordinates for various controls and buttons.
;   - ZONE: Map storing zone numbers and their corresponding names.
;   - SendText: Function to send text input.
;   - MouseMove: Function to move the mouse to a specified coordinate.
;   - activateMouseHover: Function to activate mouse hover.
;   - PixelGetColor: Function to get the color of a pixel at a specified coordinate.
;   - closeErrorMessage: Function to close error messages.
;   - DELAY: Map storing delay times for various actions.
; Return: 
;   - true if the zone is already selected.
;   - false if the zone was not already selected and the function attempted to select it.
; ---------------------------------------------------------------------------------
teleportToZone(zoneNumber) {
    activateRoblox()  ; Activate the Roblox window.
    setCurrentAction("Teleporting to Zone " zoneNumber)  ; Update the current action.
    closeTeleportMenu()  ; Close the teleport menu.
    openTeleportMenu()  ; Open the teleport menu.
    leftClickMouseAndWait(COORDS["Teleport"]["Search"], "TeleportAfterSearchClicked")  ; Click the search box and wait.
    zoneName := ZONE.Get(zoneNumber)  ; Get the zone name from the zone number.
    SendText zoneName  ; Enter the zone name.
    Sleep DELAY["TeleportAfterSearchCompleted"]  ; Wait for the search to complete.
    MouseMove COORDS["Teleport"]["Zone"][1], COORDS["Teleport"]["Zone"][2]  ; Move the mouse to the zone's coordinates.
    activateMouseHover()  ; Activate mouse hover.
    pixelColour := PixelGetColor(COORDS["Teleport"]["Zone"][1], COORDS["Teleport"]["Zone"][2])  ; Get the pixel color at the zone's coordinates.
    if (pixelColour == 0x5edefe) {  ; Check if the zone is already selected.
        closeTeleportMenu()  ; Close the teleport menu.
        return true  ; Return true if the zone is already selected.
    }
    leftClickMouseAndWait(COORDS["Teleport"]["Zone"], 250)  ; Click to select the zone and wait.
    closeTeleportMenu()  ; Close the teleport menu.
    closeErrorMessage()  ; Close error messages if any.
    Sleep DELAY["TeleportAfterZoneClicked"]  ; Wait after clicking the zone.
    return false  ; Return false if the zone was not already selected.
}

; ---------------------------------------------------------------------------------
; openTeleportMenu Function
; Description: Opens the teleport menu by clicking the teleport control and waits for the menu to open.
; Operation:
;   - Sends a left-click event to the teleport control coordinates.
;   - Waits for the menu to open.
; Dependencies:
;   - COORDS: Map storing coordinates for various controls and buttons.
;   - leftClickMouseAndWait: Function to click a specified coordinate and wait.
; Return: None; the function opens the teleport menu.
; ---------------------------------------------------------------------------------
openTeleportMenu() {
    leftClickMouseAndWait(COORDS["Controls"]["Teleport"], "TeleportAfterOpened")  ; Click the teleport control and wait.
}

; ---------------------------------------------------------------------------------
; closeTeleportMenu Function
; Description: Closes the teleport menu by clicking the close button and waits for the menu to close.
; Operation:
;   - Sends a left-click event to the close button coordinates of the teleport menu.
;   - Waits for the menu to close.
; Dependencies:
;   - COORDS: Map storing coordinates for various controls and buttons.
;   - leftClickMouseAndWait: Function to click a specified coordinate and wait.
; Return: None; the function closes the teleport menu.
; ---------------------------------------------------------------------------------
closeTeleportMenu() {
    leftClickMouseAndWait(COORDS["Teleport"]["X"], "TeleportAfterMenuClosed")  ; Click the close button of the teleport menu and wait.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; INVENTORY FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; openInventoryMenu Function
; Description: Opens the inventory menu by sending a key event and waits for a specified delay.
; Operation:
;   - Sends the "f" key event to open the inventory menu.
;   - Waits for the specified delay after opening the inventory menu.
; Dependencies:
;   - DELAY: Map storing delay times for various actions.
; Return: None; the function opens the inventory menu and waits for the specified delay.
; ---------------------------------------------------------------------------------
openInventoryMenu() {
    SendEvent "{f}"  ; Send the "f" key event to open the inventory menu.
    Sleep DELAY["InventoryAfterOpened"]  ; Wait for the specified delay after opening the inventory menu.
}

; ---------------------------------------------------------------------------------
; closeInventoryMenu Function
; Description: Closes the inventory menu by clicking the close button and waits for the menu to close.
; Operation:
;   - Sends a left-click event to the close button coordinates of the inventory menu.
;   - Waits for the menu to close.
; Dependencies:
;   - COORDS: Map storing coordinates for various controls and buttons.
;   - leftClickMouseAndWait: Function to click a specified coordinate and wait.
; Return: None; the function closes the inventory menu.
; ---------------------------------------------------------------------------------
closeInventoryMenu() {
    leftClickMouseAndWait(COORDS["Inventory"]["X"], "InventoryAfterClosed")  ; Click the close button of the inventory menu and wait.
}

; ---------------------------------------------------------------------------------
; clickInventoryTab Function
; Description: Clicks the specified inventory tab and waits for the tab to be clicked.
; Operation:
;   - Determines the coordinates of the specified inventory tab based on the tab index.
;   - Sends a left-click event to the tab's coordinates and waits for the tab to be clicked.
; Dependencies:
;   - COORDS: Map storing coordinates for various controls and buttons.
;   - leftClickMouseAndWait: Function to click a specified coordinate and wait.
; Return: None; the function clicks the specified inventory tab.
; ---------------------------------------------------------------------------------
clickInventoryTab(tabToUse) {
    Switch tabToUse {
        Case 2:  ; Tab index for the "Items" tab.
            inventoryTab := COORDS["Inventory"]["Items"]
        Case 3:  ; Tab index for the "Potions" tab.
            inventoryTab := COORDS["Inventory"]["Potions"]
        Default:
    }
    leftClickMouseAndWait(inventoryTab, "InventoryAfterTabClicked")  ; Click the tab and wait.
}

; ---------------------------------------------------------------------------------
; useItem Function
; Description: Opens the inventory menu, navigates to the specified tab, searches for a specified item, and attempts to use the item.
; Operation:
;   - Opens the inventory menu.
;   - Clicks the specified inventory tab.
;   - Clicks the inventory search box.
;   - Searches for the specified item in the inventory.
;   - If the item is found, clicks to use the item with the specified amount and options.
;   - Closes the inventory menu and error message window.
;   - Moves the mouse to the center of the screen.
; Dependencies:
;   - openInventoryMenu: Function to open the inventory menu.
;   - clickInventoryTab: Function to click the specified inventory tab.
;   - clickInventorySearchBox: Function to click the inventory search box.
;   - searchInventoryForItem: Function to search for the specified item in the inventory.
;   - clickItem: Function to click and use the specified item.
;   - closeInventoryMenu: Function to close the inventory menu.
;   - closeErrorMessageWindow: Function to close the error message window.
;   - moveMouseToCentreOfScreen: Function to move the mouse to the center of the screen.
; Return: 
;   - true if the item is found and used.
;   - false if the item is not found or any step fails.
; ---------------------------------------------------------------------------------
useItem(itemToUse, tabToUse := 2, amountToUse := 1, useMaxItem := false, checkForitemFound := false) {
    openInventoryMenu()  ; Open the inventory menu.
    clickInventoryTab(tabToUse)  ; Click the specified inventory tab.
    clickInventorySearchBox()  ; Click the inventory search box.

    if (checkForitemFound == false) {
        searchInventoryForItem(tabToUse, itemToUse)  ; Search for the item in the inventory.
        isitemFound := true  ; Assume item is found.
    } else {
        isitemFound := searchInventoryForItem(tabToUse, itemToUse)  ; Check if the item is found.
    }

    if (isitemFound == true) {
        clickItem(tabToUse, amountToUse, useMaxItem)  ; Click to use the item with the specified amount and options.
    }

    closeInventoryMenu()  ; Close the inventory menu.
    closeErrorMessageWindow()  ; Close the error message window.
    moveMouseToCentreOfScreen()  ; Move the mouse to the center of the screen.
    return isitemFound  ; Return whether the item was found and used.
}

; ---------------------------------------------------------------------------------
; clickItem Function
; Description: Clicks the specified item in the inventory, handling multiple item use and specific options like using the maximum amount.
; Operation:
;   - Determines the coordinates of the specified inventory tab based on the tab index.
;   - If useMaxItem is true, attempts to use the maximum amount of the item.
;   - Uses OCR to find and click the "Max" button or the highest available quantity.
;   - If not using the maximum amount, clicks the item the specified number of times.
; Dependencies:
;   - COORDS: Map storing coordinates for various controls and buttons.
;   - rightClickMouseAndWait: Function to right-click a specified coordinate and wait.
;   - leftClickMouseAndWait: Function to left-click a specified coordinate and wait.
;   - getOcrResult: Function to obtain OCR results from a specified area.
; Return: None; the function clicks the specified item in the inventory.
; ---------------------------------------------------------------------------------
clickItem(tabToUse, amountToUse, useMaxItem) {
    ; Determine the coordinates of the specified inventory tab based on the tab index.
    Switch tabToUse {
        Case 2:  ; Tab index for the "Items" tab.
            inventoryTab := COORDS["Inventory"]["Item1"]
        Case 3:  ; Tab index for the "Potions" tab.
            inventoryTab := COORDS["Inventory"]["Potion1"]
        Default:
    }

    multipleItemUsed := false  ; Initialize the flag for multiple item usage.

    ; If useMaxItem is true, attempt to use the maximum amount of the item.
    if (useMaxItem) {
        rightClickMouseAndWait(inventoryTab, 200)  ; Right-click the item to open the menu.
        ocrObjectResult := getOcrResult(COORDS["OCR"]["FruitMenuStart"], COORDS["OCR"]["FruitMenuSize"], 5, false)  ; Obtain text from the item menu using OCR.
        ocrTextResult := ocrObjectResult.Text

        ; Determine the search string based on the OCR result.
        searchString := ""
        if InStr(ocrTextResult, "Max") {
            searchString := "Max"
        } else if InStr(ocrTextResult, "20") {
            searchString := "20"
        } else if InStr(ocrTextResult, "10") {
            searchString := "10"
        } else if InStr(ocrTextResult, "5") {
            searchString := "5"
        }
        Sleep 200  ; Wait for a short period.

        ; If a valid search string is found, click the corresponding button.
        if (searchString != "") {
            try {
                eatMaxButtonStart := ocrObjectResult.FindString(searchString)  ; Find the position of the search string in the OCR result.
                Sleep 200  ; Wait for a short period.
                eatMaxButton := [COORDS["OCR"]["FruitMenuStart"][1] + eatMaxButtonStart.X + (eatMaxButtonStart.W / 2), COORDS["OCR"]["FruitMenuStart"][2] + eatMaxButtonStart.Y + (eatMaxButtonStart.H / 2)]
                leftClickMouseAndWait(eatMaxButton, 200)  ; Click the "Max" button.
                multipleItemUsed := true  ; Set the flag to indicate that multiple items were used.
            }
            catch {
                multipleItemUsed := false  ; Reset the flag if an error occurs.
            }
        } else {
            leftClickMouseAndWait(inventoryTab, "InventoryAfterItemClicked")  ; Click the item if "Max" is not available.
        }
    }

    ; If not using the maximum amount or multiple item usage was not successful, click the item the specified number of times.
    if (!multipleItemUsed) {
        if (amountToUse == 1) {
            leftClickMouseAndWait(inventoryTab, "InventoryAfterItemClicked")  ; Click the item once.
        } else {
            Loop amountToUse { 
                leftClickMouseAndWait(inventoryTab, "InventoryBetweenMultipleItemsUsed")  ; Click the item multiple times.
            }
        }
    }
}

; ---------------------------------------------------------------------------------
; clickInventorySearchBox Function
; Description: Clicks the search box in the inventory and waits for the action to be completed.
; Operation:
;   - Sends a left-click event to the search box coordinates in the inventory.
;   - Waits for the search box to be clicked.
; Dependencies:
;   - COORDS: Map storing coordinates for various controls and buttons.
;   - leftClickMouseAndWait: Function to click a specified coordinate and wait.
; Return: None; the function clicks the search box in the inventory.
; ---------------------------------------------------------------------------------
clickInventorySearchBox() {
    leftClickMouseAndWait(COORDS["Inventory"]["Search"], "InventoryAfterSearchClicked")  ; Click the search box and wait.
}

; ---------------------------------------------------------------------------------
; closeErrorMessageWindow Function
; Description: Attempts to close an error message window by clicking a specified coordinate and waits for a specified time.
; Operation:
;   - Uses a loop to click the error message close button twice.
;   - Waits for a specified time after the error message is closed.
; Dependencies:
;   - COORDS: Map storing coordinates for various controls and buttons.
;   - leftClickMouseAndWait: Function to click a specified coordinate and wait.
;   - waitTime: Function to wait for a specified time.
; Return: None; the function attempts to close the error message and waits for the specified time.
; ---------------------------------------------------------------------------------
closeErrorMessageWindow() {
    Loop 2 {  ; Loop to click the error message close button twice.
        leftClickMouseAndWait(COORDS["Errors"]["X"], 50)  ; Click the specified coordinate and wait.
    }
    waitTime("ErrorAfterClosed")  ; Wait for a specified time after the error message is closed.
}

; ---------------------------------------------------------------------------------
; searchInventoryForItem Function
; Description: Searches for an item in the inventory by sending text input and checking if the item is found.
; Operation:
;   - Sends the text input for the item to be searched.
;   - Waits for the search to complete.
;   - Determines the coordinates of the first item slot based on the tab index.
;   - Performs a pixel search to check if the item is found.
; Dependencies:
;   - COORDS: Map storing coordinates for various controls and buttons.
;   - SendText: Function to send text input.
;   - waitTime: Function to wait for a specified time.
;   - PixelSearch: AHK function to search for a pixel within a specified area.
; Return: 
;   - true if the item is found.
;   - false if the item is not found.
; ---------------------------------------------------------------------------------
searchInventoryForItem(tabToUse, itemToUse) {
    SendText(itemToUse)  ; Send the text input for the item to be searched.
    waitTime("InventoryAfterSearchCompleted")  ; Wait for the search to complete.

    ; Determine the coordinates of the first item slot based on the tab index.
    Switch tabToUse {
        Case 2:  ; Locate first item slot under "Items".
            inventoryTab := COORDS["Inventory"]["Item1"]
        Case 3:  ; Locate first item slot under "Potions".
            inventoryTab := COORDS["Inventory"]["Potion1"]
        Default:
    }

    ; Perform a pixel search to check if the item is found.
    return !(PixelSearch(&X, &Y, inventoryTab[1], inventoryTab[2], inventoryTab[1], inventoryTab[2], 0xFFFFFF, 5)) 
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; FRUIT FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; eatFruit Function
; Description: Checks if eating fruit is enabled, iterates through a list of fruits to use them, and updates the fruit's usage data.
; Operation:
;   - Checks the setting to determine if eating fruit is enabled.
;   - Defines an array of fruit items to be used.
;   - Iterates through the fruit array and uses each fruit item.
;   - Closes the inventory menu and error message window.
;   - Calculates the boost length and updates the last used and ready-to-use times for the fruit.
; Dependencies:
;   - getSetting: Function to retrieve specific settings.
;   - useItem: Function to use a specified item.
;   - closeInventoryMenu: Function to close the inventory menu.
;   - closeErrorMessageWindow: Function to close the error message window.
;   - FRUIT_DATA: Map storing data related to fruit usage.
; Return: None; the function uses the specified fruit items and updates their usage data.
; ---------------------------------------------------------------------------------
eatFruit() {
    if (getSetting("EatFruit") == "true") {  ; Check if eating fruit is enabled.
        fruitArray := ["Apple", "Banana", "Orange", "Pineapple", "Rainbow Fruit", "Watermelon"]  ; Define an array of fruit items.
        
        for fruitItem in fruitArray {
            useItem(fruitItem, 2, 2, true)  ; Use each fruit item.
        }
        
        closeInventoryMenu()  ; Close the inventory menu.
        closeErrorMessageWindow()  ; Close the error message window.
        
        boostLength := getSetting("FruitTimeBetweenUseSeconds") * 1000  ; Calculate the boost length in milliseconds.
        lastUsed := A_TickCount  ; Get the current tick count as the last used time.
        readyToUse := lastUsed + boostLength  ; Calculate the next ready-to-use time.
        
        FRUIT_DATA["LastUsed"] := lastUsed  ; Update the last used time for the fruit.
        FRUIT_DATA["ReadyToUse"] := readyToUse  ; Update the next ready-to-use time for the fruit.
    }
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; MACRO FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; setApplicationIcon Function
; Description: Sets the application icon using an icon file located in the "Assets" directory.
; Operation:
;   - Constructs the path to the icon file based on the working directory.
;   - Sets the tray icon to the specified icon file.
; Dependencies:
;   - A_WorkingDir: AHK built-in variable representing the current working directory.
;   - TraySetIcon: AHK command to set the tray icon.
; Return: None; the function sets the application icon.
; ---------------------------------------------------------------------------------
setApplicationIcon() {
    iconFile := A_WorkingDir . "\Assets\Tray.ico"  ; Construct the path to the icon file.
    TraySetIcon iconFile  ; Set the tray icon to the specified icon file.
}

; ---------------------------------------------------------------------------------
; waitTime Function
; Description: Pauses execution for a specified time, either an integer value or a predefined delay.
; Operation:
;   - Checks if the provided time is an integer.
;   - If it is an integer, pauses execution for that many milliseconds.
;   - If it is not an integer, treats it as a key to look up in the DELAY map and pauses execution for the corresponding value.
; Dependencies:
;   - Sleep: Function to pause the script for a specified duration.
;   - IsInteger: Function to check if a value is an integer.
;   - DELAY: Map storing delay times for various actions.
; Return: None; the function pauses execution for the specified time.
; ---------------------------------------------------------------------------------
waitTime(Time) {
    Sleep (IsInteger(Time) ? Time : DELAY[Time])  ; Pause execution for the specified time.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; CLIENT FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; activateRoblox Function
; Description: Activates the Roblox game window, ensuring it's the current foreground application.
; Operation:
;   - Attempts to activate the Roblox window using its executable name.
;   - If the window cannot be found, displays an error message and exits the application.
;   - Waits for a predefined delay after successful activation to stabilize the environment.
; Dependencies:
;   - WinActivate: AHK command to focus a window based on given criteria.
;   - MsgBox, ExitApp: Functions to handle errors and exit the script.
;   - Sleep: Function to pause the script, ensuring timing consistency.
;   - DELAY: Map storing delay times for various actions.
; Return: None; the function directly interacts with the system's window management.
; ---------------------------------------------------------------------------------
activateRoblox() {
    try {
        WinActivate "ahk_exe RobloxPlayerBeta.exe"  ; Try to focus on the Roblox window.
    } catch {
        MsgBox "Roblox window not found."  ; Display an error message if the window is not found.
        ExitApp  ; Exit the script.
    }
    Sleep DELAY["AfterRobloxActivated"]  ; Wait for a predefined delay after activation.
}

; ---------------------------------------------------------------------------------
; initialiseRobloxWindow Function
; Description: Moves and maximizes the Roblox game window to cover the entire screen.
; Operation:
;   - Moves the Roblox window to the top-left corner of the screen and resizes it to cover the entire screen width and height.
;   - Maximizes the Roblox window to ensure it is in full-screen mode.
; Dependencies:
;   - WinMove: AHK command to move and resize a window based on given criteria.
;   - WinMaximize: AHK command to maximize a window.
;   - A_ScreenWidth, A_ScreenHeight: AHK built-in variables representing the screen width and height.
; Return: None; the function directly interacts with the system's window management.
; ---------------------------------------------------------------------------------
initialiseRobloxWindow() {
    WinMove 0, 0, A_ScreenWidth, A_ScreenHeight, "ahk_exe RobloxPlayerBeta.exe"  ; Move and resize the Roblox window.
    WinMaximize "ahk_exe RobloxPlayerBeta.exe"  ; Maximize the Roblox window.
}

; ---------------------------------------------------------------------------------
; changeToFullscreen Function
; Description: Checks if the Roblox window height matches the screen height and sends the F11 key to toggle fullscreen if it does not.
; Operation:
;   - Retrieves the position and size of the Roblox window.
;   - Compares the height of the Roblox window with the screen height.
;   - If the heights do not match, sends the F11 key to toggle fullscreen mode.
; Dependencies:
;   - WinGetPos: AHK command to get the position and size of a window.
;   - A_ScreenHeight: AHK built-in variable representing the screen height.
;   - Send: AHK command to send key events.
; Return: None; the function toggles fullscreen mode if the window height does not match the screen height.
; ---------------------------------------------------------------------------------
changeToFullscreen() {
    WinGetPos &X, &Y, &W, &H, "ahk_exe RobloxPlayerBeta.exe"  ; Get the position and size of the Roblox window.
    if (H != A_ScreenHeight) {
        Send "{F11}"  ; Send the F11 key to toggle fullscreen mode if the heights do not match.
    }
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; MOUSE FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; activateMouseHover Function
; Description: Simulates mouse movement to activate mouse hover events.
; Operation:
;   - Sleeps for a short period to ensure any prior actions are complete.
;   - Moves the mouse slightly to trigger hover events.
;   - Sleeps again to allow hover events to register.
; Dependencies:
;   - Sleep: Function to pause the script for a specified duration.
;   - MouseMove: AHK command to move the mouse cursor.
; Return: None; the function simulates mouse movement to activate hover events.
; ---------------------------------------------------------------------------------
activateMouseHover() {
    Sleep 50  ; Pause for a short period.
    MouseMove 1, 1,, "R"  ; Move the mouse slightly to the right and down.
    Sleep 50  ; Pause for a short period.
    MouseMove -1, -1,, "R"  ; Move the mouse slightly to the left and up.
    Sleep 50  ; Pause for a short period.
}

; ---------------------------------------------------------------------------------
; leftClickMouse Function
; Description: Sends a left-click event to a specified position.
; Operation:
;   - Checks if the provided position is an object.
;   - If it is an object, sends a click event to the specified coordinates in the object.
;   - If it is not an object, treats it as a key to look up in the COORDS map and sends a click event to the corresponding coordinates.
; Dependencies:
;   - COORDS: Map storing coordinates for various controls and buttons.
;   - SendEvent: AHK command to send input events.
;   - IsObject: Function to check if a value is an object.
; Return: None; the function sends a left-click event to the specified position.
; ---------------------------------------------------------------------------------
leftClickMouse(clickPosition) {
    if IsObject(clickPosition)
        SendEvent "{Click, " clickPosition[1] ", " clickPosition[2] ", 1}"
    else
        SendEvent "{Click, " COORDS[clickPosition][1] ", " COORDS[clickPosition][2] ", 1}"
}

; ---------------------------------------------------------------------------------
; leftClickMouseAndWait Function
; Description: Sends a left-click event to a specified position and waits for a specified time.
; Operation:
;   - Checks if the provided position is an object.
;   - If it is an object, sends a click event to the specified coordinates in the object.
;   - If it is not an object, treats it as a key to look up in the COORDS map and sends a click event to the corresponding coordinates.
;   - Waits for the specified time after sending the click event.
; Dependencies:
;   - COORDS: Map storing coordinates for various controls and buttons.
;   - SendEvent: AHK command to send input events.
;   - IsObject: Function to check if a value is an object.
;   - waitTime: Function to pause execution for a specified time.
; Return: None; the function sends a left-click event to the specified position and waits.
; ---------------------------------------------------------------------------------
leftClickMouseAndWait(clickPosition, Time) {
    if IsObject(clickPosition)
        SendEvent "{Click, " clickPosition[1] ", " clickPosition[2] ", 1}"
    else
        SendEvent "{Click, " COORDS[clickPosition][1] ", " COORDS[clickPosition][2] ", 1}"
    waitTime(Time)
}

; ---------------------------------------------------------------------------------
; rightClickMouse Function
; Description: Sends a right-click event to a specified position using coordinates from the COORDS map.
; Operation:
;   - Sends a right-click event to the coordinates specified in the COORDS map.
; Dependencies:
;   - COORDS: Map storing coordinates for various controls and buttons.
;   - SendEvent: AHK command to send input events.
; Return: None; the function sends a right-click event to the specified position.
; ---------------------------------------------------------------------------------
rightClickMouse(Position) {
    SendEvent "{Click, " COORDS[Position][1] ", " COORDS[Position][2] ", 1, Right}"
}

; ---------------------------------------------------------------------------------
; rightClickMouseAndWait Function
; Description: Sends a right-click event to a specified position and waits for a specified time.
; Operation:
;   - Checks if the provided position is an object.
;   - If it is an object, sends a right-click event to the specified coordinates in the object.
;   - If it is not an object, treats it as a key to look up in the COORDS map and sends a right-click event to the corresponding coordinates.
;   - Waits for the specified time after sending the right-click event.
; Dependencies:
;   - COORDS: Map storing coordinates for various controls and buttons.
;   - SendEvent: AHK command to send input events.
;   - IsObject: Function to check if a value is an object.
;   - waitTime: Function to pause execution for a specified time.
; Return: None; the function sends a right-click event to the specified position and waits.
; ---------------------------------------------------------------------------------
rightClickMouseAndWait(clickPosition, time) {
    if IsObject(clickPosition)
        SendEvent "{Click, " clickPosition[1] ", " clickPosition[2] ", 1, Right}"
    else
        SendEvent "{Click, " COORDS[clickPosition][1] ", " COORDS[clickPosition][2] ", 1, Right}"
    waitTime(time)
}

; ---------------------------------------------------------------------------------
; moveMouseToCentreOfScreen Function
; Description: Moves the mouse to the center of the screen and waits for 100 milliseconds.
; Operation:
;   - Moves the mouse cursor to the center of the screen based on the screen width and height.
;   - Pauses the script for 100 milliseconds to allow the movement to complete.
; Dependencies:
;   - MouseMove: AHK command to move the mouse cursor.
;   - A_ScreenWidth, A_ScreenHeight: AHK built-in variables representing the screen width and height.
;   - Sleep: Function to pause the script for a specified duration.
; Return: None; the function moves the mouse to the center of the screen and waits.
; ---------------------------------------------------------------------------------
moveMouseToCentreOfScreen() {
    MouseMove A_ScreenWidth / 2, A_ScreenHeight / 2  ; Move the mouse to the center of the screen.
    Sleep 100  ; Pause for 100 milliseconds.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; SETTINGS FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; getSetting Function
; Description: Reads a value from an INI file based on a given key and handles missing keys by displaying a message.
; Operation:
;   - Attempts to read the value associated with the specified key from the INI file.
;   - If the key is not found, displays a message indicating the missing setting.
; Dependencies:
;   - SETTINGS_INI: Path to the INI file storing settings.
;   - IniRead: AHK command to read a value from an INI file.
;   - MsgBox: AHK command to display a message box.
; Return:
;   - The value associated with the specified key if found.
;   - None if the key is not found.
; ---------------------------------------------------------------------------------
getSetting(Key) {
    try {
        return IniRead(SETTINGS_INI, "Settings", Key)  ; Attempt to read the value from the INI file.
    } catch {
        MsgBox Key " setting not found."  ; Display a message if the key is not found.
    }
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; AUTO HATCH FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; applyAutoHatchSettings Function
; Description: Activates Roblox, updates auto hatch settings based on values from the INI file, and handles the auto hatch menu.
; Operation:
;   - Activates the Roblox window.
;   - Closes the auto hatch menu if it is open.
;   - Clicks to open the auto hatch settings menu.
;   - Updates the auto hatch settings for charged eggs and golden eggs based on the INI file.
;   - Closes the auto hatch menu.
; Dependencies:
;   - activateRoblox: Function to activate the Roblox window.
;   - closeAutoHatchMenu: Function to close the auto hatch menu.
;   - leftClickMouseAndWait: Function to click a specified coordinate and wait.
;   - setCurrentAction: Function to update the current action in the GUI.
;   - getSetting: Function to retrieve specific settings from the INI file.
;   - COORDS: Map storing coordinates for various controls and buttons.
; Return: None; the function updates the auto hatch settings.
; ---------------------------------------------------------------------------------
applyAutoHatchSettings() {
    activateRoblox()  ; Activate the Roblox window.
    closeAutoHatchMenu()  ; Close the auto hatch menu if it is open.
    leftClickMouseAndWait(COORDS["Controls"]["HatchSettings"], 500)  ; Click to open the auto hatch settings menu.
    leftClickMouseAndWait(COORDS["HatchSettings"]["AutoHatchOff"], 200)  ; Ensure auto hatch is turned off.
    setCurrentAction("Updating Auto Hatch Settings")  ; Update the current action.

    ; Update the auto hatch settings for charged eggs.
    if (getSetting("HatchChargedEggs") == "true")
        leftClickMouseAndWait(COORDS["HatchSettings"]["ChargedEggsOff"], 200)
    else
        leftClickMouseAndWait(COORDS["HatchSettings"]["ChargedEggsOn"], 200)

    ; Update the auto hatch settings for golden eggs.
    if (getSetting("HatchGoldenEggs") == "true")
        leftClickMouseAndWait(COORDS["HatchSettings"]["GoldenEggsOff"], 200)
    else
        leftClickMouseAndWait(COORDS["HatchSettings"]["GoldenEggsOn"], 200)

    closeAutoHatchMenu()  ; Close the auto hatch menu.
}

; ---------------------------------------------------------------------------------
; closeAutoHatchMenu Function
; Description: Closes the auto hatch menu by clicking the close button and waits for the action to complete.
; Operation:
;   - Sends a left-click event to the close button coordinates of the auto hatch menu.
;   - Waits for the menu to close.
; Dependencies:
;   - COORDS: Map storing coordinates for various controls and buttons.
;   - leftClickMouseAndWait: Function to click a specified coordinate and wait.
; Return: None; the function closes the auto hatch menu.
; ---------------------------------------------------------------------------------
closeAutoHatchMenu() {
    leftClickMouseAndWait(COORDS["HatchSettings"]["X"], "AutoHatchAfterClosed")  ; Click the close button of the auto hatch menu and wait.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; AUTO FARM FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; clickAutoFarmButton Function
; Description: Toggles the auto farm by clicking the auto farm button and waits for 200 milliseconds.
; Operation:
;   - Sets the current action to "Toggling Auto Farm".
;   - Sends a left-click event to the auto farm button coordinates.
;   - Waits for 200 milliseconds.
;   - Resets the current action.
; Dependencies:
;   - setCurrentAction: Function to update the current action in the GUI.
;   - leftClickMouseAndWait: Function to click a specified coordinate and wait.
;   - COORDS: Map storing coordinates for various controls and buttons.
; Return: None; the function toggles the auto farm.
; ---------------------------------------------------------------------------------
clickAutoFarmButton() {
    setCurrentAction("Toggling Auto Farm")  ; Set the current action.
    leftClickMouseAndWait(COORDS["Controls"]["AutoFarm"], 200)  ; Click the auto farm button and wait.
    setCurrentAction("-")  ; Reset the current action.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; FREE GIFTS FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; areFreeGiftsReady Function
; Description: Uses OCR to determine if free gifts are ready by checking for the word "ready".
; Operation:
;   - Obtains OCR results from a specified area to check if free gifts are ready.
;   - Uses a regular expression to search for the word "ready" in the OCR text result.
; Dependencies:
;   - getOcrResult: Function to obtain OCR results from a specified area.
;   - regexMatch: AHK function to match a regular expression against a string.
;   - COORDS: Map storing coordinates for various controls and buttons.
; Return:
;   - true if the word "ready" is found in the OCR text result.
;   - false otherwise.
; ---------------------------------------------------------------------------------
areFreeGiftsReady() {
    ocrTextResult := getOcrResult(COORDS["OCR"]["FreeRewardsReadyStart"], COORDS["OCR"]["FreeRewardsReadySize"], 20)  ; Obtain OCR results from the specified area.
    return (regexMatch(ocrTextResult, "i)ready"))  ; Check if the word "ready" is found in the OCR text result.
}

; ---------------------------------------------------------------------------------
; claimFreeGifts Function
; Description: Claims free gifts if they are ready by clicking on their locations and waits for each action to complete.
; Operation:
;   - Checks if free gifts are ready using the areFreeGiftsReady function.
;   - If gifts are ready, clicks to open the free gifts menu.
;   - Iterates through the locations of the gifts and clicks on each gift to claim it.
;   - Closes the free gifts menu after claiming the gifts.
; Dependencies:
;   - areFreeGiftsReady: Function to check if free gifts are ready.
;   - leftClickMouseAndWait: Function to click a specified coordinate and wait.
;   - COORDS: Map storing coordinates for various controls and buttons.
; Return: None; the function claims the free gifts and waits for each action to complete.
; ---------------------------------------------------------------------------------
claimFreeGifts() {
    if (areFreeGiftsReady() == true) {  ; Check if free gifts are ready.
        leftClickMouseAndWait(COORDS["Controls"]["FreeGifts"], "FreeGiftsAfterOpened")  ; Click to open the free gifts menu.
        firstGiftLocation := COORDS["FreeRewards"]["Reward1"]  ; Get the location of the first gift.
        giftOffset := COORDS["FreeRewards"]["Offset"]  ; Get the offset between gifts.

        Loop 3 {
            giftToClickY := firstGiftLocation[2] + ((A_Index - 1) * giftOffset[2])  ; Calculate the Y coordinate for the gift.

            Loop 4 {
                giftToClickX := firstGiftLocation[1] + ((A_Index - 1) * giftOffset[1])  ; Calculate the X coordinate for the gift.
                giftToClick := [giftToClickX, giftToClickY]  ; Create the coordinate array for the gift.

                leftClickMouseAndWait(giftToClick, "FreeGiftAfterClicked")  ; Click to claim the gift.
            }
        }

        leftClickMouseAndWait(COORDS["FreeRewards"]["X"], "FreeGiftsAfterClosed")  ; Click to close the free gifts menu.
    }
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; INITIALISATION FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; completeInitialisationTasks Function
; Description: Completes a series of initial tasks including activating Roblox, setting the application icon, initializing and maximizing the Roblox window, changing to fullscreen, and setting hotkeys for pausing and exiting the macro.
; Operation:
;   - Activates the Roblox window.
;   - Sets the application icon.
;   - Initializes and maximizes the Roblox window.
;   - Changes the application to fullscreen mode.
;   - Sets hotkeys for pausing and exiting the macro based on settings from the INI file.
; Dependencies:
;   - activateRoblox: Function to activate the Roblox window.
;   - setApplicationIcon: Function to set the application icon.
;   - initialiseRobloxWindow: Function to initialize and maximize the Roblox window.
;   - changeToFullscreen: Function to change the application to fullscreen mode.
;   - getSetting: Function to retrieve specific settings from the INI file.
;   - Hotkey: AHK command to set hotkeys.
; Return: None; the function completes a series of initialization tasks.
; ---------------------------------------------------------------------------------
completeInitialisationTasks() {
    activateRoblox()  ; Activate the Roblox window.
    setApplicationIcon()  ; Set the application icon.
    initialiseRobloxWindow()  ; Initialize and maximize the Roblox window.
    changeToFullscreen()  ; Change the application to fullscreen mode.
    Hotkey getSetting("pauseMacroKey"), pauseMacro  ; Set the hotkey for pausing the macro.
    Hotkey getSetting("exitMacroKey"), exitMacro  ; Set the hotkey for exiting the macro.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; HOVERBOARD FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; clickHoverboard Function
; Description: Sends a left-click event to either start or stop riding the hoverboard based on a boolean parameter and waits for a specified time.
; Operation:
;   - Checks if the startRiding parameter is true.
;   - If true, clicks to start riding the hoverboard and waits for the specified time.
;   - If false, clicks to stop riding the hoverboard and waits for a shorter time.
; Dependencies:
;   - leftClickMouseAndWait: Function to click a specified coordinate and wait.
;   - COORDS: Map storing coordinates for various controls and buttons.
; Return: None; the function clicks to start or stop riding the hoverboard.
; ---------------------------------------------------------------------------------
clickHoverboard(startRiding := true) {
    if (startRiding == true)
        leftClickMouseAndWait(COORDS["Controls"]["Hoverboard"], "HoverboardAfterEquipped")  ; Click to start riding the hoverboard and wait.
    else
        leftClickMouseAndWait(COORDS["Controls"]["Hoverboard"], 200)  ; Click to stop riding the hoverboard and wait.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; OCR FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; getOcrResult Function
; Description: Performs OCR on a specified area, optionally shows an outline around the OCR area, and returns either the OCR text or the OCR result object.
; Operation:
;   - Calculates the end coordinates of the OCR area based on the start coordinates and size.
;   - If SHOW_OCR_OUTLINE is true, draws a border around the OCR area and waits for a specified time.
;   - Performs OCR on the specified area with the given scale.
;   - If SHOW_OCR_OUTLINE is true, destroys the border after the OCR is completed.
;   - Returns either the OCR text or the OCR result object based on the returnText parameter.
; Dependencies:
;   - Pin: AHK command to draw a border around a specified area.
;   - OCR.FromRect: Function to perform OCR on a specified rectangular area.
;   - waitTime: Function to wait for a specified time.
;   - COORDS: Map storing coordinates for various controls and buttons.
; Return: 
;   - The OCR text if returnText is true.
;   - The OCR result object if returnText is false.
; ---------------------------------------------------------------------------------
getOcrResult(ocrStart, ocrSize, ocrScale, returnText := true) {
    ocrEnd := [ocrStart[1] + ocrSize[1], ocrStart[2] + ocrSize[2]]  ; Calculate the end coordinates of the OCR area.

    if (SHOW_OCR_OUTLINE == "true") {
        ocrBorder := Pin(ocrStart[1], ocrStart[2], ocrEnd[1], ocrEnd[2], 500, "b3 flash0")  ; Draw a border around the OCR area.
        waitTime("QuestAfterOcrBorderDrawn")  ; Wait for a specified time.
    }

    ocrObjectResult := OCR.FromRect(ocrStart[1], ocrStart[2], ocrSize[1], ocrSize[2], , ocrScale)  ; Perform OCR on the specified area.

    if (SHOW_OCR_OUTLINE == "true") {
        ocrBorder.Destroy()  ; Destroy the border after the OCR is completed.
    }

    if (returnText)
        return ocrObjectResult.Text  ; Return the OCR text if returnText is true.
    else
        return ocrObjectResult  ; Return the OCR result object if returnText is false.
}