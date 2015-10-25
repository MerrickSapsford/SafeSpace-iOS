//
//  SSDrawerViewController.m
//  SafeSpace
//
//  Created by Merrick Sapsford on 24/10/2015.
//  Copyright © 2015 Team Moonflop. All rights reserved.
//

#import "SSDrawerViewController.h"
#import "SSBaseRootViewController.h"
#import "SSDrawerCollectionViewCell.h"
#import "SSDrawerHeaderView.h"

CGFloat const kSSDrawerViewControllerCollectionViewTopInset = 100.0f;

@interface SSDrawerViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet MSSCollectionView *collectionView;

@property (nonatomic, weak) IBOutlet SSBaseView *contentViewContainer;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *drawerWidthConstraint;

@property (nonatomic, strong) SSBaseRootViewController *contentViewController;

@property (nonatomic, weak) id delegate;

@property (nonatomic, weak) id dataSource;

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, assign) BOOL isSectioned;

@end

@implementation SSDrawerViewController

#pragma mark - Lifecycle

- (void)setUpController {
    [super setUpController];
    
    _dismissesOnSelection = YES;
    
    [self setUpContentViewController];
    [self setUpCollectionView];
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

- (void)setUpCollectionView {
    if (self.dataSource) {
        NSArray *items = [self.dataSource drawerItemsForDrawerViewController:self];
        if ([items.firstObject isKindOfClass:[SSDrawerSection class]]) {
            _isSectioned = YES;
        }
        if (items) {
            self.items = items;
            [self.collectionView reloadData];
        }
        
        if (self.isSectioned) {
            for (SSDrawerSection *section in self.items) {
                SSDrawerItem *item = [self.dataSource drawerViewController:self selectedItemForSection:section];
                if (item) {
                    [self selectItemsWithKeys:@[item.key]];
                }
            }
        }
    }
}

- (void)setControllerAppearance {
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.backgroundView = nil;
    
    self.collectionView.contentInset = UIEdgeInsetsMake(kSSDrawerViewControllerCollectionViewTopInset, 0, 0, 0);
}

#pragma mark - Collection View

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (self.isSectioned) {
        return self.items.count;
    }
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.isSectioned) {
        return ((SSDrawerSection *)[self.items objectAtIndex:section]).items.count;
    }
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SSDrawerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"drawerCell" forIndexPath:indexPath];
    
    SSDrawerItem *item;
    if (self.isSectioned) {
        item = [((SSDrawerSection *)[self.items objectAtIndex:indexPath.section]).items objectAtIndex:indexPath.row];
    } else {
        item = [self.items objectAtIndex:indexPath.row];
    }
    
    if (item) {
        cell.textLabel.text = item.title;
        cell.imageView.image = item.image;
        cell.userInteractionEnabled = item.selectable;
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:22.0f weight:cell.isSelected ? UIFontWeightRegular : UIFontWeightLight];
    cell.alpha = cell.isSelected ? 1.0f : 0.85f;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SSDrawerCollectionViewCell *cell = (SSDrawerCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    SSDrawerItem *item;
    if (self.isSectioned) {
        item = [((SSDrawerSection *)[self.items objectAtIndex:indexPath.section]).items objectAtIndex:indexPath.row];
    } else {
        item = [self.items objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:22.0f weight:cell.isSelected ? UIFontWeightRegular : UIFontWeightLight];
    cell.alpha = cell.isSelected ? 1.0f : 0.85f;
    
    if ([self.delegate respondsToSelector:@selector(drawerViewController:didSelectDrawerItem:)]) {
        [self.delegate drawerViewController:self didSelectDrawerItem:[((SSDrawerSection *)[self.items objectAtIndex:indexPath.section]).items objectAtIndex:indexPath.row]];
    }
    if (self.dismissesOnSelection) {
        [self hide];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    SSDrawerCollectionViewCell *cell = (SSDrawerCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    cell.textLabel.font = [UIFont systemFontOfSize:22.0f weight:cell.isSelected ? UIFontWeightRegular : UIFontWeightLight];
    cell.alpha = cell.isSelected ? 1.0f : 0.85f;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0.0f, 40.0f);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView;
    if (kind == UICollectionElementKindSectionHeader) {
        
        SSDrawerHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                            withReuseIdentifier:@"drawerHeader"
                                                                                   forIndexPath:indexPath];
        SSDrawerSection *section = [self.items objectAtIndex:indexPath.section];
        if (section) {
            headerView.textLabel.text = [section.title uppercaseString];
        }
        reusableView = headerView;
    }
    return reusableView;
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

- (void)selectItemsWithKeys:(NSArray *)keys {
    if (self.isSectioned) {
        for (int section = 0; section < self.items.count; section++) {
            SSDrawerSection *sectionItem = [self.items objectAtIndex:section];
            for (int row = 0; row < sectionItem.items.count; row++) {
                SSDrawerItem *rowItem = [sectionItem.items objectAtIndex:row];
                for (NSString *key in keys) {
                    if ([key isEqualToString:rowItem.key]) {
                        [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:row inSection:section]
                                                          animated:YES
                                                    scrollPosition:UICollectionViewScrollPositionNone];
                    }
                }
            }
        }
    }
}

- (void)deselectItemsWithKeys:(NSArray *)keys {
    if (self.isSectioned) {
        for (int section = 0; section < self.items.count; section++) {
            SSDrawerSection *sectionItem = [self.items objectAtIndex:section];
            for (int row = 0; row < sectionItem.items.count; row++) {
                SSDrawerItem *rowItem = [sectionItem.items objectAtIndex:row];
                for (NSString *key in keys) {
                    if ([key isEqualToString:rowItem.key]) {
                        [self.collectionView deselectItemAtIndexPath:[NSIndexPath indexPathForItem:row inSection:section]
                                                          animated:YES];
                    }
                }
            }
        }
    }
}

- (void)reloadData {
    [self setUpCollectionView];
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
