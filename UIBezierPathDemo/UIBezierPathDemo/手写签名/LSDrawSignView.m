//
//  LSDrawSignView.m
//  UIBezierPathDemo
//
//  Created by 李诗 on 2021/4/9.
//  Copyright © 2021 李诗. All rights reserved.
//

#import "LSDrawSignView.h"
@interface LSDrawSignView ()
{
    CGPoint previousPoint;
}

@property (nonatomic, strong) UIBezierPath * path;
@property (nonatomic, strong) NSMutableArray * pathArray;

@end

@implementation LSDrawSignView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createDrawView];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self createDrawView];
}

-(NSMutableArray *)pathArray{
    if (!_pathArray) {
        _pathArray = [NSMutableArray array];
    }
    return _pathArray;
}

-(void)setLineWidth:(CGFloat)lineWidth{
    _lineWidth = lineWidth;
}

-(void)setPathColor:(UIColor *)pathColor{
    _pathColor = pathColor;
}

-(void)createDrawView{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    
    //设置默认线宽和颜色
    self.pathColor = [UIColor redColor];
    self.lineWidth = 3;
}

//这个方法画出来的图，仔细看线段会有细小的锯齿状，略显生硬，如果要求不高，可以直接使用这个方法
//-(void)pan:(UIPanGestureRecognizer *)pan{
//    //获取当前点
//    CGPoint currentPoint = [pan locationInView:self];
//    if (pan.state == UIGestureRecognizerStateBegan) {
//        //创建贝塞尔路径
//        self.path = [UIBezierPath bezierPath];
//        self.path.lineWidth = self.lineWidth;
//        //设置路径的起点
//         [self.path moveToPoint:currentPoint];
//        //保存画出的路径
//        [self.pathArray addObject:self.path];
//    }
//    if (pan.state == UIGestureRecognizerStateChanged) {
//        //连接线到当前触摸点
//        [self.path addLineToPoint:currentPoint];
//    }
//    //重绘
//    [self setNeedsDisplay];
//}

//这个方法，是用二阶贝塞尔曲线来绘制圆滑的路径
-(void)pan:(UIPanGestureRecognizer *)pan{
    //获取当前点
    CGPoint currentPoint = [pan locationInView:self];
    CGPoint midPoint = [self getMidPoint:previousPoint withP2:currentPoint];
    if (pan.state == UIGestureRecognizerStateBegan) {
        //创建贝塞尔路径
        self.path = [UIBezierPath bezierPath];
        self.path.lineWidth = self.lineWidth;
        //设置路径的起点
         [self.path moveToPoint:currentPoint];
        //保存画出的路径
        [self.pathArray addObject:self.path];
    }
    if (pan.state == UIGestureRecognizerStateChanged) {
        //圆滑曲线连接到当前触摸点
        [self.path addQuadCurveToPoint:midPoint controlPoint:previousPoint];
    }
    previousPoint = currentPoint;
    //重绘
    [self setNeedsDisplay];

}

-(CGPoint)getMidPoint:(CGPoint)p1 withP2:(CGPoint)p2{
    
    return CGPointMake((p1.x + p2.x)/2, (p1.y + p2.y)/2);
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    for (UIBezierPath * path in self.pathArray) {
        [self.pathColor set];
        [path stroke];
    }
    if (self.block) {
        BOOL hasPath = self.pathArray.count == 0 ? NO : YES;
        self.block(hasPath);
    }
}

//清除绘画内容
-(void)cleanContent{
    [self.pathArray removeAllObjects];
    [self setNeedsDisplay];
}

//撤销
- (void)revoke{
    [self.pathArray removeLastObject];
    [self setNeedsDisplay];
}

@end
