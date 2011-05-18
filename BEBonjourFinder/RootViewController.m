//
//  RootViewController.m
//  BEBonjourFinder
//
//  Created by Ben Ellingson on 5/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

@synthesize finder, rowData;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Web Services";
    
    self.finder = [[BEBonjourFinder alloc] init];
    finder.delegate = self;
    [finder findWebServices];
        
}

- (void) didFindBonjourHosts:(NSArray *)hostNames {
    
    self.rowData = hostNames;
    
    [self.tableView reloadData];
}


// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rowData.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSString *hostName = [rowData objectAtIndex: indexPath.row];
    
    cell.textLabel.text = hostName;

    // Configure the cell.
    return cell;
}


- (void)dealloc
{
    [finder release];
    [super dealloc];
}

@end
