//
//  LSBadgeViewController.m
//  UIBezierPathDemo
//
//  Created by 李诗 on 2021/5/7.
//  Copyright © 2021 李诗. All rights reserved.
//

#import "LSBadgeViewController.h"
#import "LSBadgeView.h"

@interface LSBadgeViewController ()
@property (weak, nonatomic) IBOutlet LSBadgeView *xibBadgeView;
@property (weak, nonatomic) IBOutlet UIButton *badgeBtn;

@property (weak, nonatomic) IBOutlet LSBadgeView *xibBadgeView2;
@property (weak, nonatomic) IBOutlet UIButton *badgeBtn2;

@end

@implementation LSBadgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"角标消失动效";
    
    //手写调用
    [self createBadgeView];
    
    /*
     xib调用
     xib调用时，约束要用相对于view，而不是safeArea；
     或者你可以自己手动去LSBadgeView.m中修改center的赋值，将safeArea距离加上
    */
    self.xibBadgeView.countStr = @"15";
    [self.xibBadgeView setDismissBlock:^{
        [self.badgeBtn setTitle:@"我的角标消失了" forState:UIControlStateNormal];
    }];
    
    //圆角矩形演示
    self.xibBadgeView2.countStr = @"15";
    [self.xibBadgeView2 setDismissBlock:^{
        [self.badgeBtn2 setTitle:@"我的角标也消失了" forState:UIControlStateNormal];
    }];
  
}
-(void)createBadgeView{
    LSBadgeView * v = [[LSBadgeView alloc] initWithFrame:CGRectMake(100, 400, 50, 50)];
    v.countStr = @"15";
    //没有调用block，所以不能触发拖动动效
    [self.view addSubview:v];
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
