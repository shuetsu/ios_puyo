//
//  PuyoStage.m
//  puyo
//
//  Created by Shuetsu Ito on 2013/12/25.
//  Copyright (c) 2013年 individual. All rights reserved.
//

#import "PuyoStageMap.h"
#import "PuyoPosition.h"

@interface PuyoStageMap()
{
    id _defaultValue;
    NSMutableArray *_map;
}
@end

@implementation PuyoStageMap

-(id)initWithDefaultValue:(id)defalutValue
{
    self = [super init];
    if (self) {
        int count = STAGE_COLS * STAGE_ROWS;
        _defaultValue = defalutValue;
        _map = [NSMutableArray arrayWithCapacity:count];
        for(int i = 0;i < count;i++){
            [_map addObject:_defaultValue];
        }
    }
    return self;
}

- (id)get:(PuyoPosition *)rowCol
{
    if (rowCol.row < 0 || rowCol.row >= STAGE_ROWS ||
        rowCol.col < 0 || rowCol.col >= STAGE_COLS) {
        return _defaultValue;
    }
    return [_map objectAtIndex:rowCol.row * STAGE_COLS + rowCol.col];
}

- (void)put:(PuyoPosition *)rowCol value:(id)value
{
    if (rowCol.row < 0 || rowCol.row >= STAGE_ROWS ||
        rowCol.col < 0 || rowCol.col >= STAGE_COLS) {
        return;
    }
    [_map replaceObjectAtIndex:rowCol.row * STAGE_COLS + rowCol.col withObject:value];
}

@end
