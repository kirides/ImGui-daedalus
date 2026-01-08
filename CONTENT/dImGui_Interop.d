// ImGui Shim Module
// Provides Daedalus wrappers for C-style ImGui functions
//
// This module loads the ImGui DLL and provides convenient wrapper functions
// for calling ImGui C-functions with names like "imgui_begin()", "imgui_end()", etc.

// ============================================================================
// Global Constants and Variables
// ============================================================================
const int IMGUI_DLL = 0;
const int IMGUI_DLL_LOADED = 0;

// Cached function pointers for common ImGui operations
const int IMGUI_PROC_Begin                   = 0;
const int IMGUI_PROC_BeginOverlay            = 0;
const int IMGUI_PROC_End                     = 0;
const int IMGUI_PROC_Text                    = 0;
const int IMGUI_PROC_TextUnformatted         = 0;
const int IMGUI_PROC_Button                  = 0;
const int IMGUI_PROC_Checkbox                = 0;
const int IMGUI_PROC_SliderFloat             = 0;
const int IMGUI_PROC_InputText               = 0;
const int IMGUI_PROC_CollapsingHeader        = 0;
const int IMGUI_PROC_Separator               = 0;
const int IMGUI_PROC_SameLine                = 0;
const int IMGUI_PROC_NewLine                 = 0;
const int IMGUI_PROC_BeginChild              = 0;
const int IMGUI_PROC_EndChild                = 0;
const int IMGUI_PROC_BeginMainMenuBar        = 0;
const int IMGUI_PROC_EndMainMenuBar          = 0;
const int IMGUI_PROC_BeginMenu               = 0;
const int IMGUI_PROC_EndMenu                 = 0;
const int IMGUI_PROC_MenuItem                = 0;
const int IMGUI_PROC_PushID                  = 0;
const int IMGUI_PROC_PopID                   = 0;
const int IMGUI_PROC_SetNextWindowPos        = 0;
const int IMGUI_PROC_SetNextWindowSize        = 0;
const int IMGUI_PROC_SetNextWindowBgAlpha        = 0;
const int IMGUI_PROC_SetNextWindowCollapsed        = 0;
const int IMGUI_PROC_GetContentRegionAvailX  = 0;
const int IMGUI_PROC_SetItemTooltip         = 0;

const int IMGUI_PROC_BeginTable              = 0;
const int IMGUI_PROC_EndTable                = 0;
const int IMGUI_PROC_TableNextColumn         = 0;
const int IMGUI_PROC_TableNextRow            = 0;
const int IMGUI_PROC_TableSetColumnIndex     = 0;
const int IMGUI_PROC_TableSetupColumn     = 0;

// ============================================================================
// DLL Loading and Function Discovery
// ============================================================================

/// Loads the ImGui DLL and caches the handle for future use.
/// Only loads once due to caching.
///
/// @return 1 if DLL was loaded successfully, 0 if already loaded
func int dImGui_LoadDLL() {
    if (IMGUI_DLL_LOADED) {
        return 0;  // Already loaded
    };
    
    if (!IMGUI_DLL) {
        // ImGui comes from the GD3D11 renderer which uses ddraw.dll as a proxy
        IMGUI_DLL = LoadLibrary("ddraw.dll");
    };
    
    if (!IMGUI_DLL) {
        return 0;  // Failed to load
    };
    
    IMGUI_DLL_LOADED = 1;
    return 1;
};

/// Finds a C-function exported from the ImGui DLL.
/// Automatically loads the DLL if not already loaded.
///
/// @param name The name of the C-function to find (e.g. "imgui_begin")
/// @return Pointer to the function, or 0 if not found
func int dImGui_FindDllFunction(var string name) {    
    return GetProcAddress(IMGUI_DLL, name);
};

