//
//  RestService.h
//  Locate
//
//  Created by ITSSTS on 7/7/15.
//  Copyright (c) 2015 ITSSTS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequestCompletionHandler)(NSData*,NSError*);
@interface RestService : NSObject
+(void) requestPath:(NSString *)path
        RequestDics:(NSMutableDictionary *) requestDic
      onCompletion:(RequestCompletionHandler)complete;
@end
