//
//  LSBadgeView.m
//  UIBezierPathDemo
//
//  Created by 李诗 on 2021/5/7.
//  Copyright © 2021 李诗. All rights reserved.
//

#import "LSBadgeView.h"

@interface LSBadgeView()

@property (nonatomic) CGPoint beginPoint;//小圆的圆心
@property (nonatomic) CGPoint currentPoint;//大圆圆心
@property (nonatomic) CGFloat beginR;//小圆半径
@property (nonatomic) CGFloat currentR;//大圆半径
@property (nonatomic) CGPoint pointA;
@property (nonatomic) CGPoint pointB;
@property (nonatomic) CGPoint pointC;
@property (nonatomic) CGPoint pointD;
@property (nonatomic) CGPoint pointO;

@property (nonatomic) CGFloat maxDistance;//拉到多远，松手后不会回弹，即消息消失，默认100
@property (nonatomic) CGFloat currentDistance;//当前距离
@property (nonatomic, strong) UIColor * badgeColor;
@property (nonatomic, strong) CAShapeLayer * pathLayer;

@property (nonatomic, strong) CAEmitterLayer * explosionLayer;//爆炸layer，UI没给图，自己做爆炸云
@property (nonatomic, strong) UIImageView * explosionImageView;//爆炸图片，如果UI给了图，直接用这个属性


@property (nonatomic, strong) UILabel *numLabel;


@end

@implementation LSBadgeView

-(void)awakeFromNib{
    [super awakeFromNib];
    [self createCommon];
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createCommon];
    }
    return self;
}
-(void)createCommon{
    self.maxDistance = 100;
    self.beginPoint = self.center;
    NSLog(@"======%f,%f",self.beginPoint.x,self.beginPoint.y);
    self.badgeColor = [UIColor redColor];
    self.backgroundColor = self.badgeColor;
    self.clipsToBounds = YES;
    self.layer.cornerRadius = self.frame.size.width > self.frame.size.height ? self.frame.size.height / 2 : self.frame.size.width / 2;
    self.currentR = self.frame.size.width > self.frame.size.height ? self.frame.size.height / 2 : self.frame.size.width / 2;
    
    self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.numLabel.backgroundColor = [UIColor clearColor];
    self.numLabel.textColor = [UIColor whiteColor];
    self.numLabel.textAlignment = NSTextAlignmentCenter;
    self.numLabel.font = [UIFont systemFontOfSize:15.0f];
    self.numLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.numLabel];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
}




-(void)pan:(UIPanGestureRecognizer *)pan{
    //设置了消失回调才会走消失动效
    if (!self.dismissBlock) {
        return;
    }
    
    //获取当前点
    self.currentPoint = [pan locationInView:self.superview];
    //两圆心之间的距离
    self.currentDistance = (CGFloat)sqrtf(powf(self.currentPoint.x - self.beginPoint.x, 2) + powf(self.currentPoint.y - self.beginPoint.y, 2));
    //当前view跟着手势动
    self.center = self.currentPoint;
    
    //拖动过程
    if (pan.state == UIGestureRecognizerStateChanged) {
        //小于最远距离，出现拖拽路径
        if (self.currentDistance > 0 && self.currentDistance < self.maxDistance ) {
            [self getPoint];
            [self drawPath];
        }else{
            //大于最远距离，粘性效果路径消失
            [self dismissPath];
        }
    }else if (pan.state == UIGestureRecognizerStateEnded){
        //拖动结束
        if (self.currentDistance > self.maxDistance) {
            //大于最远距离，进行销毁动画，并触发block回调
            self.hidden = YES;
            [self startExplosionAnimate];
            if (self.dismissBlock) {
                self.dismissBlock();
            }
        }else{
            //小于最远距离，回到原点，并进行颤动动画
            /*
             参数三：颤动数值，数值越大，颤动越小；为1时，平滑减速至终点，不会颤动；
             参数四：初始弹簧速度（0 ~ 1）；为1时，表示1s内完成移动动画，即1s内从初始点移动到终点，剩下的时间平分在颤动动画上
             */
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
                self.center = self.beginPoint;
                [self dismissPath];

            } completion:^(BOOL finished) {
                
            }];
        }
    }
}
-(void)getPoint{
    
    //获取半径，根据拖动距离，缩小小圆半径
    CGFloat rate = self.currentDistance / self.maxDistance > 1 ? 0 : 1 - (self.currentDistance / self.maxDistance);
    self.beginR = self.currentR * rate;
    
    //计算φ
    CGFloat M = (self.currentPoint.x - self.beginPoint.x) / (self.currentPoint.y - self.beginPoint.y);
    CGFloat angle = atanf(M);
    
    //计算A
    CGFloat Ax = self.beginPoint.x - cosf(angle) * self.beginR;
    CGFloat Ay = self.beginPoint.y + self.beginR * sinf(angle);
    self.pointA = CGPointMake(Ax, Ay);
   
    //计算B
    CGFloat Bx = self.beginPoint.x + cosf(angle) * self.beginR;
    CGFloat By = self.beginPoint.y - self.beginR * sinf(angle);
    self.pointB = CGPointMake(Bx, By);
    
    //计算C
    CGFloat Cx = self.currentPoint.x - cosf(angle) * self.currentR;
    CGFloat Cy = self.currentR * sinf(angle) + self.currentPoint.y;
    self.pointC = CGPointMake(Cx, Cy);
    
    //计算D
    CGFloat Dx = self.currentPoint.x + cosf(angle) * self.currentR;
    CGFloat Dy = self.currentPoint.y - self.currentR * sinf(angle);
    self.pointD = CGPointMake(Dx, Dy);
    
    //计算O
    CGFloat Ox = self.beginPoint.x + (self.currentPoint.x - self.beginPoint.x) / 2;
    CGFloat Oy = self.beginPoint.y + (self.currentPoint.y - self.beginPoint.y) / 2;
    self.pointO = CGPointMake(Ox, Oy);
}

