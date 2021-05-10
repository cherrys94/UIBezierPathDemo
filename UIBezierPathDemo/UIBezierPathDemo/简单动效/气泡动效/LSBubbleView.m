//
//  LSBubbleView.m
//  UIBezierPathDemo
//
//  Created by 李诗 on 2021/4/27.
//  Copyright © 2021 李诗. All rights reserved.
//

#import "LSBubbleView.h"
#import "UIColor+LSHex.h"

#define bubbleMinW        15
#define bubbleMaxW        40
@interface LSBubbleView()<CAAnimationDelegate>

@property (nonatomic) PathType pathType;
@property (nonatomic) CGFloat maxW;//路径最大宽
@property (nonatomic) CGFloat maxH;//路径最大高
@property (nonatomic) CGFloat bubbleW;//泡泡大小
@property (nonatomic) CGPoint originPoint;

@end

@implementation LSBubbleView

-(instancetype)initWithSuperView:(UIView *)superView withoOriginPoint:(CGPoint)originPoint{
    
    self = [[LSBubbleView alloc] init];
    if (self) {
        self.originPoint = originPoint;
        
        //获取路径宽高和泡泡大小随机值
        self.bubbleW = [self getRandomNumber:bubbleMinW to:bubbleMaxW];
        self.maxH = [self getRandomNumber:self.bubbleW to:self.originPoint.y - self.bubbleW];
        self.maxW = [self getRandomNumber:self.originPoint.x - self.bubbleW to:self.superview.frame.size.width - self.bubbleW];
        
        //创建泡泡
        self.backgroundColor = [UIColor colorWithHexString:@"#E61717"];
        self.frame = CGRectMake(self.originPoint.x - self.bubbleW / 2, self.originPoint.y - self.bubbleW / 2, self.bubbleW, self.bubbleW);
        self.clipsToBounds = YES;
        self.layer.cornerRadius = self.bubbleW / 2;
        //随机泡泡透明度
        self.alpha = [self getRandomNumber:0.1 to:0.6];
        
        //创建运动路径
        [self getRandomPathType];
        [self createBebierPath];
    }
    return self;
    
}
//绘制路径
-(void)createBebierPath{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:self.originPoint];
    if (self.pathType == pathLeft) {
    
        CGPoint leftControlPoint = CGPointMake(self.originPoint.x - self.maxW / 2, self.originPoint.y - self.maxH / 4);
        CGPoint rightControlPoint = CGPointMake(self.originPoint.x + self.maxW / 2, self.originPoint.y - self.maxH * 3 / 4);
        CGPoint endPoint = CGPointMake(self.originPoint.x, self.originPoint.y - self.maxH);
    
        [path addCurveToPoint:endPoint controlPoint1:leftControlPoint controlPoint2:rightControlPoint];
    
    }else{
        CGPoint leftControlPoint = CGPointMake(self.originPoint.x - self.maxW / 2, self.originPoint.y - self.maxH * 3 / 4);
        CGPoint rightControlPoint = CGPointMake(self.originPoint.x + self.maxW / 2, self.originPoint.y - self.maxH / 4);
        CGPoint endPoint = CGPointMake(self.originPoint.x, self.originPoint.y - self.maxH);
    
        [path addCurveToPoint:endPoint controlPoint1:leftControlPoint controlPoint2:rightControlPoint];
    }
    
    //帧动画
    CAKeyframeAnimation * keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [keyFrameAnimation setDuration:2.0f];
    keyFrameAnimation.path = path.CGPath;
    //设置为NO，则在动画结束后停在终点，YES则会回到原点
    keyFrameAnimation.removedOnCompletion = NO;
    keyFrameAnimation.fillMode = kCAFillModeForwards;
    keyFrameAnimation.delegate = self;
   

}

//动画代理
//在动画结束的时候，做一个泡泡炸开的效果
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [UIView transitionWithView:self duration:0.1f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            //0.1s内泡泡放大1.3倍，即炸开效果
            self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        } completion:^(BOOL finished) {
            if (finished) {
                //当前动画完成后，移除当前动画，即炸开后消失，随即又生成一个新的，来达到循环的效果
                [self.layer removeAllAnimations];
                LSBubbleView * bubbleView = [[LSBubbleView alloc] initWithSuperView:self.superview withoOriginPoint:self.originPoint];
                [self.superview addSubview:bubbleView];
                [self removeFromSuperview];
                
            }
        }];
    }];
    [CATransaction commit];
}

-(CGFloat)getRandomNumber:(CGFloat)from to:(CGFloat)to{
    //设置精确的位数
    int precision = 100;
    float subtraction = to - from;
    //ABS整数绝对值
    subtraction = ABS(subtraction);
    //乘以精度的位数
    subtraction *= precision;
    //在差值间随机
    float randomNumber = arc4random() % ((int)subtraction+1);
    //随机的结果除以精度的位数
    randomNumber /= precision;
    //将随机的值加到较小的值上
    float result = MIN(from, to) + randomNumber;
    return result;
}

//获取随机路径类型 -- 先往左还是先往右
-(void)getRandomPathType{
    if (arc4random() % 2 == 0) {
        self.pathType = pathLeft;
    }else{
        self.pathType = pathRight;
    }
}


@end
