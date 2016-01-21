//
//  RestService.m
//  Locate
//
//  Created by ITSSTS on 7/7/15.
//  Copyright (c) 2015 ITSSTS. All rights reserved.
//

#import "RestService.h"
#define timeOutInterval 60

@implementation RestService
+(void)requestPath:(NSString *)path RequestDics:(NSMutableDictionary *) requestDic onCompletion:(RequestCompletionHandler)complete{
    // Background Queue
    NSOperationQueue *backgroundQueue = [[NSOperationQueue alloc] init];
    
    //Setting Header Parameters
    /*NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *eid = [userDefaults objectForKey:@"eid"];
    NSString *accessToken = [userDefaults objectForKey:@"Authorization"];
    NSString *deviceID = [userDefaults objectForKey:@"deviceID"];
    NSString *clientId = [userDefaults objectForKey:@"client_id"];
    NSString *deviceMetaData = [userDefaults objectForKey:@"devicemetadata"];*/
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:timeOutInterval];
    //setting Request Json
    if(requestDic != nil && [requestDic count] > 0){
        
        NSMutableArray *noteArray = [[NSMutableArray alloc] init];
        [noteArray addObject:requestDic];
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:noteArray
                                                           options:0
                                                             error:&error];
        //NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding: NSUTF8StringEncoding];
        
        //NSLog(@"JSON = %@", jsonString);

        [request setHTTPMethod:@"GET"];
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[jsonData length]];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
        [request setHTTPBody:jsonData];
    }
    
    
    // URL Request
    [request setTimeoutInterval:timeOutInterval];
    [request setValue:@"PIexcvATDWwMIgSZhqgLbtghzvALdE74" forHTTPHeaderField:@"X-ZUMO-APPLICATION"];
    /*[request setValue:eid forHTTPHeaderField:@"eid"];
    [request setValue:accessToken forHTTPHeaderField:@"accessToken"];
    [request setValue:deviceID forHTTPHeaderField:@"deviceID"];
    [request setValue:clientId forHTTPHeaderField:@"clientId"];
    [request setValue:deviceMetaData forHTTPHeaderField:@"deviceMetaData"];*/
    [request setAllowsCellularAccess:YES];
    
    // Send Request
    [NSURLConnection sendAsynchronousRequest:request
                queue:backgroundQueue
                completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){

       NSDictionary *resultsDic;
       if (data.length > 0 && error == nil){
           
           id object = [NSJSONSerialization
                        JSONObjectWithData:data
                        options:kNilOptions
                        error:nil];
           if(object == nil){
               NSMutableDictionary* details = [NSMutableDictionary dictionary];
               [details setValue:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] forKey:NSLocalizedDescriptionKey];
               error = [NSError errorWithDomain:@"Locate" code:200 userInfo:details];
           }else if([object isKindOfClass:[NSDictionary class]] == YES){
               resultsDic =(NSDictionary *)object;
               if (resultsDic != nil && [resultsDic objectForKey:@"Message"] != nil) {
                   NSMutableDictionary* details = [NSMutableDictionary dictionary];
                   [details setValue:[[resultsDic objectForKey:@"Message"] stringByAppendingString:@" Please try after some time."] forKey:NSLocalizedDescriptionKey];
                   error = [NSError errorWithDomain:@"Locate" code:200 userInfo:details];
               }
           }
       }else{
           NSMutableDictionary* details = [NSMutableDictionary dictionary];
           [details setValue:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] forKey:NSLocalizedDescriptionKey];
           error = [NSError errorWithDomain:@"Locate" code:200 userInfo:details];
       }
       if (complete) complete(data,error);
   }];
}

@end
