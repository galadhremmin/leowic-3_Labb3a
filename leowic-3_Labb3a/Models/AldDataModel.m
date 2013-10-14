//
//  AldDataModel.m
//  leowic-3_Labb3a
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <CoreFoundation/CoreFoundation.h>
#import "AldDataModel.h"
#import "AldAFCountyInterpreter.h"
#import "AldRequestState.h"

@interface AldDataModel() {
    NSMutableSet *_activeConnections;
    CFMutableDictionaryRef _requests;
}

@end

@implementation AldDataModel

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
    [self enqueueRequestWithURL:@"http://api.arbetsformedlingen.se/arbetsformedling/soklista/lan" withInterpreter:[AldAFCountyInterpreter class]];
}

-(void) enqueueRequestWithURL: (NSString *)urlString withInterpreter: (Class) class
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:req delegate:self];
    
    id interpreter = [[class alloc] init];
    AldRequestState *rq = [[AldRequestState alloc] initWithInterpreter: interpreter];
    
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
    
    id data = [state.interpreter interpret:state.data];
    [[NSNotificationCenter defaultCenter] postNotificationName:state.interpreter.interpretationId object:self userInfo:[NSDictionary dictionaryWithObject:data forKey:state.interpreter.interpretationId]];
        
    [self makeStateObsolete:connection];
}

-(void) connection: (NSURLConnection *)connection didFailWithError: (NSError *)error
{
    [self makeStateObsolete:connection];
}

@end
