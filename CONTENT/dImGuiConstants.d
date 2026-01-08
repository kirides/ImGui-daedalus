// ============================================================================
// Global Constants and Variables
// ============================================================================

/// Disable title-bar
const int ImGuiWindowFlags_NoTitleBar             = 1 << 0;
/// Disable user resizing with the lower-right grip
const int ImGuiWindowFlags_NoResize               = 1 << 1;
/// Disable user moving the window
const int ImGuiWindowFlags_NoMove                 = 1 << 2;
/// Disable scrollbars (window can still scroll with mouse or programmatically)
const int ImGuiWindowFlags_NoScrollbar            = 1 << 3;
/// Disable user vertically scrolling with mouse wheel. On child window, mouse wheel will be forwarded to the parent unless NoScrollbar is also set.
const int ImGuiWindowFlags_NoScrollWithMouse      = 1 << 4;
/// Disable user collapsing window by double-clicking on it. Also referred to as Window Menu Button (e.g. within a docking node).
const int ImGuiWindowFlags_NoCollapse             = 1 << 5;
/// Resize every window to its content every frame
const int ImGuiWindowFlags_AlwaysAutoResize       = 1 << 6;
/// Disable drawing background color (WindowBg, etc.) and outside border. Similar as using SetNextWindowBgAlpha(0.0f).
const int ImGuiWindowFlags_NoBackground           = 1 << 7;
/// Never load/save settings in .ini file
const int ImGuiWindowFlags_NoSavedSettings        = 1 << 8;
/// Disable catching mouse, hovering test with pass through.
const int ImGuiWindowFlags_NoMouseInputs          = 1 << 9;
/// Has a menu-bar
const int ImGuiWindowFlags_MenuBar                = 1 << 10;
/// Allow horizontal scrollbar to appear (off by default). You may use SetNextWindowContentSize(ImVec2(width,0.0f)); prior to calling Begin() to specify width. Read code in imgui_demo in the "Horizontal Scrolling" section.
const int ImGuiWindowFlags_HorizontalScrollbar    = 1 << 11;
/// Disable taking focus when transitioning from hidden to visible state
const int ImGuiWindowFlags_NoFocusOnAppearing     = 1 << 12;
/// Disable bringing window to front when taking focus (e.g. clicking on it or programmatically giving it focus)
const int ImGuiWindowFlags_NoBringToFrontOnFocus  = 1 << 13;
/// Always show vertical scrollbar (even if ContentSize.y < Size.y)
const int ImGuiWindowFlags_AlwaysVerticalScrollbar= 1 << 14;
/// Always show horizontal scrollbar (even if ContentSize.x < Size.x)
const int ImGuiWindowFlags_AlwaysHorizontalScrollbar=1<< 15;
/// No keyboard/gamepad navigation within the window
const int ImGuiWindowFlags_NoNavInputs            = 1 << 16;
/// No focusing toward this window with keyboard/gamepad navigation (e.g. skipped by Ctrl+Tab)
const int ImGuiWindowFlags_NoNavFocus             = 1 << 17;
/// Display a dot next to the title. When used in a tab/docking context, tab is selected when clicking the X + closure is not assumed (will wait for user to stop submitting the tab). Otherwise closure is assumed when pressing the X, so if you keep submitting the tab may reappear at end of tab bar.
const int ImGuiWindowFlags_UnsavedDocument        = 1 << 18;

const int ImGuiWindowFlags_NoNav                  = ImGuiWindowFlags_NoNavInputs | ImGuiWindowFlags_NoNavFocus;
const int ImGuiWindowFlags_NoDecoration           = ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoScrollbar | ImGuiWindowFlags_NoCollapse;
const int ImGuiWindowFlags_NoInputs               = ImGuiWindowFlags_NoMouseInputs | ImGuiWindowFlags_NoNavInputs | ImGuiWindowFlags_NoNavFocus;



