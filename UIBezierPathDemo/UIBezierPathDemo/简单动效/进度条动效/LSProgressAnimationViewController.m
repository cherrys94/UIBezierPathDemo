//
//  LSProgressAnimationViewController.m
//  UIBezierPathDemo
//
//  Created by 李诗 on 2021/4/26.
//  Copyright © 2021 李诗. All rights reserved.
//

#import "LSProgressAnimationViewController.h"
#import "LSCustomArcView.h"
#import "UIColor+LSHex.h"

#define DEGREES_TO_RADIANS(angle)           ((angle) / 180.0 * M_PI)

@interface LSProgressAnimationViewController ()
@property (weak, nonatomic) IBOutlet UIView *arcBaseView;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;

@property (nonatomic, strong) LSCustomArcView *arcView;
@property (nonatomic) CGFloat progress;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (nonatomic, strong) NSTimer * timer;
- (IBAction)startRandomAnimation:(id)sender;
- (IBAction)endRandomAnimation:(id)sender;

@end

@implementation LSProgressAnimationViewController
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self endRandomAnimation:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"简单动效1";
    
    self.arcView = [[LSCustomArcView alloc] initWithFrame:self.arcBaseView.bounds];
    [self.arcView LSCustomArcViewWithSuperViewStarAngle:150 endAngle:30 lineWidth:5];
    self.arcView.colorsArray = @[(id)[UIColor colorWithHexString:@"#0EDCB3"].CGColor,(id)[UIColor colorWithHexString:@"#108EE8"].CGColor];
    self.arcView.baseColor = [UIColor colorWithHexString:@"#D7DADB"];
    [self.arcBaseView addSubview:self.arcView];
    
}

- (IBAction)endRandomAnimation:(id)sender {
    if (self.timer) {
        [self.timer invalidate];
        self.timer =  nil;
    }
}

- (IBAction)startRandomAnimation:(id)sender {
    if (!self.timer) {
        self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(createRandom) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

-(void)createRandom{
    self.progress = ((double)arc4random() / UINT32_MAX);
    self.arcView.progress = self.progress;
    self.progressLabel.text = [NSString stringWithFormat:@"%.2f",self.progress];
    
    CGFloat angle = 240 * self.progress;//240 = 360 - (150 - 30) 即进度条的总角度
    CGAffineTransform transform = self.arrowImageView.transform;
    transform = CGAffineTransformIdentity;
    if (angle < 120) {//因为我的指针图片针头是垂直的，要指到进度条上0的位置，需要往回120°，以此来计算改变指针图片的transform
        transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-(120 - angle)));
    }else{
        transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(angle - 120));
    }
    self.arrowImageView.transform = transform;
}
@end
