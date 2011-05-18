//
//  BEBonjourFinder.h
//  BEBonjourFinder
//
//  Created by Ben Ellingson on 5/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BEBonjourFinderDelegate.h"

#define kWebServiceType @"_http._tcp"
#define kInitialDomain  @"local"


@interface BEBonjourFinder : NSObject <NSNetServiceBrowserDelegate, NSNetServiceDelegate> {
    
}

@property (retain, nonatomic) NSString *nameFilter;
@property (retain, nonatomic) NSString *domain;
@property (retain, nonatomic) NSNetServiceBrowser *browser;
@property (retain, nonatomic) id <BEBonjourFinderDelegate> delegate;

@property (retain, nonatomic) NSMutableArray *services;
@property (retain, nonatomic) NSMutableArray *resolveQueue;


- (void) findWebServices;

- (void) findNetServices: (NSString *) type;




@end
