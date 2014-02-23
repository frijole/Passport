//
//  FMPDataHandler.h
//  Passport
//
//  Created by Ian Meyer on 2/23/14.
//  Copyright (c) 2014 Ian Meyer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMPPlace;

@interface FMPPassport : NSObject <NSCoding>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *places;

- (FMPPlace *)addPlaceNamed:(NSString *)placeName;

@end


@interface FMPPlace : NSObject <NSCoding>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageName;

- (void)addStamp;
- (NSArray *)stamps; // NSDate's for when stamped

@end

@interface FMPStamp : NSObject <NSCoding>

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, weak) FMPPlace *place;
@property (nonatomic, weak) FMPPassport *passport;

@end


@interface FMPDataHandler : NSObject

+ (NSArray *)passports; // for Lists
+ (NSArray *)stamps;    // for Journal

+ (FMPPassport *)addPassportNamed:(NSString *)passportName;

+ (void)saveData; // save after stamping

@end
