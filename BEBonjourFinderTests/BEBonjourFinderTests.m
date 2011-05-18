//
//  BEBonjourFinderTests.m
//  BEBonjourFinderTests
//
//  Created by Ben Ellingson on 5/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BEBonjourFinderTests.h"

#import "BEBonjourFinder.h"

@implementation BEBonjourFinderTests


BOOL hasReturn = NO;

NSCondition *condition = nil;

- (void)setUp
{
    [super setUp];
    

}

- (void)tearDown
{
    [super tearDown];
}

- (void) didFindBonjourHosts:(NSArray *)hostNames {
    
    NSLog(@"did find hosts: %@",hostNames);

    hasReturn = YES;    
    [condition signal];
    [condition unlock];
    
}

- (void)testExample
{
    
    // not sure how to test this code
    
    BEBonjourFinder *finder = [[BEBonjourFinder alloc] init];
    finder.delegate = self;
    
    
    double time = [NSDate timeIntervalSinceReferenceDate];
    time += 100;
    
    NSDate *end = [NSDate dateWithTimeIntervalSinceReferenceDate: time];

    condition = [[NSCondition alloc] init];
    [condition lock];

    
    [finder findWebServices];
    
    NSLog(@"requested find");    
    
    if (hasReturn == NO) {
        [condition waitUntilDate: end];
    }
    
    //[condition waitUntilDate: end]; 
    
    NSLog(@"has return: %d",hasReturn);
    
    
}

@end
