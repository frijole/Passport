//
//  FMPSecondViewController.m
//  Passport
//
//  Created by Ian Meyer on 2/23/14.
//  Copyright (c) 2014 Ian Meyer. All rights reserved.
//

#import "FMPJournalViewController.h"

const NSInteger FMPJournalViewControllerTabItemDefaultTag = INT_MAX-2;

#define kFMPJournalViewCellIdentifier @"FMPJournalCellIdentifier"


@interface FMPJournalCell ()
@end

@implementation FMPJournalCell

+ (NSString *)reuseIdentifier
{
    return kFMPJournalViewCellIdentifier;
}

@end


@interface FMPJournalViewController ()
@end

@implementation FMPJournalViewController

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
    
    [self setTitle:@"Journal"];
    [self setTabBarItem:[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:FMPJournalViewControllerTabItemDefaultTag]];
    
    [self setDefaultCellClass:[FMPTableViewCell class]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
