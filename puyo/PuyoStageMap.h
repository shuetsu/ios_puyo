//
//  PuyoStage.h
//  puyo
//
//  Created by Shuetsu Ito on 2013/12/25.
//  Copyright (c) 2013年 individual. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PuyoPosition;

@interface PuyoStageMap : NSObject
- (id)initWithDefaultValue:(id)defalutValue;
- (id)get:(PuyoPosition*)rowCol;
- (void)put:(PuyoPosition*)rowCol value:(id)value;
@end