/// Initializes all cached function pointers.
/// Call this once at startup to pre-load all commonly used functions.
///
/// @return 1 if all functions were found, 0 otherwise
func int dImGui_InitFunctions() {
    var int allFound; allFound = 1;

    if (!dImGui_LoadDLL()) {
        if (!IMGUI_DLL) {
            return 0;
        };
    };
    
    IMGUI_PROC_Begin                   = dImGui_FindDllFunction("imgui_begin");
    IMGUI_PROC_BeginOverlay            = dImGui_FindDllFunction("imgui_begin_overlay");
    IMGUI_PROC_End                     = dImGui_FindDllFunction("imgui_end");
    IMGUI_PROC_Text                    = dImGui_FindDllFunction("imgui_text");
    IMGUI_PROC_TextUnformatted         = dImGui_FindDllFunction("imgui_text_unformatted");
    IMGUI_PROC_Button                  = dImGui_FindDllFunction("imgui_button");
    IMGUI_PROC_Checkbox                = dImGui_FindDllFunction("imgui_checkbox");
    IMGUI_PROC_SliderFloat             = dImGui_FindDllFunction("imgui_slider_float");
    IMGUI_PROC_InputText               = dImGui_FindDllFunction("imgui_input_text");
    IMGUI_PROC_CollapsingHeader        = dImGui_FindDllFunction("imgui_collapsing_header");
    IMGUI_PROC_Separator               = dImGui_FindDllFunction("imgui_separator");
    IMGUI_PROC_SameLine                = dImGui_FindDllFunction("imgui_same_line");
    IMGUI_PROC_NewLine                 = dImGui_FindDllFunction("imgui_new_line");
    IMGUI_PROC_BeginChild              = dImGui_FindDllFunction("imgui_begin_child");
    IMGUI_PROC_EndChild                = dImGui_FindDllFunction("imgui_end_child");
    IMGUI_PROC_BeginMainMenuBar        = dImGui_FindDllFunction("imgui_begin_main_menu_bar");
    IMGUI_PROC_EndMainMenuBar          = dImGui_FindDllFunction("imgui_end_main_menu_bar");
    IMGUI_PROC_BeginMenu               = dImGui_FindDllFunction("imgui_begin_menu");
    IMGUI_PROC_EndMenu                 = dImGui_FindDllFunction("imgui_end_menu");
    IMGUI_PROC_MenuItem                = dImGui_FindDllFunction("imgui_menu_item");
    IMGUI_PROC_PushID                  = dImGui_FindDllFunction("imgui_push_id");
    IMGUI_PROC_PopID                   = dImGui_FindDllFunction("imgui_pop_id");
    IMGUI_PROC_SetNextWindowPos        = dImGui_FindDllFunction("imgui_set_next_window_pos");
    IMGUI_PROC_SetNextWindowSize       = dImGui_FindDllFunction("imgui_set_next_window_size");
    IMGUI_PROC_SetNextWindowBgAlpha    = dImGui_FindDllFunction("imgui_set_next_window_bg_alpha");
    IMGUI_PROC_SetNextWindowCollapsed  = dImGui_FindDllFunction("imgui_set_next_window_collapsed");
    IMGUI_PROC_GetContentRegionAvailX  = dImGui_FindDllFunction("imgui_get_content_region_avail_x");
    IMGUI_PROC_SetItemTooltip         = dImGui_FindDllFunction("imgui_set_item_tooltip");

    IMGUI_PROC_BeginTable              = dImGui_FindDllFunction("imgui_begin_table");
    IMGUI_PROC_EndTable                = dImGui_FindDllFunction("imgui_end_table");
    IMGUI_PROC_TableNextColumn         = dImGui_FindDllFunction("imgui_table_next_column");
    IMGUI_PROC_TableNextRow            = dImGui_FindDllFunction("imgui_table_next_row");
    IMGUI_PROC_TableSetColumnIndex     = dImGui_FindDllFunction("imgui_table_set_column_index");
    IMGUI_PROC_TableSetupColumn        = dImGui_FindDllFunction("imgui_table_setup_column");

    // Check if critical functions were found
    if (!IMGUI_PROC_Begin)   { allFound = 0; };
    if (!IMGUI_PROC_End)     { allFound = 0; };
    
    return allFound;
};

// ============================================================================
// Wrapper Functions - Window Management
// ============================================================================

