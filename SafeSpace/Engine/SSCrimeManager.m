//
//  SSCommsManager.m
//  SafeSpace
//
//  Created by Rob Frampton on 24/10/2015.
//  Copyright © 2015 Team Moonflop. All rights reserved.
//

#import "SSCrimeManager.h"

@interface SSCrimeManager()

@property int monthCount;
@property int currentMonth;
@property int currentYear;
@property NSMutableArray *currentData;

@end

@implementation SSCrimeManager

static NSString *STREET_LEVEL_CRIME_PARAM_POLY = @"53.545612,-2.392273:53.398070,-2.392273:53.398070,-2.112122:53.545612,-2.112122";

- (instancetype) init {
    if ((self = [super init])) {
        _monthCount = 0;
        _currentMonth = 0;
        _currentYear = 0;
    }
    return self;
}

+ (RKObjectManager *)createObjectManager
{
    // initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"https://data.police.uk"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    return objectManager;
}

+ (RKObjectManager *)createStreetLevelCrimeObjectManager {
    RKObjectManager *objectManager = [[self class] createObjectManager];
    
    // setup object mappings
    RKObjectMapping *streetLevelCrimeMapping = [SSMappingProvider streetLevelCrimeMapping];
    
    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:streetLevelCrimeMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/api/crimes-street/vehicle-crime"
                                                keyPath:@""
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    [objectManager addResponseDescriptor:responseDescriptor];
    
    return objectManager;
}

- (void)requestStreetLevelCrimeForYear:(int)year month:(int)month callback:(StreetLevelCrimeCallback)callback {
    RKObjectManager *objectManager = [[self class] createStreetLevelCrimeObjectManager];
    
    NSDictionary *queryParams = @{@"poly" : STREET_LEVEL_CRIME_PARAM_POLY,
                                  @"date" : [NSString stringWithFormat:@"%04d-%02d", year, month]};
    
    [objectManager getObjectsAtPath:@"/api/crimes-street/vehicle-crime"
                         parameters:queryParams
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                NSArray *streetLevelCrimeArray = [mappingResult array];
                                NSMutableArray *crimeArray = [NSMutableArray array];
                                for (SSStreetLevelCrime *streetLevelCrime in streetLevelCrimeArray) {
                                    SSCrimePoint *crimePoint = [SSCrimePoint new];
                                    crimePoint.latitude = streetLevelCrime.location.latitude;
                                    crimePoint.longitude = streetLevelCrime.location.longitude;
                                    crimePoint.month = month;
                                    crimePoint.year = year;
                                    [crimeArray addObject:crimePoint];
                                }
                                callback(crimeArray);
                            }
                            failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                NSLog(@"What do you mean by 'there is no coffee?': %@", error);
                            }];
}

- (void)getCachedStreetLevelCrimeForMonth:(int)month year:(int)year callback:(StreetLevelCrimeCallback)callback {
    if (!callback) {
        NSLog(@"CALLBACK IS NIL");
    }
    
    NSLog(@"getCachedStreetLevelCrimeForMonth:%d year:%d", month, year);
    __block NSArray *data = [self loadCrimeArrayFromDiskForYear:year month:month];
    if (data) {
        callback(data);
    }
    else {
        [self requestStreetLevelCrimeForYear:year month:month callback:^(NSArray *data) {
            [self saveCrimeArrayToDisk:data forYear:year month:month];
            if (callback) {
                callback(data);
            }
            else {
                NSLog(@"CALLBACK IS NIL");
            }
        }];
    }
}

- (void)getCachedStreetLevelCrimeForMonth:(int)month year:(int)year monthCount:(int)monthCount callback:(StreetLevelCrimeCallback)callback {
    self.currentData = [NSMutableArray array];
    self.monthCount = monthCount;
    self.currentMonth = month;
    self.currentYear = year;
    __weak typeof(self) weakSelf = self;
    
    __block StreetLevelCrimeCallback insideCallback = ^(NSArray *data) {
        [weakSelf.currentData addObjectsFromArray:data];
        weakSelf.monthCount--;
        if (weakSelf.monthCount > 0) {
            weakSelf.currentMonth--;
            if (weakSelf.currentMonth == 0) {
                weakSelf.currentMonth = 12;
                weakSelf.currentYear--;
            }
            [weakSelf getCachedStreetLevelCrimeForMonth:weakSelf.currentMonth year:weakSelf.currentYear callback:insideCallback];
        }
        else {
            callback(self.currentData);
        }
    };
    
    [self getCachedStreetLevelCrimeForMonth:month year:year callback:insideCallback];
    
}

- (NSArray *)loadCrimeArrayFromDiskForYear:(int)year month:(int)month {
    // look for saved data.
    NSString *filename = [[self class] getCrimeDataFilename:year month:month];
    NSArray *savedData = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filename]) {
        NSData *data = [NSData dataWithContentsOfFile:filename];
        savedData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return savedData;
}

- (void)saveCrimeArrayToDisk:(NSArray *)array forYear:(int)year month:(int)month {
    NSString *filename = [[self class] getCrimeDataFilename:year month:month];
    [NSKeyedArchiver archiveRootObject:array toFile:filename];
}

+ (NSString *)getCrimeDataFilename:(int)year month:(int)month {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:
                          [NSString stringWithFormat:@"crime-data-%04d-%02d", year, month]];
    return filePath;
}

@end
