//
//  PuyoRowCol.h
//  puyo
//
//  Created by Shuetsu Ito on 2013/12/25.
//  Copyright (c) 2013年 individual. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PuyoPosition : NSObject
@property (nonatomic, assign)int row;
@property (nonatomic, assign)int col;
- (PuyoPosition*)getAbove;
- (PuyoPosition*)getBelow;
- (PuyoPosition*)getLeft;
- (PuyoPosition*)getRight;
@end

PuyoPosition *PuyoPositionMake(int row, int col);