-(void)drawPath{
    
    UIBezierPath * path3 = [UIBezierPath bezierPath];
    //小圆
    [path3 addArcWithCenter:self.beginPoint radius:self.beginR startAngle:0 endAngle:360 clockwise:YES];
    //两条圆弧  按照A -> B -> D -> C -> A 画图
    [path3 moveToPoint:self.pointA];
    [path3 addLineToPoint:self.pointB];
    [path3 addQuadCurveToPoint:self.pointD controlPoint:self.pointO];
    [path3 addLineToPoint:self.pointC];
    [path3 addQuadCurveToPoint:self.pointA controlPoint:self.pointO];
    
    self.pathLayer.path = path3.CGPath;
}
-(void)dismissPath{
    [self.pathLayer removeFromSuperlayer];
    self.pathLayer = nil;
}

-(CAShapeLayer *)pathLayer{
    if (!_pathLayer) {
        _pathLayer = [CAShapeLayer layer];
        _pathLayer.fillColor = self.badgeColor.CGColor;
        [self.superview.layer insertSublayer:_pathLayer below:self.layer];
    }
    return _pathLayer;
}



#pragma mark --- 销毁动画

/*
//如果UI有爆炸云的图片，那就直接播放，更简单
- (void)startExplosionAnimate{
    
    self.explosionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    self.explosionImageView.center = self.center;
    
    NSArray * imageArray = @[[UIImage imageNamed:@"1"],
                             [UIImage imageNamed:@"2"],
                             [UIImage imageNamed:@"3"],
                             [UIImage imageNamed:@"4"]];
    self.explosionImageView.animationImages = imageArray;
    self.explosionImageView.animationDuration = 3;
    self.explosionImageView.animationRepeatCount = 1;//重复次数，默认是0，0为无限次
    [self.explosionImageView startAnimating];
    [self performSelector:@selector(stopExplosionAnimate) withObject:nil afterDelay:3];
    [self.superview insertSubview:self.explosionImageView belowSubview:self];
}
-(void)stopExplosionAnimate{
    [self.explosionImageView stopAnimating];
    self.explosionImageView.hidden = YES;
    [self.explosionImageView removeFromSuperview];
}
*/

//销毁动画
- (void)startExplosionAnimate{
    self.explosionLayer.beginTime = CACurrentMediaTime();
    [self.explosionLayer setValue:@500 forKeyPath:@"emitterCells.explosion.birthRate"];
    [self performSelector:@selector(stopExplosionAnimation) withObject:nil afterDelay:0.1];
}
//停止动画
- (void)stopExplosionAnimation{
    [_explosionLayer setValue:@0 forKeyPath:@"emitterCells.explosion.birthRate"];
}
//爆炸Layer
- (CAEmitterLayer *)explosionLayer {
    if (!_explosionLayer) {
        CAEmitterCell *explosionCell = [CAEmitterCell emitterCell];
        explosionCell.name = @"explosion";
        explosionCell.alphaRange = 0.20;
        explosionCell.alphaSpeed = -1.0;
        explosionCell.lifetime = 0.2;//粒子存活的时间,以秒为单位
        explosionCell.lifetimeRange = 0.1;// 可以为这个粒子存活的时间再指定一个范围。0.1s到0.3s
        explosionCell.birthRate = 0;//每秒生成多少个粒子
        explosionCell.velocity = 40.00;//粒子平均初始速度。正数表示竖直向上，负数竖直向下。
        explosionCell.velocityRange = 10.00;//可以再指定一个范围。
        explosionCell.scale = 0.05;
        explosionCell.scaleRange = 0.02;
        explosionCell.contents = (id)[self getExplosionImage].CGImage;//用图片效果更佳
        
        _explosionLayer = [CAEmitterLayer layer];
        _explosionLayer.name = @"emitterLayer";
        _explosionLayer.emitterShape = kCAEmitterLayerCircle;
        _explosionLayer.emitterMode = kCAEmitterLayerOutline;//发射源的发射模式，以一个圆的方式向外扩散开
        _explosionLayer.emitterSize = CGSizeMake(25, 0);
        _explosionLayer.emitterCells = @[explosionCell];
        _explosionLayer.renderMode = kCAEmitterLayerOldestFirst;
        _explosionLayer.masksToBounds = NO;
        _explosionLayer.seed = 1366128504;
        [self.superview.layer addSublayer:_explosionLayer];
        
    }
    _explosionLayer.emitterPosition = self.center;//发射源位置
    return _explosionLayer;
}
-(UIImage *)getExplosionImage{
    UIGraphicsBeginImageContext(CGSizeMake(60, 60));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[self.badgeColor colorWithAlphaComponent:0.5] CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 60, 60));
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


#pragma mark --- 外部传值
-(void)setCountStr:(NSString *)countStr{
    if (countStr.length == 0) {
        self.hidden = YES;
    }
    _numLabel.text = countStr;
}
@end
