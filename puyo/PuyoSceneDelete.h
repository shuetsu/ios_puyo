//
//  PuyoSceneDelete.h
//  puyo
//
//  Created by Shuetsu Ito on 2014/01/05.
//  Copyright (c) 2014年 individual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PuyoScene.h"
@class PuyoGame;

@interface PuyoSceneDelete : NSObject<PuyoScene>
- (id)initWithChain:(int)chain;
@end
