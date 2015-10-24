//
//  ViewController.m
//  SafeSpace
//
//  Created by Merrick Sapsford on 23/10/2015.
//  Copyright © 2015 Team Moonflop. All rights reserved.
//

#import "SSBaseViewController.h"

@interface SSBaseViewController ()

@end

@implementation SSBaseViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initController];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initController];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self initController];
    }
    return self;
}

- (void)initController {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpController];
    [self setControllerAppearance];
}

- (void)setUpController {
    
}

- (void)setControllerAppearance {
    
}

- (NSString *)storyboardId {
    return NSStringFromClass([self class]);
}

@end