// Features
/// Enable resizing columns.
const int ImGuiTableFlags_Resizable                  = 1 << 0;
/// Enable reordering columns in header row (need calling TableSetupColumn() + TableHeadersRow() to display headers)
const int ImGuiTableFlags_Reorderable                = 1 << 1;
/// Enable hiding/disabling columns in context menu.
const int ImGuiTableFlags_Hideable                   = 1 << 2;
/// Enable sorting. Call TableGetSortSpecs() to obtain sort specs. Also see ImGuiTableFlags_SortMulti and ImGuiTableFlags_SortTristate.
const int ImGuiTableFlags_Sortable                   = 1 << 3;
/// Disable persisting columns order, width and sort settings in the .ini file.
const int ImGuiTableFlags_NoSavedSettings            = 1 << 4;
/// Right-click on columns body/contents will display table context menu. By default it is available in TableHeadersRow().
const int ImGuiTableFlags_ContextMenuInBody          = 1 << 5;
// Decorations
/// Set each RowBg color with ImGuiCol_TableRowBg or ImGuiCol_TableRowBgAlt (equivalent of calling TableSetBgColor with ImGuiTableBgFlags_RowBg0 on each row manually)
const int ImGuiTableFlags_RowBg                      = 1 << 6;
/// Draw horizontal borders between rows.
const int ImGuiTableFlags_BordersInnerH              = 1 << 7;
/// Draw horizontal borders at the top and bottom.
const int ImGuiTableFlags_BordersOuterH              = 1 << 8;
/// Draw vertical borders between columns.
const int ImGuiTableFlags_BordersInnerV              = 1 << 9;
/// Draw vertical borders on the left and right sides.
const int ImGuiTableFlags_BordersOuterV              = 1 << 10;
/// Draw horizontal borders.
const int ImGuiTableFlags_BordersH                   = ImGuiTableFlags_BordersInnerH | ImGuiTableFlags_BordersOuterH;
/// Draw vertical borders.
const int ImGuiTableFlags_BordersV                   = ImGuiTableFlags_BordersInnerV | ImGuiTableFlags_BordersOuterV;
/// Draw inner borders.
const int ImGuiTableFlags_BordersInner               = ImGuiTableFlags_BordersInnerV | ImGuiTableFlags_BordersInnerH;
/// Draw outer borders.
const int ImGuiTableFlags_BordersOuter               = ImGuiTableFlags_BordersOuterV | ImGuiTableFlags_BordersOuterH;
/// Draw all borders.
const int ImGuiTableFlags_Borders                    = ImGuiTableFlags_BordersInner | ImGuiTableFlags_BordersOuter;
/// [ALPHA] Disable vertical borders in columns Body (borders will always appear in Headers). -> May move to style
const int ImGuiTableFlags_NoBordersInBody            = 1 << 11;
/// [ALPHA] Disable vertical borders in columns Body until hovered for resize (borders will always appear in Headers). -> May move to style
const int ImGuiTableFlags_NoBordersInBodyUntilResize = 1 << 12;
// Sizing Policy (read above for defaults)
/// Columns default to _WidthFixed or _WidthAuto (if resizable or not resizable), matching contents width.
const int ImGuiTableFlags_SizingFixedFit             = 1 << 13;
/// Columns default to _WidthFixed or _WidthAuto (if resizable or not resizable), matching the maximum contents width of all columns. Implicitly enable ImGuiTableFlags_NoKeepColumnsVisible.
const int ImGuiTableFlags_SizingFixedSame            = 2 << 13;
/// Columns default to _WidthStretch with default weights proportional to each columns contents widths.
const int ImGuiTableFlags_SizingStretchProp          = 3 << 13;
/// Columns default to _WidthStretch with default weights all equal, unless overridden by TableSetupColumn().
const int ImGuiTableFlags_SizingStretchSame          = 4 << 13;
// Sizing Extra Options
/// Make outer width auto-fit to columns, overriding outer_size.x value. Only available when ScrollX/ScrollY are disabled and Stretch columns are not used.
const int ImGuiTableFlags_NoHostExtendX              = 1 << 16;
/// Make outer height stop exactly at outer_size.y (prevent auto-extending table past the limit). Only available when ScrollX/ScrollY are disabled. Data below the limit will be clipped and not visible.
const int ImGuiTableFlags_NoHostExtendY              = 1 << 17;
/// Disable keeping column always minimally visible when ScrollX is off and table gets too small. Not recommended if columns are resizable.
const int ImGuiTableFlags_NoKeepColumnsVisible       = 1 << 18;
/// Disable distributing remainder width to stretched columns (width allocation on a 100-wide table with 3 columns: Without this flag: 33,33,34. With this flag: 33,33,33). With larger number of columns, resizing will appear to be less smooth.
const int ImGuiTableFlags_PreciseWidths              = 1 << 19;
// Clipping
/// Disable clipping rectangle for every individual columns (reduce draw command count, items will be able to overflow into other columns). Generally incompatible with TableSetupScrollFreeze().
const int ImGuiTableFlags_NoClip                     = 1 << 20;
// Padding
/// Default if BordersOuterV is on. Enable outermost padding. Generally desirable if you have headers.
const int ImGuiTableFlags_PadOuterX                  = 1 << 21;
/// Default if BordersOuterV is off. Disable outermost padding.
const int ImGuiTableFlags_NoPadOuterX                = 1 << 22;
/// Disable inner padding between columns (double inner padding if BordersOuterV is on, single inner padding if BordersOuterV is off).
const int ImGuiTableFlags_NoPadInnerX                = 1 << 23;
// Scrolling
/// Enable horizontal scrolling. Require 'outer_size' parameter of BeginTable() to specify the container size. Changes default sizing policy. Because this creates a child window, ScrollY is currently generally recommended when using ScrollX.
const int ImGuiTableFlags_ScrollX                    = 1 << 24;
/// Enable vertical scrolling. Require 'outer_size' parameter of BeginTable() to specify the container size.
const int ImGuiTableFlags_ScrollY                    = 1 << 25;
// Sorting
/// Hold shift when clicking headers to sort on multiple column. TableGetSortSpecs() may return specs where (SpecsCount > 1).
const int ImGuiTableFlags_SortMulti                  = 1 << 26;
/// Allow no sorting, disable default sorting. TableGetSortSpecs() may return specs where (SpecsCount == 0).
const int ImGuiTableFlags_SortTristate               = 1 << 27;
// Miscellaneous
/// Highlight column headers when hovered (may evolve into a fuller highlight)
const int ImGuiTableFlags_HighlightHoveredColumn     = 1 << 28;

