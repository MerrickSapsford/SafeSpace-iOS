//
//  SSDrawerViewController.m
//  SafeSpace
//
//  Created by Merrick Sapsford on 24/10/2015.
//  Copyright © 2015 Team Moonflop. All rights reserved.
//

#import "SSDrawerViewController.h"
#import "SSBaseRootViewController.h"

@interface SSDrawerViewController ()

@property (nonatomic, weak) IBOutlet MSSCollectionView *collectionView;

@property (nonatomic, weak) IBOutlet SSBaseView *contentViewContainer;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *drawerWidthConstraint;

@property (nonatomic, strong) SSBaseRootViewController *contentViewController;

@property (nonatomic, weak) id delegate;

@property (nonatomic, weak) id dataSource;

@end

@implementation SSDrawerViewController

#pragma mark - Lifecycle

- (void)setUpController {
    [super setUpController];
    [self setUpContentViewController];
}


- (void)setUpContentViewController {
    if (!_contentViewController && self.contentViewControllerId) {
        
        SSBaseRootViewController *contentViewController = (SSBaseRootViewController *)[self instantateViewControllerWithIdentifier:self.contentViewControllerId];
        
        // set up content controller
        self.delegate = contentViewController;
        self.dataSource = contentViewController;
        contentViewController.drawerController = self;
        
        self.contentViewController = contentViewController;
    }
}

#pragma mark - Public

- (void)show {
    [self showAnimated:YES];
}

- (void)showAnimated:(BOOL)animated {
    if (self.drawerVisible) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(drawerViewController:willMoveToState:)]) {
        [self.delegate drawerViewController:self willMoveToState:SSDrawerViewControllerStateDrawerVisible];
    }
    
    [UIView transitionWithView:self.view duration:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.contentViewContainer.transform = CGAffineTransformMakeTranslation(self.drawerWidth, 0.0f);
        self.contentViewContainer.alpha = 0.5f;
        self.contentViewContainer.userInteractionEnabled = NO;
        
        self.collectionView.transform = self.contentViewContainer.transform;
        self.collectionView.userInteractionEnabled = YES;
    } completion:^(BOOL finished) {
        if (finished) {
            _drawerVisible = YES;
            if ([self.delegate respondsToSelector:@selector(drawerViewController:didMoveToState:)]) {
                [self.delegate drawerViewController:self didMoveToState:SSDrawerViewControllerStateDrawerVisible];
            }
        }
    }];
}

- (void)hide {
    [self hideAnimated:YES];
}

- (void)hideAnimated:(BOOL)animated {
    if (!self.drawerVisible) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(drawerViewController:willMoveToState:)]) {
        [self.delegate drawerViewController:self willMoveToState:SSDrawerViewControllerStateDrawerHidden];
    }
    
    [UIView transitionWithView:self.view duration:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.contentViewContainer.transform = CGAffineTransformIdentity;
        self.contentViewContainer.alpha = 1.0f;
        self.contentViewContainer.userInteractionEnabled = YES;
        
        self.collectionView.transform = CGAffineTransformIdentity;
        self.collectionView.userInteractionEnabled = NO;
    } completion:^(BOOL finished) {
        if (finished) {
            _drawerVisible = NO;
            if ([self.delegate respondsToSelector:@selector(drawerViewController:didMoveToState:)]) {
                [self.delegate drawerViewController:self didMoveToState:SSDrawerViewControllerStateDrawerHidden];
            }
        }
    }];
}

#pragma mark - Interaction

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    if (self.drawerVisible) {
        CGPoint location = [[touches anyObject]locationInView:self.view];
        if (CGRectContainsPoint(self.contentViewContainer.frame, location)) {
            [self hide];
        }
    }
}

#pragma mark - Internal

- (void)setContentViewController:(SSBaseRootViewController *)contentViewController {
    _contentViewController = contentViewController;
    
    [self addChildViewController:_contentViewController];
    _contentViewController.view.frame = self.contentViewContainer.bounds;
    [self.contentViewContainer addSubview:_contentViewController.view];
    [_contentViewController didMoveToParentViewController:self];
}

- (CGFloat)drawerWidth {
    if (_drawerWidth == 0) {
        _drawerWidth = self.drawerWidthConstraint.constant;
    }
    return _drawerWidth;
}

@end
