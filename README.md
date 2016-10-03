# gURL
gURL is a chromium subset represeting everything necessary to perform requets using different protocols 

### chromium base info
For all files that do not have a propper individual mirror, we try to synch all files to the same base chromium commit
03c7e50720e3a9e79cc2b443269b8327bbe52475

### Manual changes
generated manually :
base/win/base_features.h 
base/allocator/features.h
base/debug/debugging_flag.h
base/generated_build_date.h
base/trace_event/etw_manifest/chrome_events_win.h
base/trace_event/etw_manifest/chrome_events_win.rc
mc -h path_to_gurl\gurl\base\trace_event\etw_manifest -r path_to_gurl\gurl\base\trace_event\etw_manifest\. -um path_to_gurl\git\gurl\base\trace_event\etw_manifest\chrome_events_win.man