//
//  nslogHelper.h
//  ePOS2_Printer
//
//

#ifndef nslogHelper_h
#define nslogHelper_h

#ifdef DEBUG
#define NSLog(__FORMAT__, ...) NSLog((@"%s %s:%d " __FORMAT__), (strrchr(__FILE__, '/') ?: __FILE__ - 1) + 1, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define NSLog(...)
#endif

#endif /* nslogHelper_h */
