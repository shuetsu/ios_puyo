//
//  PuyoRowCol.m
//  puyo
//
//  Created by Shuetsu Ito on 2013/12/25.
//  Copyright (c) 2013年 individual. All rights reserved.
//

#import "PuyoPosition.h"

@implementation PuyoPosition

- (PuyoPosition *)getAbove
{
    return PuyoPositionMake(_row - 1, _col);
}

- (PuyoPosition *)getBelow
{
    return PuyoPositionMake(_row + 1, _col);
}

- (PuyoPosition *)getLeft
{
    return PuyoPositionMake(_row, _col - 1);
}

-(PuyoPosition *)getRight
{
    return PuyoPositionMake(_row, _col + 1);
}

@end

PuyoPosition *PuyoPositionMake(int row, int col)
{
    PuyoPosition *pos = [[PuyoPosition alloc] init];
    pos.row = row;
    pos.col = col;
    return pos;
}