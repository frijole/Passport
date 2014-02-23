//
//  FMPFirstViewController.h
//  Passport
//
//  Created by Ian Meyer on 2/23/14.
//  Copyright (c) 2014 Ian Meyer. All rights reserved.
//

#import "FMPTableViewController.h"

#import "FMPSelectPassportViewController.h"

extern const NSInteger FMPListViewControllerTabItemDefaultTag;

@interface FMPPassportPlaceCell : FMPTableViewCell
@end

@interface FMPPassportViewController : FMPTableViewController <FMPSelectPassportViewControllerDelegate>

@property (nonatomic, strong) FMPPassport *passport;

- (instancetype)initWithPassport:(FMPPassport *)passport;

@end
