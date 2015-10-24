//
//  SSCarParkManager.m
//  SafeSpace
//
//  Created by Rob Frampton on 24/10/2015.
//  Copyright © 2015 Team Moonflop. All rights reserved.
//

#import "SSCarParkManager.h"
#import <RestKit/RestKit.h>
#import "SSMappingProvider.h"
#import "SSCarPark.h"

@interface SSCarParkManager()

@property int currentPage;
@property (strong, nonatomic) NSMutableArray *currentData;

@end

@implementation SSCarParkManager

static float minLat = 53.398070;
static float maxLat = 53.545612;
static float minLon = -2.392273;
static float maxLon = -2.112122;

+ (RKObjectManager *)createObjectManager
{
    // initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"http://opendata.tfgm.com"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    return objectManager;
}

+ (RKObjectManager *)createCarParkObjectManager {
    RKObjectManager *objectManager = [[self class] createObjectManager];
    
    [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"text/json"];

    
    [objectManager.HTTPClient setDefaultHeader:@"DevKey" value:@"9338ecd0-34c5-476c-bceb-28bb10e9242a"];
    [objectManager.HTTPClient setDefaultHeader:@"AppKey" value:@"3bc49dee-5343-4093-ad1c-d4871feb587c"];
    [objectManager.HTTPClient setDefaultHeader:@"Content-Type" value:@"application/json"];
    
    // setup object mappings
    RKObjectMapping *carParkMapping = [SSMappingProvider carParkMapping];
    
    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:carParkMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/api/Carparks"
                                                keyPath:@""
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    [objectManager addResponseDescriptor:responseDescriptor];
    
    return objectManager;
}


- (void)requestPage:(int)page callback:(CarParkCallback)callback {
    RKObjectManager *objectManager = [[self class] createCarParkObjectManager];
    
    NSDictionary *queryParams = @{@"pageIndex" : [NSString stringWithFormat:@"%d", page],
                                  @"pageSize" : @"20"};
    
    [objectManager getObjectsAtPath:@"/api/Carparks"
                         parameters:queryParams
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                NSArray *carParkArray = [mappingResult array];
                                callback(carParkArray);
                            }
                            failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                NSLog(@"What do you mean by 'there is no coffee?': %@", error);
                            }];
}

- (void)getCachedCarParkDataForPage:(int)page callback:(CarParkCallback)callback {
    if (!callback) {
        NSLog(@"CALLBACK IS NIL");
    }
    
    NSLog(@"getCachedCarParkDataForPage:%d", page);
    /*
    __block NSArray *data = [self loadCrimeArrayFromDiskForYear:year month:month];
    if (data) {
        callback(data);
    }
     
    else {*/
    [self requestPage:page callback:^(NSArray *data) {
        //TODO save
        callback(data);
    }];
    //}
}


- (void)getCachedCarParkDataWithCallback:(CarParkCallback)callback {
    self.currentData = [NSMutableArray array];
    self.currentPage = 0;
    __weak typeof(self) weakSelf = self;
    
    __block CarParkCallback insideCallback = ^(NSArray *array) {
        [weakSelf.currentData addObjectsFromArray:array];
        weakSelf.currentPage++;
        if (array.count == 20) {
            [weakSelf getCachedCarParkDataForPage:weakSelf.currentPage callback:insideCallback];
        }
        else {
            NSMutableArray *newArray = [NSMutableArray array];
            for (SSCarPark* carPark in self.currentData) {
                if (carPark.latitude > minLat && carPark.latitude < maxLat &&
                    carPark.longitude > minLon && carPark.longitude < maxLon) {
                    [newArray addObject:carPark];
                }
            }
            callback(newArray);
        }
    };
    
    [self getCachedCarParkDataForPage:weakSelf.currentPage callback:insideCallback];
}





@end
