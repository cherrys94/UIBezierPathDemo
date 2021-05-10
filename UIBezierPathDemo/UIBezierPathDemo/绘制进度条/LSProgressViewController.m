//
//  LSProgressViewController.m
//  UIBezierPathDemo
//
//  Created by 李诗 on 2021/4/21.
//  Copyright © 2021 李诗. All rights reserved.
//

#import "LSProgressViewController.h"
#import "LSCustomArcView.h"

@interface LSProgressViewController ()

@property (nonatomic, strong) LSCustomArcView *arcView;
@property (nonatomic, strong) UISlider *progressSlider;

@end

@implementation LSProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"进度条绘制";

    self.arcView = [[LSCustomArcView alloc] initWithFrame:CGRectMake(100, 150, 100, 100)];
    [self.arcView LSCustomArcViewWithSuperViewStarAngle:0 endAngle:360 lineWidth:5];
    //如果不想设置渐变色，colorsArray设置两个相同的颜色即可
    self.arcView.colorsArray = @[(id)[UIColor redColor].CGColor,(id)[UIColor yellowColor].CGColor];
    [self.view addSubview:self.arcView];
    
    self.progressSlider = [[UISlider alloc] initWithFrame:CGRectMake(50, 300, 200, 8)];
    [self.progressSlider addTarget:self action:@selector(progressAction) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.progressSlider];
    [UIView animateWithDuration:0 animations:^{
            
    }];
}

-(void)progressAction{
    self.arcView.progress = self.progressSlider.value;
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
