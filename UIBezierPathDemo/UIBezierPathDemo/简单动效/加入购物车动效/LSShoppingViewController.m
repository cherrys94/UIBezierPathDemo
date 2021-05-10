//
//  LSShoppingViewController.m
//  UIBezierPathDemo
//
//  Created by 李诗 on 2021/4/29.
//  Copyright © 2021 李诗. All rights reserved.
//

#import "LSShoppingViewController.h"

@interface LSShoppingViewController ()<CAAnimationDelegate>

@property (weak, nonatomic) IBOutlet UIButton *goods;
- (IBAction)addAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *shoppingCart;


@end

@implementation LSShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"加入购物车";
}

- (IBAction)addAction:(id)sender {
    
    //绘制动画图层
    CAShapeLayer * layer = [CAShapeLayer layer];
    UIImage * goodsImage = [self changeToImage:self.goods];
    //如果传的不是CGImage，图层会是空白
    layer.contents = (__bridge id _Nullable)(goodsImage.CGImage);
    layer.frame = self.goods.frame;
    [self.view.layer addSublayer:layer];
 
    //创建运动轨迹
    CGPoint startPoint = self.goods.center;
    CGPoint endPoint = self.shoppingCart.center;
    CGPoint controlPoint = CGPointMake(startPoint.x + (endPoint.x - startPoint.x) / 2, startPoint.y - 150);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addQuadCurveToPoint:endPoint controlPoint:controlPoint];
    
    //创建路径动画
    CAKeyframeAnimation * pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.path = path.CGPath;
    
    //缩放动画
    CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];//开始时缩放倍数
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.25];//结束时缩放倍数
    
    //旋转动画
    CABasicAnimation * rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];//开始时的角度
    rotateAnimation.toValue = [NSNumber numberWithFloat:M_PI * 4];//结束时的角度
    
//    //透明度动画
//    CABasicAnimation * alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    alphaAnimation.fromValue = [NSNumber numberWithFloat:1.0];
//    alphaAnimation.toValue = [NSNumber numberWithFloat:0.1];
    
    //添加动画组
    CAAnimationGroup * group = [CAAnimationGroup animation];
    CGFloat durationTime = 2.0f;
    group.duration = durationTime;
    group.animations = @[pathAnimation, scaleAnimation, rotateAnimation];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
//    group.delegate = self;
    [layer addAnimation:group forKey:@"group"];
    
    //动画结束
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(durationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [layer removeAllAnimations];
        [layer removeFromSuperlayer];
        //购物车抖动
        CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        shakeAnimation.duration = 0.25f;
        shakeAnimation.fromValue = [NSNumber numberWithFloat:-5];
        shakeAnimation.toValue = [NSNumber numberWithFloat:5];
        shakeAnimation.autoreverses = YES;
        [self.shoppingCart.layer addAnimation:shakeAnimation forKey:@"shake"];
    });
}
//转换图片
- (UIImage *)changeToImage:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
//动画代理
//-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
//    if (flag == YES) {
//        NSLog(@"llll");
//    }
//}
@end
