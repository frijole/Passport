//
//  FMPDataHandler.m
//  Passport
//
//  Created by Ian Meyer on 2/23/14.
//  Copyright (c) 2014 Ian Meyer. All rights reserved.
//

#import "FMPDataHandler.h"

static NSArray *_passports = nil;

#define kFMPDataHandlerPassportFileName @"passports"

@interface FMPPassport ()
@end

@implementation FMPPassport

- (FMPPlace *)addPlaceNamed:(NSString *)placeName
{
    FMPPlace *tmpNewPlace = [[FMPPlace alloc] init];
    [tmpNewPlace setTitle:placeName];
    
    [self setPlaces:[[self places] arrayByAddingObject:tmpNewPlace]];
    
    [FMPDataHandler saveData];
    
    return tmpNewPlace;
}

- (NSArray *)places
{
    return _places?:@[];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ( self = [super init] ) {
        [self setTitle:[aDecoder decodeObjectForKey:@"title"]];
        [self setPlaces:[aDecoder decodeObjectForKey:@"places"]];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.places forKey:@"places"];
}

@end


@interface FMPPlace ()
@property (nonatomic, strong) NSArray *stamps;
@end

@implementation FMPPlace

- (NSArray *)stamps
{
    return _stamps?:@[];
}

- (void)addStamp
{
    FMPStamp *tmpNewStamp = [[FMPStamp alloc] init];
    [tmpNewStamp setDate:[NSDate date]];
    [tmpNewStamp setPlace:self];
    
    [self setStamps:[[self stamps] arrayByAddingObject:tmpNewStamp]];
    
    [FMPDataHandler saveData];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ( self = [super init] ) {
        [self setTitle:[aDecoder decodeObjectForKey:@"title"]];
        [self setImageName:[aDecoder decodeObjectForKey:@"imageName"]];
        [self setStamps:[aDecoder decodeObjectForKey:@"stamps"]];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.imageName forKey:@"imageName"];
    [aCoder encodeObject:self.stamps forKey:@"stamps"];
}

@end

@interface FMPStamp ()
@end

@implementation FMPStamp

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ( self = [super init] ) {
        [self setDate:[aDecoder decodeObjectForKey:@"date"]];
        [self setPlace:[aDecoder decodeObjectForKey:@"place"]];
        [self setPassport:[aDecoder decodeObjectForKey:@"passport"]];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.place forKey:@"place"];
    [aCoder encodeObject:self.passport forKey:@"passport"];
}

@end

@interface FMPDataHandler ()
@end

@implementation FMPDataHandler

+ (NSArray *)passports
{
    if ( !_passports ) {
        // try to load from disk
        NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *tmpPassportsFilePath = [NSString stringWithFormat:@"%@/%@",[documentDirectories objectAtIndex:0],kFMPDataHandlerPassportFileName];
        NSArray *tmpPassportsFromDisk = [NSKeyedUnarchiver unarchiveObjectWithFile:tmpPassportsFilePath];
        if ( tmpPassportsFromDisk && tmpPassportsFromDisk.count > 0 ) {
            _passports = tmpPassportsFromDisk;
            NSLog(@"✅ loaded passports from disk");
        } else {
            NSLog(@"⚠️ failed to load passports from disk");
        }
    }
    
    if ( !_passports ) {
        // failed to load from disk, use empty array
        _passports = @[];
    }
    
    return _passports;
}

+ (NSArray *)stamps
{
    // collect all the passport locations
    NSMutableArray *tmpStampArray = [NSMutableArray array];
    
    for ( FMPPassport *tmpPassport in [[self class] passports] ) {
        for ( FMPPlace *tmpPlace in tmpPassport.places ) {
            for ( FMPStamp *tmpStamp in tmpPlace.stamps ) {
                [tmpStamp setPassport:tmpPassport];
                [tmpStampArray addObject:tmpStamp];
            }
        }
    }
    
    // sort the stamps by date
    NSSortDescriptor *tmpSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    [tmpStampArray sortUsingDescriptors:@[tmpSortDescriptor]];

    return [NSArray arrayWithArray:tmpStampArray];
}

+ (FMPPassport *)addPassportNamed:(NSString *)passportName
{
    FMPPassport *tmpNewPassport = [[FMPPassport alloc] init];
    [tmpNewPassport setTitle:passportName];
    
    _passports = [[[self class] passports] arrayByAddingObject:tmpNewPassport];
    
    [self saveData];

    return tmpNewPassport;
}

+ (void)saveData
{
    NSArray *documentsDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *tmpPassportsFilePath = [NSString stringWithFormat:@"%@/%@",[documentsDirectories objectAtIndex:0],kFMPDataHandlerPassportFileName];
    BOOL tmpSaveStatus = [NSKeyedArchiver archiveRootObject:[[self class] passports] toFile:tmpPassportsFilePath];
    
    if ( tmpSaveStatus ) {
        NSLog(@"✅ saved passports to disk");
    } else {
        NSLog(@"⚠️ error saving passports to disk");
    }
    
}


@end
