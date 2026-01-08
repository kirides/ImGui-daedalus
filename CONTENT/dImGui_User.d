const int _clicked = 0;
const int _dlgVisible = 0;
const int _a_bool_flag = 1;
const int _overlay_visible = 1;

func void _TableColumnsStrInt(var string label, var int value) {
    dImGui_TextUnformatted(label); dImGui_TableNextColumn();
    dImGui_TextUnformatted(IntToString(value)); dImGui_TableNextColumn();

};

func void _TableColumnsStrStr(var string label, var string value) {

    dImGui_TextUnformatted(label); dImGui_TableNextColumn();
    dImGui_TextUnformatted(value); dImGui_TableNextColumn();
};

func void _ImGuiXYZ(var int x, var int y, var int z) {
    dImGui_TextUnformatted("x: ");
    dImGui_SameLine(0, 0);
    dImGui_TextUnformatted(IntToString(x));

    dImGui_SameLine(0, 0);
    dImGui_TextUnformatted("y: ");
    dImGui_SameLine(0, 0);
    dImGui_TextUnformatted(IntToString(z));

    dImGui_SameLine(0, 0);
    dImGui_TextUnformatted("z: ");
    dImGui_SameLine(0, 0);
    dImGui_TextUnformatted(IntToString(z));
};

func void _DemoDialog() {
    if (!_dlgVisible) {
        return;
    };

    dImGui_SetNextWindowPos(2048, 2048, ImGuiCond_Appearing, 0.5, 0.5);
    dImGui_SetNextWindowSize(1024, 1024, ImGuiCond_Appearing);
    if (dImGui_Begin("Daedalus ImGui Frame", _@(_dlgVisible), ImGuiWindowFlags_NoCollapse)) {
        dImGui_TextUnformatted("Hello from dImGui!");
        if (dImGui_Button("Click Me", 250, 75)) {
            _clicked = 1;
            Print("Click me button pressed");
        };
        dImGui_SetItemTooltip("This is a tooltip for the 'Click Me' button.");
        if (_clicked) {
            dImGui_TextUnformatted("Button was clicked!");
        };
        if (dImGui_Checkbox("##someBoolFlag", _@(_a_bool_flag))) {
            Print("Bool flag changed");
        };

        var int someTextPtr;
        if (someTextPtr == 0) {
            someTextPtr = MEM_Alloc(255);
            // TODO: use a "global" string buffer and free it when leaving
        }; 

        if (dImGui_InputText("Enter some text", someTextPtr, 254) ){
            Print("text input changed");
        };

        if (dImGui_Button("Print some text", dImGui_GetContentRegionAvailX(), 75)) {
            var string str; str = STR_FromChar(someTextPtr);
            Print(str);
        };

        if (dImGui_Button("Close", 250, 75)) {
            Print("Close was pressed");
            _dlgVisible = 0;
        };
    };
    dImGui_End();
};

func void _DisplayDebugOverlay() {
    dImGui_SetNextWindowPos(0, 50, ImGuiCond_Always, 0.0, 0.0); // always top-left position
    const int overlayFlags = ImGuiWindowFlags_AlwaysAutoResize
        | ImGuiWindowFlags_NoResize
        | ImGuiWindowFlags_NoInputs
        ;
    dImGui_SetNextWindowBgAlpha(0.3);
    dImGui_SetNextWindowCollapsed(!_overlay_visible, ImGuiCond_Always);
    if(dImGui_BeginOverlay("Debug Info", 0, overlayFlags)) {
        var oCNpc slf; slf = Hlp_GetNpc(hero);
        dImGui_BeginTable(2, "status_columns", 0, 0 ,0 , 0);

        dImGui_TableNextRow(0, 0);
        dImGui_TableSetColumnIndex(0);
        dImGui_TextUnformatted("=== Hero Info ===");
        dImGui_TableNextRow(0, 0);
        dImGui_TableSetColumnIndex(0);

        var int x; x = truncf(slf._zCVob_trafoObjToWorld[zCVob_trafoObjToWorld_X]);
        var int y; y = truncf(slf._zCVob_trafoObjToWorld[zCVob_trafoObjToWorld_Y]);
        var int z; z = truncf(slf._zCVob_trafoObjToWorld[zCVob_trafoObjToWorld_Z]);
        dImGui_TextUnformatted("Position"); dImGui_TableNextColumn();
        _ImGuiXYZ(x, y, z);

        if (slf.focus_vob) {
            dImGui_TableNextRow(0, 0);
            dImGui_TableSetColumnIndex(0);
            dImGui_TextUnformatted("=== Focus ===");
            dImGui_TableNextRow(ImGuiTableRowFlags_Headers, 0);
            dImGui_TableSetColumnIndex(0);

            if (Hlp_Is_oCNpc(slf.focus_vob)) {
                var oCNpc oth; oth = _^(slf.focus_vob);
                _TableColumnsStrStr("objectName", oth._zCObject_objectName);
                _TableColumnsStrInt("instanz", oth.instanz);
            } else if (Hlp_Is_oCItem(slf.focus_vob)) {
                var oCItem itm; itm = _^(slf.focus_vob);
                _TableColumnsStrStr("objectName", itm._zCObject_objectName);
                _TableColumnsStrInt("instanz", itm.instanz);
                _TableColumnsStrInt("Amount", itm.amount);
            } else if (Hlp_Is_oCMob(slf.focus_vob)) {
                var ocMob mob; mob = _^(slf.focus_vob);
                _TableColumnsStrStr("Name", mob.name);
            };

            var zCVob v; v = _^(slf.focus_vob);            
            x = truncf(v.trafoObjToWorld[zCVob_trafoObjToWorld_X]);
            y = truncf(v.trafoObjToWorld[zCVob_trafoObjToWorld_Y]);
            z = truncf(v.trafoObjToWorld[zCVob_trafoObjToWorld_Z]);
            dImGui_TextUnformatted("Position"); dImGui_TableNextColumn();
            _ImGuiXYZ(x, y, z); dImGui_TableNextColumn();
        }; // slf.focus_vob
        dImGui_EndTable();
    };

    dImGui_End(); // Overlay
};

func void _dImGui_ImGui_BeginFrame(var int data) {
    _DemoDialog();
    _DisplayDebugOverlay();
};

func void _dImGui_ImGui_EndFrame(var int data) {
    // Called when the frame ends
};
