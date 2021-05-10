//
//  LSBubbleViewController.m
//  UIBezierPathDemo
//
//  Created by 李诗 on 2021/4/26.
//  Copyright © 2021 李诗. All rights reserved.
//

#import "LSBubbleViewController.h"
#import "UIColor+LSHex.h"

@interface LSBubbleViewController ()<CAAnimationDelegate>

@end

@implementation LSBubbleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"冒泡泡动效";
    
    UILabel * bubbleView = [[UILabel alloc] initWithFrame:CGRectMake(100, 400, 50, 50)];
    bubbleView.text = @"2";
    bubbleView.textColor = [UIColor blueColor];
    bubbleView.backgroundColor = [UIColor colorWithHexString:@"#E61717" alpha:0.4];
    bubbleView.clipsToBounds = YES;
    bubbleView.layer.cornerRadius = 25;
    [self.view addSubview:bubbleView];
    
    //创建运动轨迹
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(125, 425)];
    [path addCurveToPoint:CGPointMake(50, 150) controlPoint1:CGPointMake(30, 300) controlPoint2:CGPointMake(175, 195)];
    [path stroke];
    CAShapeLayer * layer = [[CAShapeLayer alloc] init];
    layer.path = path.CGPath;
    layer.strokeColor = [UIColor blueColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth = 3;
    [self.view.layer addSublayer:layer];
   
    //帧动画
    CAKeyframeAnimation * keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [keyFrameAnimation setDuration:10];
    keyFrameAnimation.path = path.CGPath;
    //设置为NO，则在动画结束后停在终点，YES则会回到原点
    keyFrameAnimation.removedOnCompletion = YES;
    keyFrameAnimation.fillMode = kCAFillModeForwards;
    //重复次数
    keyFrameAnimation.repeatCount = MAXFLOAT;
    [bubbleView.layer addAnimation:keyFrameAnimation forKey:@"movingAnimation"];
    
    /*rotationMode:
     kCAAnimationRotateAuto：沿切线自动旋转
     kCAAnimationRotateAutoReverse：翻转180°后沿切线自动旋转运动。
     */
//    keyFrameAnimation.rotationMode = kCAAnimationRotateAuto;
    
/*
    //value方式实现帧动画
    NSValue * p1 = [NSValue valueWithCGPoint:CGPointMake(50, 120)];
    NSValue * p2 = [NSValue valueWithCGPoint:CGPointMake(50, 200)];
    NSValue * p3 = [NSValue valueWithCGPoint:CGPointMake(150, 150)];
    keyFrameAnimation.values = @[p1, p2, p3];
    keyFrameAnimation.keyTimes = @[@(0.1),@(0.8),@(1)];
    keyFrameAnimation.autoreverses = YES;
    [bubbleView.layer addAnimation:keyFrameAnimation forKey:@"movingAnimation"];
*/
    
    
    
//   //停止动画
//    if ([bubbleView.layer animationForKey:@"movingAnimation"]) {//如果动画进行中
//        [bubbleView.layer removeAnimationForKey:@"movingAnimation"];
//    }
//  //动画代理
//    keyFrameAnimation.delegate = self;
}


//动画代理
////动画结束
//-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
//    
//}
////动画开始
//-(void)animationDidStart:(CAAnimation *)anim{
//    
//}

@end
