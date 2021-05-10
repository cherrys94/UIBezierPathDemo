//
//  LSSimpleUseViewController.m
//  UIBezierPathDemo
//
//  Created by 李诗 on 2021/4/8.
//  Copyright © 2021 李诗. All rights reserved.
//

#import "LSSimpleUseViewController.h"
#import "LSSimpleView.h"

@interface LSSimpleUseViewController ()

@end

@implementation LSSimpleUseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"简单使用";
    
    //在view中的drawRect方法中使用
    LSSimpleView * view = [[LSSimpleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    //直接在当前vc里面使用
    [self createRect];
}
//直接在当前vc里面使用
-(void)createRect{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(10, 700, 150, 100)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    UILabel * tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 820, 150, 20)];
    tipLabel.text = @"addSublayer";
    tipLabel.font = [UIFont systemFontOfSize:16.0f];
    tipLabel.textColor = [UIColor redColor];
    [self.view addSubview:tipLabel];
    //
    CGFloat h = view.frame.size.height;
    UIBezierPath * path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(0, h)];
    [path addLineToPoint:CGPointMake(0, h*0.7)];
    [path addQuadCurveToPoint:CGPointMake(h*0.7, 0) controlPoint:CGPointMake(h*0.05, h*0.05)];
    [path addLineToPoint:CGPointMake(h*0.95, 0)];
    [path appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(h*0.95, h*0.5) radius:h*0.5 startAngle:3*M_PI/2 endAngle:M_PI/2 clockwise:YES]];
    [path addLineToPoint:CGPointMake(0, h)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor yellowColor].CGColor;
    shapeLayer.fillColor = [UIColor blueColor].CGColor;
    shapeLayer.lineWidth = 3;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    //在view上绘制路径
    [view.layer addSublayer:shapeLayer];
    
    
    
    
    UIView * view2 = [[UIView alloc] initWithFrame:CGRectMake(200, 700, 150, 100)];
    view2.backgroundColor = [UIColor redColor];
    [self.view addSubview:view2];
    UILabel * tipLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(200, 820, 250, 20)];
    tipLabel2.text = @"view.layer.mask = shapeLayer";
    tipLabel2.font = [UIFont systemFontOfSize:16.0f];
    tipLabel2.textColor = [UIColor redColor];
    [self.view addSubview:tipLabel2];
    UIBezierPath * path2 = [UIBezierPath bezierPathWithCGPath:path.CGPath];
    [path2 stroke];
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.strokeColor = [UIColor yellowColor].CGColor;
    shapeLayer2.fillColor = [UIColor blueColor].CGColor;
    shapeLayer2.lineWidth = 3;
    shapeLayer2.lineJoin = kCALineJoinRound;
    shapeLayer2.lineCap = kCALineCapRound;
    shapeLayer2.path = path2.CGPath;
    //将view进行遮罩，即view显示出来的形状就是你绘制的形状
    view2.layer.mask = shapeLayer2;
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
