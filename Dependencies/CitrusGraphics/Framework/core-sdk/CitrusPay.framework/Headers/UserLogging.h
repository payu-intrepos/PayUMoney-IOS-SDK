//
//  UserLogging.h
//  CitrusPayiOSSDK
//
//  Created by Mukesh Patil on 1/7/16.
//  Copyright © 2016 Mukesh Patil. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Version.h"

/**
 * Set this switch to  enable or disable logging capabilities.
 * This can be set either here or via the compiler build setting
 * GCC_PREPROCESSOR_DEFINITIONS
 * in your build configuration. Using the compiler build setting is preferred
 * for this to
 * ensure that logging is not accidentally left enabled by accident in release
 * builds.
 */
#ifdef ENABLE_LOGGING //1 if merchant defined this macro then use it

#ifndef LOGGING_ENABLED
#define LOGGING_ENABLED ENABLE_LOGGING
#endif

#else//1 else if debug is True start the Logging

#ifndef LOGGING_ENABLED //2 if start
#ifdef DEBUG //3 if start
#define LOGGING_ENABLED 1

#else
#define LOGGING_ENABLED 0 //if debug is not defined then dont log
#endif // 3 if end
#endif //2 if end

#endif // end 1


/**
 * Set any or all of these switches to enable or disable logging at specific
 * levels.
 * These can be set either here or as a compiler build settings.
 * For these settings to be effective, LOGGING_ENABLED must also be defined and
 * non-zero.
 */
#ifndef LOGGING_LEVEL_TRACE
#define LOGGING_LEVEL_TRACE 1
#endif
#ifndef LOGGING_LEVEL_INFO
#define LOGGING_LEVEL_INFO 1
#endif
#ifndef LOGGING_LEVEL_ERROR
#define LOGGING_LEVEL_ERROR 1
#endif
#ifndef LOGGING_LEVEL_DEBUG
#define LOGGING_LEVEL_DEBUG 1
#endif

/**
 * Set this switch to indicate whether or not to include class, method and line
 * information
 * in the log entries. This can be set either here or as a compiler build
 * setting.
 */
#ifndef LOGGING_INCLUDE_CODE_LOCATION
#define LOGGING_INCLUDE_CODE_LOCATION 0
#endif

// *********** END OF USER SETTINGS  - Do not change anything below this line
// ***********

#if !(defined(LOGGING_ENABLED) && LOGGING_ENABLED)
#undef LOGGING_LEVEL_TRACE
#undef LOGGING_LEVEL_INFO
#undef LOGGING_LEVEL_ERROR
#undef LOGGING_LEVEL_DEBUG
#endif

// Logging format
#define LOG_FORMAT_NO_LOCATION(fmt, lvl, ...) \
NSLog((@"[%@ v%@] " fmt), lvl,SDK_VERSION, ##__VA_ARGS__)
#define LOG_FORMAT_WITH_LOCATION(fmt, lvl, ...) \
NSLog((@"%s[Line %d] [%@] " fmt),             \
__PRETTY_FUNCTION__,                    \
__LINE__,                               \
lvl,                                    \
##__VA_ARGS__)

#if defined(LOGGING_INCLUDE_CODE_LOCATION) && LOGGING_INCLUDE_CODE_LOCATION
#define LOG_FORMAT(fmt, lvl, ...) \
LOG_FORMAT_WITH_LOCATION(fmt, lvl, ##__VA_ARGS__)
#else
#define LOG_FORMAT(fmt, lvl, ...) \
LOG_FORMAT_NO_LOCATION(fmt, lvl, ##__VA_ARGS__)
#endif

// Trace logging - for detailed tracing
//#if defined(LOGGING_LEVEL_TRACE) && LOGGING_LEVEL_TRACE
//#define LogTrace(fmt, ...) LOG_FORMAT(fmt, @"CitrusPay SDK", ##__VA_ARGS__)
//#else
//#define LogTrace(...)
//#endif

// Info logging - for general, non-performance affecting information messages
//#if defined(LOGGING_LEVEL_INFO) && LOGGING_LEVEL_INFO
//#define LogInfo(fmt, ...) LOG_FORMAT(fmt, @"CitrusPay info", ##__VA_ARGS__)
//#else
//#define LogInfo(...)
//#endif

// Error logging - only when there is an error to be logged
//#if defined(LOGGING_LEVEL_ERROR) && LOGGING_LEVEL_ERROR
//#define LogError(fmt, ...) LOG_FORMAT(fmt, @"CitrusPay ***ERROR***", ##__VA_ARGS__)
//#else
//#define LogError(...)
//#endif

// Debug logging - use only temporarily for highlighting and tracking down
// problems
//#if defined(LOGGING_LEVEL_DEBUG) && LOGGING_LEVEL_DEBUG
//#define LogDebug(fmt, ...) LOG_FORMAT(fmt, @"CitrusPay DEBUG", ##__VA_ARGS__)
//#else
//#define LogDebug(...)
//
//#endif

#define ENTRY_LOG LogTrace(@"%s ENTRY CitrusPay", __PRETTY_FUNCTION__);
#define EXIT_LOG LogTrace(@"%s EXIT CitrusPay", __PRETTY_FUNCTION__);
#define ERROR_EXIT_LOG LogError(@"%s ERROR EXIT CitrusPay", __PRETTY_FUNCTION__);

@interface UserLogging : NSObject
void LogTrace(NSString *format,...);

void LogVerbose(NSString *format,...);
void LogDebug(NSString *format,...);
void LogInfo(NSString *format,...);
void LogWarning(NSString *format,...);
void LogError(NSString *format,...);
void LogSevere(NSString *format,...);

void LogInfo_LazyPay(NSString *format,...);
void LogError_LazyPay(NSString *format,...);
@end
