//
//  AldDataModel.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <CoreFoundation/CoreFoundation.h>
#import "AldDataModelConstants.h"
#import "AldDataModel.h"
#import "AldAFCountyInterpreter.h"
#import "AldAFOfficesInCountyInterpreter.h"
#import "AldAFOfficeDetailInterpreter.h"
#import "AldRequestState.h"

static AldDataModel *_defaultModel = nil;

@interface AldDataModel() {
    NSMutableSet *_activeConnections;
    CFMutableDictionaryRef _requests;
}

@end

@implementation AldDataModel

+(AldDataModel *) defaultModel
{
    @synchronized(self) {
        if (_defaultModel == nil) {
            _defaultModel = [[AldDataModel alloc] init];
        }
    }
    
    return _defaultModel;
}

-(id) init
{
    self = [super init];
    if (self) {
        _requests = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, NULL, &kCFTypeDictionaryValueCallBacks);
    }
    
    return self;
}

-(void) dealloc
{
    if (_requests) {
        CFRelease(_requests);
        _requests = NULL;
    }
}

-(void) requestCounties
{
    [self enqueueRequestWithURL:@"http://api.arbetsformedlingen.se/arbetsformedling/soklista/lan" withInterpreter:[AldAFCountyInterpreter class] andUserData:nil];
}

-(void) requestOfficesInCounty: (AldAFCounty *)county
{
    if (county == nil) {
        return;
    }
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.arbetsformedlingen.se/arbetsformedling/platser?lanid=%@", county.entityId];
    [self enqueueRequestWithURL:urlString withInterpreter:[AldAFOfficesInCountyInterpreter class] andUserData:county.entityId];
}

-(void) requestDetailsForOffice: (AldAFOffice *)office
{
    if (office == nil) {
        return;
    }
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.arbetsformedlingen.se/arbetsformedling/%@", office.entityId];
    [self enqueueRequestWithURL:urlString withInterpreter:[AldAFOfficeDetailInterpreter class] andUserData:office.entityId];
}

-(void) enqueueRequestWithURL: (NSString *)urlString withInterpreter: (Class) class andUserData: (id)data
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    NSURLConnection *conn = [NSURLConnection connectionWithRequest:req delegate:self];
    
    id interpreter = [[class alloc] init];
    AldRequestState *rq = [[AldRequestState alloc] initWithInterpreter: interpreter];
    rq.userData = data;
    
    // Associate the user data with the connection, and do this by looking at the connection's
    // hash, and using this numeric representation as a key to access the state object.
    CFDictionaryAddValue (_requests, conn.hash, (__bridge const void*)rq);
    
    // Make sure that the state object is retained. This might be unnecessary?
    [_activeConnections addObject:rq];
    
    [conn start];
}

-(AldRequestState *) stateForConnection: (NSURLConnection *)connection
{
    return (AldRequestState *)CFDictionaryGetValue(_requests, connection.hash);
}

-(void) makeStateObsolete: (NSURLConnection *)connection
{
    id state = [self stateForConnection:connection];
    if (state == nil) {
        return;
    }
    
    CFDictionaryRemoveValue(_requests, connection.hash);
    [_activeConnections removeObject:state];
}

-(void) connection: (NSURLConnection *)connection didReceiveResponse: (NSURLResponse *)response
{
    AldRequestState *state = [self stateForConnection:connection];
    if (state == nil) {
        return;
    }
    
    [state setData:[NSMutableData data]];
}

-(void) connection: (NSURLConnection *)connection didReceiveData: (NSData *)data
{
    AldRequestState *state = [self stateForConnection:connection];
    if (state == nil) {
        return;
    }
    
    [state.data appendData:data];
}

-(void) connectionDidFinishLoading: (NSURLConnection *)connection
{
    AldRequestState *state = [self stateForConnection:connection];
    if (state == nil) {
        return;
    }
    
    id data = [state.interpreter interpretJSON:state.data];
    id userData = [NSMutableDictionary dictionary];
    id iid = state.interpreter.interpretationId;
    
    if ([iid isEqualToString:kAldDataModelSignalDefault]) {
        // default message, assign the result as user data and pass it on, as there is
        // no container for these sort of messages.
        [userData setValue:data forKey:kAldDataModelSignalDefault];
    }
    
    else if ([iid isEqualToString:kAldDataModelSignalCounties]) {
        @synchronized (self.counties) {
            [self setCounties:data];
        }
    }
    
    else if ([iid isEqualToString:kAldDataModelSignalOffices]) {
        @synchronized (self.officesInCounties) {
            if (self.officesInCounties == nil) {
                self.officesInCounties = [NSMutableDictionary dictionary];
            }
            
            [self.officesInCounties setValue:data forKey:state.userData];
        }
        
        [userData setValue:state.userData forKey:@"key"];
    }
    
    else if ([iid isEqualToString:kAldDataModelSignalOffice]) {
        @synchronized (self.officesInCounties) {
            if (self.offices == nil) {
                self.offices = [NSMutableDictionary dictionary];
            }
            
            [self.offices setValue:data forKey:state.userData];
        }
        
        [userData setValue:state.userData forKey:@"key"];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:state.interpreter.interpretationId object:self userInfo:userData];
        
    [self makeStateObsolete:connection];
}

-(void) connection: (NSURLConnection *)connection didFailWithError: (NSError *)error
{
    [self makeStateObsolete:connection];
}

@end
