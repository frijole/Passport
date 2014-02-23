//
//  FMPFirstViewController.m
//  Passport
//
//  Created by Ian Meyer on 2/23/14.
//  Copyright (c) 2014 Ian Meyer. All rights reserved.
//

#import "FMPListViewController.h"

const NSInteger FMPListViewControllerTabItemDefaultTag = INT_MAX-1;

#define kFMPListCellIdentifier @"FMPListCellIdentifier"


@interface FMPListCell ()
@end

@implementation FMPListCell

+ (NSString *)reuseIdentifier
{
    return kFMPListCellIdentifier;
}

@end


@interface FMPListViewController ()
@end

@implementation FMPListViewController

- (instancetype)init
{
    if ( self = [super initWithDataSource:@[]] ) {
        // Post-initialization customization.
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view
    
    [self setTitle:@"List"];
    [self setTabBarItem:[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:FMPListViewControllerTabItemDefaultTag]];
    
    [self setDefaultCellClass:[FMPTableViewCell class]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

@end
