//
//  FMPSelectPassportViewController.h
//  Passport
//
//  Created by Ian Meyer on 2/23/14.
//  Copyright (c) 2014 Ian Meyer. All rights reserved.
//

#import "FMPTableViewController.h"

@class FMPSelectPassportViewController;


@protocol FMPSelectPassportViewControllerDelegate <NSObject>

- (void)selectPassportViewControllerDidCancel;
- (void)selectPassportViewControllerDidSelectPassport:(FMPPassport *)passport;

@end


@interface FMPSelectPassportViewController : FMPTableViewController

@property (nonatomic, weak) NSObject <FMPSelectPassportViewControllerDelegate> *delegate;

- (instancetype)initWithDelegate:(NSObject <FMPSelectPassportViewControllerDelegate> *)delegate;

@end
