//
//  PuyoView.h
//  puyo
//
//  Created by Shuetsu Ito on 2013/12/24.
//  Copyright (c) 2013年 individual. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PuyoGame;

@interface PuyoView : UIView
@property (nonatomic, readonly)PuyoGame *game;
- (id)initWithFrame:(CGRect)frame game:(PuyoGame*)game;
@end
