//
//  ARViewControllerDelegate.h
//  ScreenOn
//
//  Created by Kerk Chin Wee on 26/6/18.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuItem.h"

@protocol ARMenuViewControllerDelegate <NSObject>

- (NSArray<MenuItem *> * _Nonnull)getMenuItems;

@end
