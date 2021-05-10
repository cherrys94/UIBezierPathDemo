//
//  LSWaveView.m
//  UIBezierPathDemo
//
//  Created by 李诗 on 2021/4/30.
//  Copyright © 2021 李诗. All rights reserved.
//

#import "LSWaveView.h"
#import "UIColor+LSHex.h"

@interface LSWaveView()

@property (nonatomic, assign) CGFloat alpha;//振幅A
@property (nonatomic, assign) CGFloat omega;//角速度ω
@property (nonatomic, assign) CGFloat phi;//初相φ
@property (nonatomic, assign) CGFloat kappa;//偏距k
@property (nonatomic, assign) CGFloat speed;//速度

@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation LSWaveView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createCommon];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self createCommon];
}
-(void)createCommon{
    //设置默认值
    self.alpha = 5;
    self.omega = M_PI * 2 / self.bounds.size.width;
    self.phi = 0;
    self.kappa = self.bounds.size.height;
    self.speed = 2;
    //初始化 CADisplayLink
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplay)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    self.backgroundColor = [UIColor systemGray5Color];
}
- (void)drawRect:(CGRect)rect{
    /*
     想有几条波浪就创建几条曲线，
     更改kappa(k)是改变高度，
     更改omega(ω)是改变波浪往前偏移的位置，
     更改phi(φ)是改变速度，
     更改alpha(A)是改变波浪的幅度
     */
    [self drawWaveWithColor:[UIColor colorWithHexString:@"#108EE8" alpha:1] withOmega:self.omega withPhi:self.phi withKappa:self.kappa];
    [self drawWaveWithColor:[UIColor colorWithHexString:@"#108EE8" alpha:0.4] withOmega:self.omega * 1.5 withPhi:self.phi withKappa:self.kappa];
}
-(void)drawWaveWithColor:(UIColor *)color withOmega:(CGFloat)omega withPhi:(CGFloat)phi withKappa:(CGFloat)kappa{
    [color set];
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, self.bounds.size.height)];
    //正弦曲线公式为：y=Asin(ωx+φ)+k;
    for (CGFloat x = 0.0f; x <= self.bounds.size.width; x++) {
        CGFloat y = self.alpha * sinf(omega * x + phi) + kappa;
        [path addLineToPoint:CGPointMake(x, y)];
    }
    [path addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    [path fill];
}
//CGContextRef方法画图
//-(void)drawWave{
//    CGContextRef cxt = UIGraphicsGetCurrentContext();

//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathMoveToPoint(path, nil, 0, self.bounds.size.height);
//    //正弦曲线公式为：y=Asin(ωx+φ)+k;
//    for (CGFloat x = 0.0f; x <= self.bounds.size.width; x++) {
//        CGFloat y = self.alpha * sinf(self.omega * x + self.phi) + self.kappa;
//        CGPathAddLineToPoint(path, nil, x, y);
//    }
//    CGPathAddLineToPoint(path, nil, self.bounds.size.width, self.bounds.size.height);
//    CGPathCloseSubpath(path);

//    CGContextSetFillColorWithColor(cxt, [UIColor orangeColor].CGColor);
//    CGContextSetLineWidth(cxt, 0.5);
//    CGContextAddPath(cxt, path);
//    CGContextFillPath(cxt);
//    CGPathRelease(path);
//}
- (void)handleDisplay{
    if (!self.isHidden) {
        self.phi -= self.speed * self.omega;
        [self setNeedsDisplay];
    }
}

-(void)setProgress:(CGFloat)progress{
    
    _kappa = self.bounds.size.height * (1 - progress);
    if (self.progress == 1) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
    [self setNeedsDisplay];
    
}
@end
