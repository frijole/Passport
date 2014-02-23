//
//  FMPTableViewController.m
//  Passport
//
//  Created by Ian Meyer on 2/23/14.
//  Copyright (c) 2014 Ian Meyer. All rights reserved.
//

#import "FMPTableViewController.h"

#define kFMPTableViewCellIdentifier  @"FMPTableViewControllerDefaultCellIdentifier"

@interface FMPTableViewCell ()
@end

@implementation FMPTableViewCell

+ (NSString *)reuseIdentifier
{
    return kFMPTableViewCellIdentifier;
}

+ (CGFloat)heightForDataObject:(NSObject *)dataObject
{
    return 44.0f;
}

@end


@interface FMPTableViewController ()

@property (nonatomic, strong) NSArray *dataSource;

@end


@implementation FMPTableViewController

- (instancetype)initWithDataSource:(NSArray *)dataSource
{
    self = [self initWithStyle:UITableViewStylePlain andDataSource:dataSource];
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style andDataSource:(NSArray *)dataSource
{
    if ( self = [super initWithStyle:style] ) {
        [self setDataSource:dataSource];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    NSInteger rtnCount = 1;
    
    return rtnCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSInteger rtnCount = 0;
    
    if ( self.dataSource ) {
        rtnCount = self.dataSource.count;
    }
    
    return rtnCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get ready to get a cell by figuring out what reuse identifier to use...
    NSString *tmpCellIdentifier = kFMPTableViewCellIdentifier;
    if ( self.defaultCellClass && [self.defaultCellClass respondsToSelector:@selector(reuseIdentifier)] ) {
        tmpCellIdentifier = [self.defaultCellClass reuseIdentifier];
    }

    // Get a cell...
    UITableViewCell *rtnCell = [tableView dequeueReusableCellWithIdentifier:tmpCellIdentifier forIndexPath:indexPath];
    
    // ...and configure it.
    if ( [rtnCell respondsToSelector:@selector(setDataObject:)] ) {
        [(FMPTableViewCell *)rtnCell setDataObject:[self.dataSource objectAtIndex:indexPath.row]];
    }
    else {
        rtnCell.textLabel.text = [[self.dataSource objectAtIndex:indexPath.row] description];
    }
    
    return rtnCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
