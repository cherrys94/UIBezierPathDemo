//
//  LSBubbleViewController2.m
//  UIBezierPathDemo
//
//  Created by 李诗 on 2021/4/27.
//  Copyright © 2021 李诗. All rights reserved.
//

#import "LSBubbleViewController2.h"
#import "LSBubbleView.h"

@interface LSBubbleViewController2 ()

@end

@implementation LSBubbleViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"冒泡泡动效2";
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //获取点击点，作为泡泡的起始点
    UITouch * currentTouch = [touches anyObject];
    CGPoint point = [currentTouch locationInView:currentTouch.view];
    LSBubbleView * bubbleView = [[LSBubbleView alloc] initWithSuperView:self.view withoOriginPoint:point];
    [self.view addSubview:bubbleView];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
