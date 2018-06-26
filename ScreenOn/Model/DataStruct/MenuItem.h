//
//  MenuItem.h
//  ScreenOn
//
//  Created by Chin Wee Kerk on 26/6/18.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ VoidHandler)(void);

@interface MenuItem : NSObject

@property (strong, nonatomic, nonnull) NSString *imageName;

@property (strong, nonatomic, nonnull) VoidHandler onSelectHandler;

@end