/// Begins an ImGui window.
/// @param title The window title
/// @return 1 if the window is open and visible, 0 otherwise
func int dImGui_Begin(var string title, var int openPtr, var int windowFlags) {
    if (!IMGUI_PROC_Begin) {
        MEM_Info("IMGUI_PROC_Begin not found");
        return 0;
    };
    
    var int call; call = 0;
    var int result; result = 0;
    var int titlePtr; titlePtr = STR_toChar(title);
    
    if (CALL_Begin(call)) {
        CALL_PutRetValTo(_@(result));
        CALL_PtrParam(_@(windowFlags));
        CALL_PtrParam(_@(openPtr));
        CALL_PtrParam(_@(titlePtr));
        CALL__cdecl(IMGUI_PROC_Begin);
        call = CALL_End();
    };
    
    return result;
};

/// Begins an ImGui window, does not block game input.
/// @param title The window title
/// @return 1 if the window is open and visible, 0 otherwise
func int dImGui_BeginOverlay(var string title, var int openPtr, var int windowFlags) {
    if (!IMGUI_PROC_BeginOverlay) {
        MEM_Info("IMGUI_PROC_BeginOverlay not found");
        return 0;
    };
    
    var int call; call = 0;
    var int result; result = 0;
    var int titlePtr; titlePtr = STR_toChar(title);
    
    if (CALL_Begin(call)) {
        CALL_PutRetValTo(_@(result));
        CALL_PtrParam(_@(windowFlags));
        CALL_PtrParam(_@(openPtr));
        CALL_PtrParam(_@(titlePtr));
        CALL__cdecl(IMGUI_PROC_BeginOverlay);
        call = CALL_End();
    };
    
    return result;
};

/// Ends an ImGui window.
func void dImGui_End() {
    if (!IMGUI_PROC_End) {
        return;
    };
    
    var int call; call = 0;
    if (CALL_Begin(call)) {
        CALL__cdecl(IMGUI_PROC_End);
        call = CALL_End();
    };
};

/// Sets the next window position of a Begin call.
/// @param cond [ImGuiCond_Always, ImGuiCond_Once, ImGuiCond_FirstUseEver, ImGuiCond_Appearing ] Condition for applying value
func void dImGui_SetNextWindowPos(var int x, var int y, var int cond, var float pivotX, var float pivotY) {
    if (!IMGUI_PROC_SetNextWindowPos) {
        return;
    };

    var int call; call = 0;
    if (CALL_Begin(call)) {
        CALL_FloatParam(_@f(pivotY));
        CALL_FloatParam(_@f(pivotX));
        CALL_IntParam(_@(cond));
        CALL_IntParam(_@(y));
        CALL_IntParam(_@(x));
        CALL__cdecl(IMGUI_PROC_SetNextWindowPos);
        call = CALL_End();
    };
};

/// Sets the next window size of a Begin call.
/// @param cond [ImGuiCond_Always, ImGuiCond_Once, ImGuiCond_FirstUseEver, ImGuiCond_Appearing ] Condition for applying value
func void dImGui_SetNextWindowSize(var int x, var int y, var int cond) {
    if (!IMGUI_PROC_SetNextWindowSize) {
        return;
    };

    var int call; call = 0;
    if (CALL_Begin(call)) {
        CALL_IntParam(_@(cond));
        CALL_IntParam(_@(y));
        CALL_IntParam(_@(x));
        CALL__cdecl(IMGUI_PROC_SetNextWindowSize);
        call = CALL_End();
    };
};

/// Sets the next window size of a Begin call.
func void dImGui_SetNextWindowBgAlpha(var float value) {
    if (!IMGUI_PROC_SetNextWindowBgAlpha) {
        return;
    };

    var int call; call = 0;
    if (CALL_Begin(call)) {
        CALL_FloatParam(_@f(value));
        CALL__cdecl(IMGUI_PROC_SetNextWindowBgAlpha);
        call = CALL_End();
    };
};

/// Sets the next window size of a Begin call.
/// @param cond [ImGuiCond_Always, ImGuiCond_Once, ImGuiCond_FirstUseEver, ImGuiCond_Appearing ] Condition for applying value
func void dImGui_SetNextWindowCollapsed(var int collapsed, var int cond) {
    if (!IMGUI_PROC_SetNextWindowCollapsed) {
        return;
    };

    var int call; call = 0;
    if (CALL_Begin(call)) {
        CALL_IntParam(_@(cond));
        CALL_IntParam(_@(collapsed));
        CALL__cdecl(IMGUI_PROC_SetNextWindowCollapsed);
        call = CALL_End();
    };
};


