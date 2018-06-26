//
//  ARMenuViewController.m
//  ScreenOn
//
//  Created by Chin Wee Kerk on 26/6/18.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import "ARMenuViewController.h"

@interface ARMenuViewController ()

@end

@implementation ARMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.scrollView setContentSize:CGSizeMake(1000, 84)];
    self->_cellId = @"menuItem";
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self->_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 1000, 84) collectionViewLayout:layout];
    [self.collectionView setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ARMenuViewCell" bundle:nil] forCellWithReuseIdentifier:self.cellId];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    [self.scrollView addSubview:self.collectionView];
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(getMenuItems)]) {
        self->_menuItems = [self.delegate getMenuItems];
    }
}

#pragma section level config

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

#pragma cell level config

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.menuItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ARMenuViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellId forIndexPath:indexPath];
    [cell.menuIcon setImage:[UIImage imageNamed:self.menuItems[indexPath.row].imageName]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.menuItems[indexPath.row].onSelectHandler();
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(64, 64);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

@end
