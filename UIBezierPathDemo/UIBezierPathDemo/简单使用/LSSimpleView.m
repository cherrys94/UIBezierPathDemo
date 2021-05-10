//
//  LSSimpleView.m
//  UIBezierPathDemo
//
//  Created by 李诗 on 2021/4/8.
//  Copyright © 2021 李诗. All rights reserved.
//

#import "LSSimpleView.h"

@implementation LSSimpleView

-(void)drawRect:(CGRect)rect{
    //设置颜色
    UIColor * lineColor = [UIColor redColor];
    [lineColor set];
    UIColor * fillColor = [UIColor yellowColor];
    [fillColor setFill];
    
    //绘制矩形
    [self creatPath1];
    //绘制圆或椭圆
    [self creatPath2];
    //绘制圆角矩形和自定义某个角为圆角
    [self creatPath3];
    //画圆和扇形
    [self creatPath4];
    //画虚线
    [self creatPath5];
    //二价曲线
    [self creatPath6];
    //三阶曲线
    [self creatPath7];
    //四阶曲线
    [self creatPath8];
}
#pragma mark --- 绘制矩形
-(void)creatPath1{
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:CGRectMake(10, 100, 50, 50)];
    path.lineWidth = 3;
    //结束画图
    //会填充内部颜色
//    [path fill];
    [path stroke];
}
#pragma mark --- 绘制圆或椭圆
-(void)creatPath2{
    
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(70, 100, 50, 50)];
    path.lineWidth = 3;
    [path fill];
    
}
#pragma mark --- 绘制圆角矩形
-(void)creatPath3{
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(130, 100, 100, 50) cornerRadius:50];
    UIColor * lineColor = [UIColor blueColor];
    [lineColor setStroke];
    [path fillWithBlendMode:kCGBlendModeMultiply alpha:0.2];
    [path stroke];
    
    //设置指定角是否为圆角
    UIBezierPath * path2 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(240, 100, 100, 50) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(25, 25)];
    [path2 stroke];
}
#pragma mark --- 画圆和扇形
-(void)creatPath4{
    [[UIColor redColor] set];
    //顺时针画实心圆
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(40, 200) radius:25 startAngle:M_PI endAngle:M_PI_4 clockwise:YES];
    [path fill];
    
    //顺时针画空心弧线
    UIBezierPath * path2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(110, 200) radius:25 startAngle:M_PI endAngle:M_PI*3/2 clockwise:YES];
    [path2 stroke];
    
    //逆时针画实心圆
    UIBezierPath * path3 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(160, 200) radius:25 startAngle:M_PI*2/3 endAngle:M_PI clockwise:NO];
    [path3 fill];
    
    //逆时针画空心圆
    UIBezierPath * path4 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(220, 200) radius:25 startAngle:M_PI*2/3 endAngle:M_PI_4 clockwise:NO];
    [path4 stroke];
    
    
    //绘制实心扇形
    UIBezierPath * path5 = [UIBezierPath bezierPath];
    [path5 moveToPoint:CGPointMake(290, 200)];
    [path5 addArcWithCenter:CGPointMake(290, 200) radius:25 startAngle:M_PI endAngle:M_PI_4 clockwise:YES];
    [path5 fill];
    
    //绘制空心扇形
    UIBezierPath * path6 = [UIBezierPath bezierPath];
    [path6 moveToPoint:CGPointMake(360, 200)];
    [path6 addArcWithCenter:CGPointMake(360, 200) radius:25 startAngle:M_PI endAngle:M_PI_4 clockwise:YES];
    [path6 closePath];
    [path6 stroke];
}

#pragma mark --- 画虚线
-(void)creatPath5{
    //多段间隔虚线
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(10, 260)];
    [path addLineToPoint:CGPointMake(310, 260)];
    CGFloat dash[] = {10.0,2.0,5.0};
    [path setLineDash:dash count:3 phase:0.0];
    [path stroke];
    [path fill];
    
    //虚线和间隔长度相同
    UIBezierPath * path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(10, 270)];
    [path2 addLineToPoint:CGPointMake(310, 270)];
    CGFloat dash2[] = {5.0,5.0};
    [path2 setLineDash:dash2 count:2 phase:0.0];
    [path2 stroke];
    [path2 fill];
    
    //虚线圆
    UIBezierPath * path3 = [UIBezierPath bezierPath];
    [path3 addArcWithCenter:CGPointMake(350, 270) radius:25 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    CGFloat dash3[] = {5.0,5.0};
    [path3 setLineDash:dash3 count:2 phase:0.0];
    [path3 stroke];
}