// ============================================================================
// Wrapper Functions - Text Display
// ============================================================================

/// Displays unformatted text in ImGui (more efficient for plain text).
/// @param text The text to display
func void dImGui_TextUnformatted(var string text) {
    if (!IMGUI_PROC_TextUnformatted) {
        return;
    };

    var int textPtr; textPtr = STR_toChar(text);

    var int call; call = 0;
    if (CALL_Begin(call)) {
        CALL_PtrParam(_@(textPtr));
        CALL__cdecl(IMGUI_PROC_TextUnformatted);
        call = CALL_End();
    };
};

/// Displays formatted text in ImGui.
/// @param text The text to display
func void dImGui_Text(var string text) {
    dImGui_TextUnformatted(text);

    // in theory we could use the "formatting" version, but its more complex to wrap it.
    // for us it's easier to do the formatting in-script.

    // if (!IMGUI_PROC_Text) {
    //     return;
    // };
    // var int textPtr; textPtr = STR_toChar(text);

    // var int call; call = 0;
    // if (CALL_Begin(call)) {
    //     CALL_PtrParam(_@(textPtr));
    //     CALL__cdecl(IMGUI_PROC_Text);
    //     call = CALL_End();
    // };
};

// ============================================================================
// Wrapper Functions - Button and Interactive Elements
// ============================================================================

/// Displays a button.
/// @param label The button label
/// @param width Optional width (use 0 for auto)
/// @param height Optional height (use 0 for auto)
/// @return 1 if clicked, 0 otherwise
func int dImGui_Button(var string label, var int width, var int height) {
    if (!IMGUI_PROC_Button) {
        MEM_Info("IMGUI_PROC_Button not found");
        return 0;
    };
    
    var int call; call = 0;
    var int result; result = 0;
    var int labelPtr; labelPtr = STR_toChar(label);

    if (CALL_Begin(call)) {
        CALL_PutRetValTo(_@(result));
        CALL_IntParam(_@(height));
        CALL_IntParam(_@(width));
        CALL_PtrParam(_@(labelPtr));
        CALL__cdecl(IMGUI_PROC_Button);
        call = CALL_End();
    };
    
    return result;
};

/// Displays a checkbox.
/// @param label The checkbox label
/// @param ptrValue Pointer to boolean value (modified by ImGui)
/// @return 1 if changed, 0 otherwise
func int dImGui_Checkbox(var string label, var int ptrValue) {
    if (!IMGUI_PROC_Checkbox) {
        MEM_Info("IMGUI_PROC_Checkbox not found");
        return 0;
    };
    
    var int call; call = 0;
    var int result; result = 0;
    var int labelPtr; labelPtr = STR_toChar(label);
    
    if (CALL_Begin(call)) {
        CALL_PutRetValTo(_@(result));
        CALL_PtrParam(_@(ptrValue));
        CALL_PtrParam(_@(labelPtr));
        CALL__cdecl(IMGUI_PROC_Checkbox);
        call = CALL_End();
    };
    
    return result;
};

/// Displays a horizontal slider for float values.
/// @param label The slider label
/// @param ptrValue Pointer to float value (modified by ImGui)
/// @param minValue Minimum value
/// @param maxValue Maximum value
/// @return 1 if changed, 0 otherwise
func int dImGui_SliderFloat(var string label, var int ptrValue, var int minValue, var int maxValue) {
    if (!IMGUI_PROC_SliderFloat) {
        MEM_Info("IMGUI_PROC_SliderFloat not found");
        return 0;
    };
    
    var int call; call = 0;
    var int result; result = 0;
    var int labelPtr; labelPtr = STR_toChar(label);
    
    if (CALL_Begin(call)) {
        CALL_PutRetValTo(_@(result));
        CALL_IntParam(_@(maxValue));
        CALL_IntParam(_@(minValue));
        CALL_PtrParam(_@(ptrValue));
        CALL_PtrParam(_@(labelPtr));
        CALL__cdecl(IMGUI_PROC_SliderFloat);
        call = CALL_End();
    };
    
    return result;
};

