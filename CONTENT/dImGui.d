
const int DIMGUI_INITIALIZED = 0;
var int DIMGUI_EVENT_BEGINFRAME;
var int DIMGUI_EVENT_ENDFRAME;

/// Initializes the ImGui shim module.
/// Call this once at startup before using any ImGui functions.
/// 
/// @return int 1 if successful, 0 otherwise
func int dImGui_Init() {
    MEM_Info("dImGui --- Init");
    var int ret; ret = dImGui_InitFunctions();

    if (ret) {
        MEM_Info("dImGui --- Successfully initialized dImGui functions.");
        if (!Hlp_IsValidHandle(DIMGUI_EVENT_BEGINFRAME)) {
            DIMGUI_EVENT_BEGINFRAME = Event_Create();
        };
        Event_AddOnce(+DIMGUI_EVENT_BEGINFRAME, _dImGui_ImGui_BeginFrame);
        if (!Hlp_IsValidHandle(DIMGUI_EVENT_ENDFRAME)) {
            DIMGUI_EVENT_ENDFRAME = Event_Create();
        };
        Event_AddOnce(+DIMGUI_EVENT_ENDFRAME, _dImGui_ImGui_EndFrame);
        DIMGUI_INITIALIZED = 1;
    };

    return ret;
};

/// GD3D11 integration function, called by the engine each frame
func void GDX_IMGUI_BEGINFRAME() {
    if (!DIMGUI_INITIALIZED) { return; };
    if (!DIMGUI_EVENT_BEGINFRAME) { return; };
    Event_Execute(DIMGUI_EVENT_BEGINFRAME, 0);
};

/// GD3D11 integration function, called by the engine each frame
func void GDX_IMGUI_ENDFRAME() {
    if (!DIMGUI_INITIALIZED) { return; };
    if (!DIMGUI_EVENT_ENDFRAME) { return; };
    Event_Execute(DIMGUI_EVENT_ENDFRAME, 0);
};