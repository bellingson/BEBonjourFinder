//
//  RootViewController.h
//  BEBonjourFinder
//
//  Created by Ben Ellingson on 5/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BEBonjourFinder.h"
#import "BEBonjourFinderDelegate.h"

@interface RootViewController : UITableViewController <BEBonjourFinderDelegate> {

}

@property (retain, nonatomic) BEBonjourFinder *finder;
@property (retain, nonatomic) NSArray *rowData;


@end
