# ImGui Bindings for Daedalus (Gothic game series)

## Requirements
- Ikarus
- LeGo (used for Event-scripting, optional)


## How it works

Recent versions of the GD3D11 Renderer (v17.9.2+) will call
`GDX_IMGUI_BEGINFRAME` and/or `GDX_IMGUI_ENDFRAME` if they are found.

When called, `func void GDX_IMGUI_BEGINFRAME() {};`, should be used to present windows (blocking, interactive) or overlays (non-blocking, non-interactive).

<details>
<summary>Minimal example <code>_dImGui.d</code> </summary>

```d
const int DIMGUI_INITIALIZED = 0;

/// Initializes the ImGui shim module.
/// Call this once at startup before using any ImGui functions.
/// 
/// @return int 1 if successful, 0 otherwise
func int dImGui_Init() {
    MEM_Info("dImGui --- Init");
    var int ret; ret = dImGui_InitFunctions();

    if (ret) {
        MEM_Info("dImGui --- Successfully initialized dImGui functions.");
        DIMGUI_INITIALIZED = 1;
    };

    return ret;
};

// Put these constants somewhere where you can toggle them in-game
// Like at the end of "AI\AI_INTERN\AI_CONSTANTS.D"
// or in a separate script sourced directly after it.
const int ShouldShowOverlay = 1;
const int IsOverlayOpen = 1;
// ^-----

func void ShowOverlay() {
    // if overlay is deactivated, return early.
    if (!ShouldShowOverlay) { return; };

    dImGui_SetNextWindowPos(0, 50, ImGuiCond_Always, 0.0, 0.0); // always top-left position
    const int overlayFlags = ImGuiWindowFlags_AlwaysAutoResize
        | ImGuiWindowFlags_NoResize
        | ImGuiWindowFlags_NoInputs
        ;
    
    // Some transparency
    dImGui_SetNextWindowBgAlpha(0.3);
    // maybe allow players to toggle the open/close state?
    dImGui_SetNextWindowCollapsed(!IsOverlayOpen, ImGuiCond_Always);

    // Each "dImGui_Begin.." must be in an if-statement
    // and closed always followed by dImGui_End() outside of that if-statement.
    if (dImGui_BeginOverlay("Some Info", 0, overlayFlags)) {
        var oCNpc slf; slf = Hlp_GetNpc(hero);
        // display Hero Name
        dImGui_TextUnformatted(ConcatStrings("Hero Name: ", slf.name));

        if (slf.focus_vob) {
            // hero has focus, try display some of it.
            
            if (Hlp_Is_oCNpc(slf.focus_vob)) {
                var oCNpc oth; oth = _^(slf.focus_vob);
                dImGui_TextUnformatted(ConcatStrings("Focus NPC: ", oth._zCObject_objectName));

            } else if (Hlp_Is_oCItem(slf.focus_vob)) {
                var oCItem itm; itm = _^(slf.focus_vob);
                dImGui_TextUnformatted(ConcatStrings("Focus Item: ", itm._zCObject_objectName));
            };
        }; // slf.focus_vob
    };

    dImGui_End(); // "Some Info" overlay finished
};

/// GD3D11 integration function, called by the engine each frame
func void GDX_IMGUI_BEGINFRAME() {
    if (!DIMGUI_INITIALIZED) { return; };

    ShowOverlay();
};

/// GD3D11 integration function, called by the engine each frame
// func void GDX_IMGUI_ENDFRAME() { /* unused */ };
```

</details>


_See [dImGui_User.d](./CONTENT/dImGui_User.d) for more examples._

## Initialization

Add `dImGui\CONTENT.src` to your `Gothic.src` somewhere after Ikarus and LeGo, like just before the `STORY\Startup.d` to be able to access all functions and instances.

Add the following line(s) to `INIT_GLOBAL`

```d
func void INIT_GLOBAL() {

    MEM_InitAll(); // Initialize Ikarus
    // Use LeGo to allow attaching to events, useful for modular applications
    LeGo_Init(LeGo_EventHandler /* | other flags*/);

    dImGui_Init(); // initialize ImGui Bindings
};

```
