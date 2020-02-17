//
//  CBConstant.h
//  iOSCustomeBrowser
//
//  Created by Suryakant Sharma on 15/04/15.
//  Copyright (c) 2015 PayU, India. All rights reserved.
//

#ifndef iOSCustomeBrowser_CBConstant_h
#define iOSCustomeBrowser_CBConstant_h

//Macros To prevent instantiation of class by standard methods
#define ATTRIBUTE_ALLOC __attribute__((unavailable("alloc not available, call sharedSingletonInstance instead")))
#define ATTRIBUTE_INIT __attribute__((unavailable("init not available, call sharedSingletonInstance instead")))
#define ATTRIBUTE_NEW __attribute__((unavailable("new not available, call sharedSingletonInstance instead")))
#define ATTRIBUTE_COPY __attribute__((unavailable("copy not available, call sharedSingletonInstance instead")))

//Constants for web didFailLoad params
#define FAIL_URL_STRING     @"failUrlString"
#define FAIL_ERROR          @"failError"

#endif
