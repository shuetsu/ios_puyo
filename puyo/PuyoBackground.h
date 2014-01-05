//
//  PuyoBackground.h
//  puyo
//
//  Created by Shuetsu Ito on 2013/12/24.
//  Copyright (c) 2013年 individual. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PuyoView;
@class PuyoGame;

@interface PuyoBackground : NSObject
@property (nonatomic, assign)float speed;
@property (nonatomic, assign)bool alert;
- (void)doFrame:(PuyoGame*)game;
- (void)draw:(PuyoView*)puyoView;
@end