/// Displays a text input field.
/// @param label The input label
/// @param ptrBuffer Pointer to buffer containing text
/// @param bufferSize Size of the buffer
/// @return 1 if changed, 0 otherwise
func int dImGui_InputText(var string label, var int ptrBuffer, var int bufferSize) {
    if (!IMGUI_PROC_InputText) {
        MEM_Info("IMGUI_PROC_InputText not found");
        return 0;
    };
    
    var int call; call = 0;
    var int result; result = 0;
    var int labelPtr; labelPtr = STR_toChar(label);
    
    if (CALL_Begin(call)) {
        CALL_PutRetValTo(_@(result));
        CALL_IntParam(_@(bufferSize));
        CALL_PtrParam(_@(ptrBuffer));
        CALL_PtrParam(_@(labelPtr));
        CALL__cdecl(IMGUI_PROC_InputText);
        call = CALL_End();
    };
    
    return result;
};

// ============================================================================
// Wrapper Functions - Layout
// ============================================================================

/// Places next widget on the same line.
/// @param offsetX Optional X offset (use 0 for default)
/// @param spacing Optional spacing (use 0 for default)
func void dImGui_SameLine(var int offsetX, var int spacing) {
    if (!IMGUI_PROC_SameLine) {
        return;
    };
    
    var int call; call = 0;
    if (CALL_Begin(call)) {
        CALL_IntParam(_@(spacing));
        CALL_IntParam(_@(offsetX));
        CALL__cdecl(IMGUI_PROC_SameLine);
        call = CALL_End();
    };
};

/// Moves to the next line.
func void dImGui_NewLine() {
    if (!IMGUI_PROC_NewLine) {
        return;
    };
    
    var int call; call = 0;
    if (CALL_Begin(call)) {
        CALL__cdecl(IMGUI_PROC_NewLine);
        call = CALL_End();
    };
};

/// Draws a separator line.
func void dImGui_Separator() {
    if (!IMGUI_PROC_Separator) {
        return;
    };
    
    var int call; call = 0;
    if (CALL_Begin(call)) {
        CALL__cdecl(IMGUI_PROC_Separator);
        call = CALL_End();
    };
};

/// Begins a child region.
/// @param title Child region ID/title
/// @param width Width (0 for full width)
/// @param height Height (0 for full height)
/// @param border 1 to draw border, 0 otherwise
/// @return 1 if visible, 0 otherwise
func int dImGui_BeginChild(var string title, var int width, var int height, var int border) {
    if (!IMGUI_PROC_BeginChild) {
        MEM_Info("IMGUI_PROC_BeginChild not found");
        return 0;
    };
    
    var int call; call = 0;
    var int result; result = 0;
    var int titlePtr; titlePtr = STR_toChar(title);
    
    if (CALL_Begin(call)) {
        CALL_PutRetValTo(_@(result));
        CALL_IntParam(_@(border));
        CALL_IntParam(_@(height));
        CALL_IntParam(_@(width));
        CALL_PtrParam(_@(titlePtr));
        CALL__cdecl(IMGUI_PROC_BeginChild);
        call = CALL_End();
    };
    
    return result;
};

/// Ends a child region.
func void dImGui_EndChild() {
    if (!IMGUI_PROC_EndChild) {
        return;
    };
    
    var int call; call = 0;
    if (CALL_Begin(call)) {
        CALL__cdecl(IMGUI_PROC_EndChild);
        call = CALL_End();
    };
};

// ============================================================================
// Wrapper Functions - Collapsing Header
// ============================================================================

/// Displays a collapsing header.
/// @param label The header label
/// @return 1 if expanded, 0 if collapsed
func int dImGui_CollapsingHeader(var string label) {
    if (!IMGUI_PROC_CollapsingHeader) {
        MEM_Info("IMGUI_PROC_CollapsingHeader not found");
        return 0;
    };
    
    var int call; call = 0;
    var int result; result = 0;
    var int labelPtr; labelPtr = STR_toChar(label);
    
    if (CALL_Begin(call)) {
        CALL_PutRetValTo(_@(result));
        CALL_PtrParam(_@(labelPtr));
        CALL__cdecl(IMGUI_PROC_CollapsingHeader);
        call = CALL_End();
    };
    
    return result;
};