// Table column flags

/// Overriding/master disable flag: hide column, won't show in context menu (unlike calling TableSetColumnEnabled() which manipulates the user accessible state)
const int ImGuiTableColumnFlags_Disabled              = 1 << 0;
/// Default as a hidden/disabled column.
const int ImGuiTableColumnFlags_DefaultHide           = 1 << 1;
/// Default as a sorting column.
const int ImGuiTableColumnFlags_DefaultSort           = 1 << 2;
/// Column will stretch. Preferable with horizontal scrolling disabled (default if table sizing policy is _SizingStretchSame or _SizingStretchProp).
const int ImGuiTableColumnFlags_WidthStretch          = 1 << 3;
/// Column will not stretch. Preferable with horizontal scrolling enabled (default if table sizing policy is _SizingFixedFit and table is resizable).
const int ImGuiTableColumnFlags_WidthFixed            = 1 << 4;
/// Disable manual resizing.
const int ImGuiTableColumnFlags_NoResize              = 1 << 5;
/// Disable manual reordering this column, this will also prevent other columns from crossing over this column.
const int ImGuiTableColumnFlags_NoReorder             = 1 << 6;
/// Disable ability to hide/disable this column.
const int ImGuiTableColumnFlags_NoHide                = 1 << 7;
/// Disable clipping for this column (all NoClip columns will render in a same draw command).
const int ImGuiTableColumnFlags_NoClip                = 1 << 8;
/// Disable ability to sort on this field (even if ImGuiTableFlags_Sortable is set on the table).
const int ImGuiTableColumnFlags_NoSort                = 1 << 9;
/// Disable ability to sort in the ascending direction.
const int ImGuiTableColumnFlags_NoSortAscending       = 1 << 10;
/// Disable ability to sort in the descending direction.
const int ImGuiTableColumnFlags_NoSortDescending      = 1 << 11;
/// TableHeadersRow() will submit an empty label for this column. Convenient for some small columns. Name will still appear in context menu or in angled headers. You may append into this cell by calling TableSetColumnIndex() right after the TableHeadersRow() call.
const int ImGuiTableColumnFlags_NoHeaderLabel         = 1 << 12;
/// Disable header text width contribution to automatic column width.
const int ImGuiTableColumnFlags_NoHeaderWidth         = 1 << 13;
/// Make the initial sort direction Ascending when first sorting on this column (default).
const int ImGuiTableColumnFlags_PreferSortAscending   = 1 << 14;
/// Make the initial sort direction Descending when first sorting on this column.
const int ImGuiTableColumnFlags_PreferSortDescending  = 1 << 15;
/// Use current Indent value when entering cell (default for column 0).
const int ImGuiTableColumnFlags_IndentEnable          = 1 << 16;
/// Ignore current Indent value when entering cell (default for columns > 0). Indentation changes _within_ the cell will still be honored.
const int ImGuiTableColumnFlags_IndentDisable         = 1 << 17;
/// TableHeadersRow() will submit an angled header row for this column. Note this will add an extra row.
const int ImGuiTableColumnFlags_AngledHeader          = 1 << 18;

// Row flags
/// Identify header row (set default background color + width of its contents accounted differently for auto column width)
const int ImGuiTableRowFlags_Headers = 1 << 0;

/// No condition (always set the variable), same as _None
const int ImGuiCond_Always        = 1 << 0;
/// Set the variable once per runtime session (only the first call will succeed)
const int ImGuiCond_Once          = 1 << 1;
/// Set the variable if the object/window has no persistently saved data (no entry in .ini file)
const int ImGuiCond_FirstUseEver  = 1 << 2;
/// Set the variable if the object/window is appearing after being hidden/inactive (or the first time)
const int ImGuiCond_Appearing     = 1 << 3;


