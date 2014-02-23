//
//  FMPSelectPassportViewController.m
//  Passport
//
//  Created by Ian Meyer on 2/23/14.
//  Copyright (c) 2014 Ian Meyer. All rights reserved.
//

#import "FMPSelectPassportViewController.h"

@interface FMPSelectPassportCell : FMPTableViewCell

@end

@implementation FMPSelectPassportCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    
    return self;
}

- (void)setDataObject:(NSObject *)dataObject
{
    [super setDataObject:dataObject];
    
    if ( [self.dataObject isKindOfClass:[FMPPassport class]] ) {
        FMPPassport *tmpPassport = (FMPPassport *)dataObject;
        
        self.textLabel.text = tmpPassport.title;
        self.detailTextLabel.text = [NSString stringWithFormat:@"%d places", @(tmpPassport.places.count).intValue];
    }
}

+ (NSString *)reuseIdentifier
{
    return @"FMPSelectPassportCellIdentifier";
}

@end


@interface FMPSelectPassportViewController () <UIAlertViewDelegate>

@end

@implementation FMPSelectPassportViewController

- (id)initWithDelegate:(NSObject<FMPSelectPassportViewControllerDelegate> *)delegate
{
    if ( self = [super initWithDataSource:[FMPDataHandler passports]] ) {
        [self setDelegate:delegate];
        [self setDefaultCellClass:[FMPSelectPassportCell class]];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"Select Passport"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonPressed)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed)];
}

#pragma mark - Buttons
- (void)cancelButtonPressed
{
    if ( self.delegate && [self.delegate respondsToSelector:@selector(selectPassportViewControllerDidCancel)] ) {
        [self.delegate selectPassportViewControllerDidCancel];
    }
}

- (void)addButtonPressed
{
    UIAlertView *tmpAlertView = [[UIAlertView alloc] initWithTitle:@"Add Passport" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [tmpAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [tmpAlertView show];
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ( buttonIndex == [alertView cancelButtonIndex] ) {
        // meh
    }
    else {
        NSString *tmpPassportName = [[alertView textFieldAtIndex:0] text];
        FMPPassport *tmpNewPassport = [FMPDataHandler addPassportNamed:tmpPassportName];
        if ( self.delegate && [self.delegate respondsToSelector:@selector(selectPassportViewControllerDidSelectPassport:)] ) {
            [self.delegate selectPassportViewControllerDidSelectPassport:tmpNewPassport];
        }
        else {
            [self.tableView reloadData];
        }
    }
}

#pragma mark - Table
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if ( self.delegate && [self.delegate respondsToSelector:@selector(selectPassportViewControllerDidSelectPassport:)] ) {
        [self.delegate selectPassportViewControllerDidSelectPassport:[self.dataSource objectAtIndex:indexPath.row]];
    }
}

@end
