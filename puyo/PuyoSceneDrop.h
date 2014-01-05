//
//  PuyoSceneDrop.h
//  puyo
//
//  Created by Shuetsu Ito on 2014/01/03.
//  Copyright (c) 2014年 individual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PuyoScene.h"
@class PuyoGame;

@interface PuyoSceneDrop : NSObject<PuyoScene>
- (id)initWithGame:(PuyoGame*)game chain:(int)chain;
@end
