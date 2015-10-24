//
//  MSSCollectionViewController.h
//  MSSCollectionViewExample
//
//  Created by Merrick Sapsford on 04/10/2015.
//  Copyright © 2015 Merrick Sapsford. All rights reserved.
//

#import "MSSCollectionView.h"

@interface MSSCollectionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

- (MSSCollectionViewCell *)collectionView:(MSSCollectionView *)collectionView
             createCellForItemAtIndexPath:(NSIndexPath *)indexPath;

- (void)collectionView:(MSSCollectionView *)collectionView
         configureCell:(MSSCollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath;

- (void)collectionView:(MSSCollectionView *)collectionView
      populateCellView:(MSSCellView *)cellView
    forItemAtIndexPath:(NSIndexPath *)indexPath;

- (Class)cellViewType;

- (NSInteger)numberOfColumns;

- (NSString *)cellReuseIdentifier;

@end
