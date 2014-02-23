//
//  FMPTableViewController.h
//  Passport
//
//  Created by Ian Meyer on 2/23/14.
//  Copyright (c) 2014 Ian Meyer. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FMPTableViewCell : UITableViewCell

@property (nonatomic, strong) NSObject *dataObject;

+ (NSString *)reuseIdentifier;
+ (CGFloat)heightForDataObject:(NSObject *)dataObject;

@end


@interface FMPTableViewController : UITableViewController

- (instancetype)initWithDataSource:(NSArray *)dataSource; // defaults to UITableViewStylePlain
- (instancetype)initWithStyle:(UITableViewStyle)style andDataSource:(NSArray *)dataSource;

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic) Class defaultCellClass;

@end