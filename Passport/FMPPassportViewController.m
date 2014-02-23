//
//  FMPFirstViewController.m
//  Passport
//
//  Created by Ian Meyer on 2/23/14.
//  Copyright (c) 2014 Ian Meyer. All rights reserved.
//

#import "FMPPassportViewController.h"

#define kFMPListCellIdentifier @"FMPListCellIdentifier"

@interface FMPPassportPlaceCell ()
@end

@implementation FMPPassportPlaceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    
    return self;
}

+ (NSString *)reuseIdentifier
{
    return kFMPListCellIdentifier;
}

- (void)setDataObject:(NSObject *)dataObject
{
    [super setDataObject:dataObject];
    
    if ( [dataObject respondsToSelector:@selector(stamps)] ) {
        FMPPlace *tmpPlace = (FMPPlace *)dataObject;
        self.textLabel.text = tmpPlace.title;
        self.detailTextLabel.text = [NSString stringWithFormat:@"%d",@(tmpPlace.stamps.count).intValue];
    }
}

@end


@interface FMPPassportViewController () <UIAlertViewDelegate>
@end

@implementation FMPPassportViewController

- (instancetype)initWithPassport:(FMPPassport *)passport
{
    if ( self = [super initWithDataSource:passport.places] ) {
        // Post-initialization customization.
        [self setPassport:passport];
        [self setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"Places"
                                                          image:[UIImage imageNamed:@"places-off"]
                                                  selectedImage:[UIImage imageNamed:@"places-on"]]];
        [self setDefaultCellClass:[FMPPassportPlaceCell class]];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"hamburger"] style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonPressed)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed)];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ( !self.passport ) {
        [self menuButtonPressed];
    }
}

- (void)setPassport:(FMPPassport *)passport
{
    _passport = passport;
    
    [self setTitle:passport.title?:@"No Passport"];
    
    if ( self.dataSource != passport.places ) {
        [self setDataSource:passport.places];
        [self.tableView reloadData];
        if ( passport.places.count > 0 ) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }
}

#pragma mark - Buttons
- (void)menuButtonPressed
{
    FMPSelectPassportViewController *tmpSelectPassportViewController = [[FMPSelectPassportViewController alloc] initWithDelegate:self];
    UINavigationController *tmpSelectPassportNavController = [[UINavigationController alloc] initWithRootViewController:tmpSelectPassportViewController];
    [self presentViewController:tmpSelectPassportNavController animated:YES completion:nil];
}

- (void)addButtonPressed
{
    UIAlertView *tmpAlertView = [[UIAlertView alloc] initWithTitle:@"Add Place" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [tmpAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [tmpAlertView show];
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ( buttonIndex == [alertView cancelButtonIndex] ) {
        // meh
    }
    else {
        NSString *tmpPlaceName = [[alertView textFieldAtIndex:0] text];
        FMPPlace *tmpNewPlace = [self.passport addPlaceNamed:tmpPlaceName];
        [self setDataSource:self.passport.places]; // becuase addPlaceNamed causes the places array to be regenerated. ugh.
        NSInteger tmpIndexOfPlace = [self.passport.places indexOfObject:tmpNewPlace];
        if ( tmpIndexOfPlace != NSNotFound ) {
            NSIndexPath *tmpNewIndexPath = [NSIndexPath indexPathForItem:tmpIndexOfPlace inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[tmpNewIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}

#pragma mark - Select Passport Delegate
- (void)selectPassportViewControllerDidCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)selectPassportViewControllerDidSelectPassport:(FMPPassport *)passport
{
    [self setPassport:passport];
    [self.tableView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // add a stamp to the passport place!
    FMPPlace *tmpPlace = [self.passport.places objectAtIndex:indexPath.row];
    [tmpPlace addStamp];

    // and reload the row to update the label for the new stamp
    // reload the whole section becasuse reloading just one cell can fuck up the seperators
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
}

@end