// ============================================================================
// Wrapper Functions - Menu Bar
// ============================================================================

/// Begins the main menu bar.
/// @return 1 if visible, 0 otherwise
func int dImGui_BeginMainMenuBar() {
    if (!IMGUI_PROC_BeginMainMenuBar) {
        MEM_Info("IMGUI_PROC_BeginMainMenuBar not found");
        return 0;
    };
    
    var int call; call = 0;
    var int result; result = 0;
    
    if (CALL_Begin(call)) {
        CALL_PutRetValTo(_@(result));
        CALL__cdecl(IMGUI_PROC_BeginMainMenuBar);
        call = CALL_End();
    };
    
    return result;
};

/// Ends the main menu bar.
func void dImGui_EndMainMenuBar() {
    if (!IMGUI_PROC_EndMainMenuBar) {
        return;
    };
    
    var int call; call = 0;
    if (CALL_Begin(call)) {
        CALL__cdecl(IMGUI_PROC_EndMainMenuBar);
        call = CALL_End();
    };
};

/// Begins a menu.
/// @param label Menu label
/// @param enabled 1 if enabled, 0 otherwise
/// @return 1 if opened, 0 otherwise
func int dImGui_BeginMenu(var string label, var int enabled) {
    if (!IMGUI_PROC_BeginMenu) {
        MEM_Info("IMGUI_PROC_BeginMenu not found");
        return 0;
    };
    
    var int call; call = 0;
    var int result; result = 0;
    var int labelPtr; labelPtr = STR_toChar(label);
    
    if (CALL_Begin(call)) {
        CALL_PutRetValTo(_@(result));
        CALL_IntParam(_@(enabled));
        CALL_PtrParam(_@(labelPtr));
        CALL__cdecl(IMGUI_PROC_BeginMenu);
        call = CALL_End();
    };
    
    return result;
};

/// Ends a menu.
func void dImGui_EndMenu() {
    if (!IMGUI_PROC_EndMenu) {
        return;
    };
    
    var int call; call = 0;
    if (CALL_Begin(call)) {
        CALL__cdecl(IMGUI_PROC_EndMenu);
        call = CALL_End();
    };
};

/// Displays a menu item.
/// @param label Item label
/// @param shortcut Optional keyboard shortcut description
/// @param selected 1 if currently selected, 0 otherwise
/// @param enabled 1 if enabled, 0 otherwise
/// @return 1 if clicked, 0 otherwise
func int dImGui_MenuItem(var string label, var string shortcut, var int selected, var int enabled) {
    if (!IMGUI_PROC_MenuItem) {
        MEM_Info("IMGUI_PROC_MenuItem not found");
        return 0;
    };
    
    var int call; call = 0;
    var int result; result = 0;
    var int labelPtr; labelPtr = STR_toChar(label);
    var int shortcutPtr; shortcutPtr = STR_toChar(shortcut);
    
    if (CALL_Begin(call)) {
        CALL_PutRetValTo(_@(result));
        CALL_IntParam(_@(enabled));
        CALL_IntParam(_@(selected));
        CALL_PtrParam(_@(shortcutPtr));
        CALL_PtrParam(_@(labelPtr));
        CALL__cdecl(IMGUI_PROC_MenuItem);
        call = CALL_End();
    };
    
    return result;
};

// ============================================================================
// Wrapper Functions - ID Stack
// ============================================================================

/// Pushes a new ID onto the ID stack.
/// @param id ID value (typically an integer)
func void dImGui_PushID(var int id) {
    if (!IMGUI_PROC_PushID) {
        return;
    };
    
    var int call; call = 0;
    if (CALL_Begin(call)) {
        CALL_IntParam(_@(id));
        CALL__cdecl(IMGUI_PROC_PushID);
        call = CALL_End();
    };
};