#pragma mark --- 二阶曲线
-(void)creatPath6{
    
    UIView * controlPoint = [[UIView alloc] initWithFrame:CGRectMake(150, 300, 5, 5)];
    controlPoint.backgroundColor = [UIColor redColor];
    [self addSubview:controlPoint];
    UILabel * tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 295, 200, 15)];
    tipLabel.text = @"这就是控制点的位置";
    tipLabel.font = [UIFont systemFontOfSize:16.0f];
    tipLabel.textColor = [UIColor redColor];
    [self addSubview:tipLabel];
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, 350)];
    [path addQuadCurveToPoint:CGPointMake(200, 350) controlPoint:CGPointMake(150, 300)];
    [path stroke];
    
}

#pragma mark --- 三阶曲线
-(void)creatPath7{
    
    UIView * controlPoint1 = [[UIView alloc] initWithFrame:CGRectMake(40, 400, 5, 5)];
    controlPoint1.backgroundColor = [UIColor redColor];
    [self addSubview:controlPoint1];
    UILabel * tipLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(50, 390, 50, 20)];
    tipLabel1.text = @"p1";
    tipLabel1.font = [UIFont systemFontOfSize:16.0f];
    tipLabel1.textColor = [UIColor redColor];
    [self addSubview:tipLabel1];
    
    UIView * controlPoint2 = [[UIView alloc] initWithFrame:CGRectMake(150, 500, 5, 5)];
    controlPoint2.backgroundColor = [UIColor redColor];
    [self addSubview:controlPoint2];
    UILabel * tipLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(155, 490, 50, 20)];
    tipLabel2.text = @"p2";
    tipLabel2.font = [UIFont systemFontOfSize:16.0f];
    tipLabel2.textColor = [UIColor redColor];
    [self addSubview:tipLabel2];
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, 450)];
    [path addCurveToPoint:CGPointMake(200, 450) controlPoint1:CGPointMake(40, 400) controlPoint2:CGPointMake(150, 500)];
    [path stroke];
    
}

#pragma mark --- 四阶曲线
-(void)creatPath8{
    
    UIView * controlPoint1 = [[UIView alloc] initWithFrame:CGRectMake(40, 600, 5, 5)];
    controlPoint1.backgroundColor = [UIColor redColor];
    [self addSubview:controlPoint1];
    UILabel * tipLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(50, 590, 50, 20)];
    tipLabel1.text = @"p1";
    tipLabel1.font = [UIFont systemFontOfSize:16.0f];
    tipLabel1.textColor = [UIColor redColor];
    [self addSubview:tipLabel1];
    
    UIView * controlPoint2 = [[UIView alloc] initWithFrame:CGRectMake(90, 670, 5, 5)];
    controlPoint2.backgroundColor = [UIColor redColor];
    [self addSubview:controlPoint2];
    UILabel * tipLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(105, 660, 50, 20)];
    tipLabel2.text = @"p2";
    tipLabel2.font = [UIFont systemFontOfSize:16.0f];
    tipLabel2.textColor = [UIColor redColor];
    [self addSubview:tipLabel2];
    
    UIView * controlPoint3 = [[UIView alloc] initWithFrame:CGRectMake(230, 600, 5, 5)];
    controlPoint3.backgroundColor = [UIColor redColor];
    [self addSubview:controlPoint3];
    UILabel * tipLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(240, 590, 50, 20)];
    tipLabel3.text = @"p3";
    tipLabel3.font = [UIFont systemFontOfSize:16.0f];
    tipLabel3.textColor = [UIColor redColor];
    [self addSubview:tipLabel3];
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, 650)];
    [path addCurveToPoint:CGPointMake(150, 650) controlPoint1:CGPointMake(40, 600) controlPoint2:CGPointMake(90, 670)];
    [path addQuadCurveToPoint:CGPointMake(250, 650) controlPoint:CGPointMake(230, 600)];
    [path stroke];
}

@end
