//
//  BEBonjourFinderDelegate.h
//  BEBonjourFinder
//
//  Created by Ben Ellingson on 5/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BEBonjourFinderDelegate <NSObject>

- (void) didFindNetServices: (NSArray *) services;

- (void) didFindBonjourHosts: (NSArray *) hostNames;

@end
