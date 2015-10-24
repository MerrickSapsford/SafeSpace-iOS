//
//  MSSCollectionViewController.m
//  MSSCollectionViewExample
//
//  Created by Merrick Sapsford on 04/10/2015.
//  Copyright © 2015 Merrick Sapsford. All rights reserved.
//

#import "MSSCollectionViewController.h"

@interface MSSCollectionViewController ()

@property (nonatomic, strong) MSSCellView *sizingCellView;

@end

@implementation MSSCollectionViewController

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(MSSCollectionView *)collectionView {
    return 0;
}


- (NSInteger)collectionView:(MSSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(MSSCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MSSCollectionViewCell *cell = [self collectionView:collectionView createCellForItemAtIndexPath:indexPath];
    [self collectionView:collectionView configureCell:cell forItemAtIndexPath:indexPath];
    [self collectionView:collectionView populateCellView:cell.cellView forItemAtIndexPath:indexPath];
    
    return cell;
}

- (MSSCollectionViewCell *)collectionView:(MSSCollectionView *)collectionView
             createCellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.cellReuseIdentifier) {
        return [collectionView dequeueReusableCellWithReuseIdentifier:self.cellReuseIdentifier forIndexPath:indexPath];
    }
    NSAssert(NO, @"MSSCollectionViewController subclass must implement createCellForItemAtIndexPath");
    return nil;
}

- (void)collectionView:(MSSCollectionView *)collectionView
         configureCell:(MSSCollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)collectionView:(MSSCollectionView *)collectionView
      populateCellView:(MSSCellView *)cellView
    forItemAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(MSSCollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self collectionView:collectionView
        populateCellView:self.sizingCellView
      forItemAtIndexPath:indexPath];
    
    return [self.sizingCellView systemLayoutSizeFittingSize:CGSizeMake(self.columnWidth, self.collectionView.bounds.size.height)
                              withHorizontalFittingPriority:UILayoutPriorityRequired
                                    verticalFittingPriority:UILayoutPriorityDefaultLow];
}

#pragma mark - Internal

- (MSSCellView *)sizingCellView {
    if (!_sizingCellView) {
        _sizingCellView = [self.cellViewType new];
    }
    return _sizingCellView;
}

- (Class)cellViewType {
    NSAssert(NO, @"MSSCollectionViewController subclass must return a cellViewType");
    return nil;
}

- (NSInteger)numberOfColumns {
    return 1;
}

- (NSString *)cellReuseIdentifier {
    return nil;
}

- (CGFloat)columnWidth {
    NSInteger numberOfColumns = self.numberOfColumns;
    
    id layout = self.collectionView.collectionViewLayout;
    CGFloat totalInsets = [layout sectionInset].left + [layout sectionInset].right;
    CGFloat totalSpacing = [layout minimumInteritemSpacing] * (numberOfColumns - 1);
    CGFloat totalWidth = self.collectionView.bounds.size.width - totalInsets - totalSpacing;
    
    return totalWidth / numberOfColumns;
}

@end
