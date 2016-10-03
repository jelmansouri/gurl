# gurl
gURL


## Manual changes
generated manually :
base/win/base_features.h 
base/allocator/features.h
base/debug/debugging_flag.h
base/generated_build_date.h
base/trace_event/etw_manifest/chrome_events_win.h
base/trace_event/etw_manifest/chrome_events_win.rc
mc -h path_to_gurl\gurl\base\trace_event\etw_manifest -r path_to_gurl\gurl\base\trace_event\etw_manifest\. -um path_to_gurl\git\gurl\base\trace_event\etw_manifest\chrome_events_win.man