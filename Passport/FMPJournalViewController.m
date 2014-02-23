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


@interface FMPJournalEntryCell ()

@property (nonatomic, weak) UILabel *accessoryLabel;

@end


@implementation FMPJournalEntryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ( self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier] )
    {
        UILabel *tmpAccecssoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 40.0f)];
        [tmpAccecssoryLabel setTextAlignment:NSTextAlignmentRight];
        [self setAccessoryView:tmpAccecssoryLabel];
        [self setAccessoryLabel:tmpAccecssoryLabel];
    }
    
    return self;
}

- (void)setDataObject:(NSObject *)dataObject
{
    [super setDataObject:dataObject];
    
    if ( [dataObject isKindOfClass:[FMPStamp class]] ) {
        FMPStamp *tmpStamp = (FMPStamp *)dataObject;
        self.textLabel.text = tmpStamp.place.title;
        self.detailTextLabel.text = tmpStamp.passport.title;
        self.accessoryLabel.text = tmpStamp.date.description; // TODO: use date formatter
    }
}

+ (CGFloat)heightForDataObject:(NSObject *)dataObject
{
    return 60.0f;
}

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
        [self setTitle:@"Journal"];
        [self setTabBarItem:[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:FMPJournalViewControllerTabItemDefaultTag]];
        [self setDefaultCellClass:[FMPJournalEntryCell class]];
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setDataSource:[FMPDataHandler stamps]];
    [self.tableView reloadData];
}

@end
