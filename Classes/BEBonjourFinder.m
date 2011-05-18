//
//  BEBonjourFinder.m
//  BEBonjourFinder
//
//  Created by Ben Ellingson on 5/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BEBonjourFinder.h"


@implementation BEBonjourFinder

@synthesize nameFilter, domain,browser, delegate, services, resolveQueue;

#pragma mark -
#pragma mark private methods

- (NSArray *) hostNames {

    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity: services.count];
    for (NSNetService *service in services) {
        [items addObject: [service hostName]];
    }
    return  items;
    
}


- (void) requestComplete {
    
    if ([delegate respondsToSelector: @selector(didFindBonjourHosts:)]) {
        [delegate didFindBonjourHosts: [self hostNames]];
    }
    
    if ([delegate respondsToSelector: @selector(didFindNetServices:)]) {
        [delegate didFindNetServices: services];
    }
    
}


#pragma mark -
#pragma mark init

- (id)init {
    self = [super init];
    if (self) {
        self.domain = kInitialDomain;
        self.browser = [[NSNetServiceBrowser alloc] init];
        browser.delegate = self;
        
        self.services = [[NSMutableArray alloc] init];
        self.resolveQueue = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark -
#pragma mark public methods

- (void) findWebServices {
    
    [self findNetServices: kWebServiceType];
    
}

- (void) findNetServices: (NSString *) type {
    
    [browser searchForServicesOfType: type inDomain:domain];
    
}



#pragma mark -
#pragma mark NSNetServiceBrowser methods


- (void)netServiceDidResolveAddress:(NSNetService *)sender {
    
    [resolveQueue removeObject: sender];
    
    if (resolveQueue.count == 0) {
        [self requestComplete];
    }
    
}

- (void) netService:(NSNetService *)sender didNotResolve:(NSDictionary *)errorDict {
    
    [resolveQueue removeObject: sender];
    [services removeObject: sender];
    
    if (resolveQueue.count == 0) {
        [self requestComplete];
    }
    
}


- (void) resolveNetServices {
    
    if (services.count == 0) {
        [self requestComplete];  
        return;
    }
    
    for (NSNetService *service in services) {
        [resolveQueue addObject: service];            
        service.delegate = self;
        [service resolveWithTimeout: 5.0];
    }
    
}

- (BOOL) acceptService: (NSNetService *) service {
    
    if (nameFilter == nil) {
        return YES;
    }
    
    NSString *serviceName = [service name];
    return  ([serviceName rangeOfString: nameFilter].location != NSNotFound); 
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didFindService:(NSNetService *)aNetService moreComing:(BOOL)moreComing {

    NSLog(@"found service: %@",[aNetService name]);    
    
    if ([self acceptService: aNetService] == NO) return;
    
    if ([services containsObject: aNetService] == NO) {
            [services addObject: aNetService];
    }
    
    if(!moreComing) {
        [self resolveNetServices];
    }
    
}

- (void) netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didNotSearch:(NSDictionary *)errorDict {
    [self requestComplete];    
}

- (void) stop {
    [browser stop];
}


#pragma mark -
#pragma mark memory

- (void)dealloc {
    [nameFilter release];
    [domain release];
    [browser release];
    [delegate release];
    [services release];
    [resolveQueue release];
    [super dealloc];
}



@end
