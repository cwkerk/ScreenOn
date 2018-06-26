//
//  ARMenuViewController.h
//  ScreenOn
//
//  Created by Chin Wee Kerk on 26/6/18.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARMenuViewCell.h"
#import "ARMenuViewControllerDelegate.h"
#import "MenuItem.h"

@interface ARMenuViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (readonly, copy, nonatomic, nonnull) NSString *cellId;

@property (readonly, strong, nonatomic, nonnull) UICollectionView *collectionView;

@property (weak, nonatomic, nullable) id<ARMenuViewControllerDelegate>delegate;

@property (readonly, strong, nonatomic, nonnull) NSArray<MenuItem *> *menuItems;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
