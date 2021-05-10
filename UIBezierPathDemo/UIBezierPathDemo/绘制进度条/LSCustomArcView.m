//
//  LSCustomArcView.m
//  ConstructionVersion
//
//  Created by 李诗 on 2021/4/21.
//  Copyright © 2021 李诗. All rights reserved.
//

#import "LSCustomArcView.h"

#define DEGREES_TO_RADIANS(angle)           ((angle) / 180.0 * M_PI)

@interface LSCustomArcView()

@property (nonatomic, strong) UIBezierPath * basePath;
@property (nonatomic, strong) CAShapeLayer * shapeLayer;
@property (nonatomic, strong) UIBezierPath * progressPath;
@property (nonatomic, strong) CAShapeLayer * progressShapeLayer;
@property (nonatomic, strong) CAGradientLayer * gradientLayer;
@end

@implementation LSCustomArcView

-(void)LSCustomArcViewWithSuperViewStarAngle:(CGFloat)starAngle endAngle:(CGFloat)endAngle lineWidth:(int)lineWidth{
    
    //绘制底弧
    if (!self.basePath) {
        self.basePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.width/2) radius:(self.frame.size.width - lineWidth)/2 startAngle:DEGREES_TO_RADIANS(starAngle) endAngle:DEGREES_TO_RADIANS(endAngle) clockwise:YES];
    }
    if (!self.shapeLayer) {
        self.shapeLayer = [CAShapeLayer layer];
    }
   
    self.shapeLayer.path = self.basePath.CGPath;
    self.shapeLayer.lineWidth = lineWidth;
    self.shapeLayer.strokeColor = [UIColor grayColor].CGColor;//圆环颜色
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;//圆环底色
    self.shapeLayer.lineCap = kCALineCapRound;//设置线边缘为圆
    [self.layer addSublayer:self.shapeLayer];

    //绘制进度弧
    if (!self.progressPath) {
        self.progressPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.width/2) radius:(self.frame.size.width - lineWidth)/2 startAngle:DEGREES_TO_RADIANS(starAngle) endAngle:DEGREES_TO_RADIANS(endAngle) clockwise:YES];
    }
    if (!self.progressShapeLayer) {
        self.progressShapeLayer = [CAShapeLayer layer];
    }
    self.progressShapeLayer.path = self.progressPath.CGPath;
    self.progressShapeLayer.lineWidth = lineWidth;
    self.progressShapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.progressShapeLayer.strokeColor = [UIColor redColor].CGColor;
    self.progressShapeLayer.lineCap = kCALineCapRound;
    self.progressShapeLayer.strokeStart = 0;
    self.progressShapeLayer.strokeEnd = 0;

    //渐变色
    if (!self.gradientLayer) {
        self.gradientLayer = [CAGradientLayer layer];
    }
    self.gradientLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(1, 1);
    [self.gradientLayer setColors:@[(id)[UIColor redColor].CGColor,(id)[UIColor redColor].CGColor]];
    [self.layer addSublayer:self.gradientLayer];
    [self.gradientLayer setMask:self.progressShapeLayer];

}

-(void)setBaseColor:(UIColor *)baseColor{
    _baseColor = baseColor;
    _shapeLayer.strokeColor = baseColor.CGColor;
}
-(void)setColorsArray:(NSArray *)colorsArray{
    _colorsArray = colorsArray;
    [_gradientLayer setColors:colorsArray];
}
-(void)setProgress:(CGFloat)progress{
    _progressShapeLayer.strokeEnd = progress;
}

@end
