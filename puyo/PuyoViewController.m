//
//  PuyoViewController.m
//  puyo
//
//  Created by Shuetsu Ito on 2013/12/24.
//  Copyright (c) 2013年 individual. All rights reserved.
//

#import "PuyoViewController.h"
#import "PuyoGestureRecognizer.h"
#import "PuyoGame.h"
#import "PuyoView.h"

@interface PuyoViewController ()
{
    PuyoGame *_game;
    PuyoView *_puyoView;
}
@end

@implementation PuyoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect r = self.view.bounds;
    _game = [[PuyoGame alloc] init];
    _puyoView = [[PuyoView alloc]
                 initWithFrame:CGRectMake(0,
                                          20,
                                          r.size.width,
                                          r.size.height - 20)
                 game:_game];
    [self.view addSubview:_puyoView];
    
    [NSTimer scheduledTimerWithTimeInterval:0.0167f
                                     target:self
                                   selector:@selector(doFrame:)
                                   userInfo:NULL
                                    repeats:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_game.gestureRecognizer touchesBegan:touches view:_puyoView];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_game.gestureRecognizer touchesMoved:touches view:_puyoView];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_game.gestureRecognizer touchesEnded:touches view:_puyoView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)doFrame:(NSTimer*)timer
{
    [_game doFrame];
    [_puyoView setNeedsDisplay];
}

@end