/// Pops from the ID stack.
func void dImGui_PopID() {
    if (!IMGUI_PROC_PopID) {
        return;
    };
    
    var int call; call = 0;
    if (CALL_Begin(call)) {
        CALL__cdecl(IMGUI_PROC_PopID);
        call = CALL_End();
    };
};

// ============================================================================
// Wrapper Functions - Content Region
// ============================================================================

/// Gets the available width in the current content region.
/// @return Available width in pixels
func int dImGui_GetContentRegionAvailX() {
    if (!IMGUI_PROC_GetContentRegionAvailX) {
        MEM_Info("IMGUI_PROC_GetContentRegionAvailX not found");
        return 0;
    };
    
    var int call; call = 0;
    var int result; result = 0;
    
    if (CALL_Begin(call)) {
        CALL_PutRetValTo(_@(result));
        CALL__cdecl(IMGUI_PROC_GetContentRegionAvailX);
        call = CALL_End();
    };
    
    return result;
};

/// Sets a tooltip for the previous item.
/// Call this after an interactive element (button, checkbox, etc.)
/// @param text Tooltip text to display
func void dImGui_SetItemTooltip(var string text) {
    if (!IMGUI_PROC_SetItemTooltip) {
        return;
    };
    
    var int call; call = 0;
    var int textPtr; textPtr = STR_toChar(text);
    
    if (CALL_Begin(call)) {
        CALL_PtrParam(_@(textPtr));
        CALL__cdecl(IMGUI_PROC_SetItemTooltip);
        call = CALL_End();
    };
};

/// Begins a table with specified columns.
/// @param count Number of columns
/// @param id Optional table identifier
/// @param tableFlags [ ImGuiTableFlags_Resizable, ImGuiTableFlags_Reorderable, ImGuiTableFlags_Hideable, ImGuiTableFlags_Sortable, ImGuiTableFlags_NoSavedSettings, ImGuiTableFlags_ContextMenuInBody, ImGuiTableFlags_RowBg, ImGuiTableFlags_BordersInnerH, ImGuiTableFlags_BordersOuterH, ImGuiTableFlags_BordersInnerV, ImGuiTableFlags_BordersOuterV, ImGuiTableFlags_BordersH, ImGuiTableFlags_BordersV, ImGuiTableFlags_BordersInner, ImGuiTableFlags_BordersOuter, ImGuiTableFlags_Borders, ImGuiTableFlags_NoBordersInBody, ImGuiTableFlags_NoBordersInBodyUntilResize, ImGuiTableFlags_SizingFixedFit, ImGuiTableFlags_SizingFixedSame, ImGuiTableFlags_SizingStretchProp, ImGuiTableFlags_SizingStretchSame, ImGuiTableFlags_NoHostExtendX, ImGuiTableFlags_NoHostExtendY, ImGuiTableFlags_NoKeepColumnsVisible, ImGuiTableFlags_PreciseWidths, ImGuiTableFlags_NoClip, ImGuiTableFlags_PadOuterX, ImGuiTableFlags_NoPadOuterX, ImGuiTableFlags_NoPadInnerX, ImGuiTableFlags_ScrollX, ImGuiTableFlags_ScrollY, ImGuiTableFlags_SortMulti, ImGuiTableFlags_SortTristate, ImGuiTableFlags_HighlightHoveredColumn ] Values combined with bitwise OR
/// @param outerX Outer size X (0 = auto)
/// @param outerY Outer size Y (0 = auto)
/// @param innerWidth Inner width (0 = auto)
/// @return 1 if successful, 0 otherwise
func int dImGui_BeginTable(var int count, var string id, var int tableFlags, var int outerX, var int outerY, var int innerWidth) {
    if (!IMGUI_PROC_BeginTable) {
        MEM_Info("IMGUI_PROC_BeginTable not found");
        return 0;
    };
    
    var int call; call = 0;
    var int result; result = 0;
    var int idPtr; idPtr = STR_toChar(id);
    
    if (CALL_Begin(call)) {
        CALL_PutRetValTo(_@(result));
        CALL_IntParam(_@(innerWidth));
        CALL_IntParam(_@(outerY));
        CALL_IntParam(_@(outerX));
        CALL_IntParam(_@(tableFlags));
        CALL_PtrParam(_@(idPtr));
        CALL_IntParam(_@(count));
        CALL__cdecl(IMGUI_PROC_BeginTable);
        call = CALL_End();
    };
    
    return result;
};

/// Ends the current table.
func void dImGui_EndTable() {
    if (!IMGUI_PROC_EndTable) {
        return;
    };
    
    var int call; call = 0;
    if (CALL_Begin(call)) {
        CALL__cdecl(IMGUI_PROC_EndTable);
        call = CALL_End();
    };
};

/// Moves to the next column in the current table row.
/// @return 1 if successful, 0 if table ended
func int dImGui_TableNextColumn() {
    if (!IMGUI_PROC_TableNextColumn) {
        MEM_Info("IMGUI_PROC_TableNextColumn not found");
        return 0;
    };
    
    var int call; call = 0;
    var int result; result = 0;
    
    if (CALL_Begin(call)) {
        CALL_PutRetValTo(_@(result));
        CALL__cdecl(IMGUI_PROC_TableNextColumn);
        call = CALL_End();
    };
    
    return result;
};

/// Appends a new row to the table.
/// @param rowFlags [ ImGuiTableRowFlags_Headers ] Values combined with bitwise OR
/// @param minRowHeight Minimum row height (0 = auto)
func void dImGui_TableNextRow(var int rowFlags, var int minRowHeight) {
    if (!IMGUI_PROC_TableNextRow) {
        return;
    };
    
    var int call; call = 0;
    if (CALL_Begin(call)) {
        CALL_IntParam(_@(minRowHeight));
        CALL_IntParam(_@(rowFlags));
        CALL__cdecl(IMGUI_PROC_TableNextRow);
        call = CALL_End();
    };
};

/// Appends to the specified table column, next row will use the next column.
/// @param index Column index
func void dImGui_TableSetColumnIndex(var int index) {
    if (!IMGUI_PROC_TableSetColumnIndex) {
        return;
    };
    
    var int call; call = 0;
    if (CALL_Begin(call)) {
        CALL_IntParam(_@(index));
        CALL__cdecl(IMGUI_PROC_TableSetColumnIndex);
        call = CALL_End();
    };
};

/// Sets up a column for the table.
/// Must be called after BeginTable and before the first row.
/// @param label Column header label
/// @param flags [ ImGuiTableColumnFlags_DefaultHide, ImGuiTableColumnFlags_DefaultSort, ImGuiTableColumnFlags_WidthStretch, ImGuiTableColumnFlags_WidthFixed, ImGuiTableColumnFlags_NoResize, ImGuiTableColumnFlags_NoReorder, ImGuiTableColumnFlags_NoHide, ImGuiTableColumnFlags_NoClip, ImGuiTableColumnFlags_NoSort, ImGuiTableColumnFlags_NoSortAscending, ImGuiTableColumnFlags_NoSortDescending, ImGuiTableColumnFlags_NoHeaderLabel, ImGuiTableColumnFlags_NoHeaderWidth, ImGuiTableColumnFlags_PreferSortAscending, ImGuiTableColumnFlags_PreferSortDescending, ImGuiTableColumnFlags_IndentEnable, ImGuiTableColumnFlags_IndentDisable, ImGuiTableColumnFlags_AngledHeader ] Values combined with bitwise OR
/// @param initWidthOrWeight Initial width or weight depending on table sizing flags (0 = auto)
/// @param userId Optional user ID for identifying columns
func void dImGui_TableSetupColumn(var string label, var int flags, var int initWidthOrWeight, var int userId) {
    if (!IMGUI_PROC_TableSetupColumn) {
        return;
    };
    
    var int call; call = 0;
    var int labelPtr; labelPtr = STR_toChar(label);
    
    if (CALL_Begin(call)) {
        CALL_IntParam(_@(userId));
        CALL_IntParam(_@(initWidthOrWeight));
        CALL_IntParam(_@(flags));
        CALL_PtrParam(_@(labelPtr));
        CALL__cdecl(IMGUI_PROC_TableSetupColumn);
        call = CALL_End();
    };
};
