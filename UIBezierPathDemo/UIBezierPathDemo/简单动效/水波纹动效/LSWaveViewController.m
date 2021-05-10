//
//  LSWaveViewController.m
//  UIBezierPathDemo
//
//  Created by 李诗 on 2021/4/30.
//  Copyright © 2021 李诗. All rights reserved.
//

#import "LSWaveViewController.h"
#import "LSWaveView.h"

@interface LSWaveViewController ()
@property (weak, nonatomic) IBOutlet LSWaveView *waveView;
@property (weak, nonatomic) IBOutlet UISlider *slider;
- (IBAction)progressChange:(id)sender;

@end

@implementation LSWaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"水波纹动效";
}

- (IBAction)progressChange:(id)sender {
    
    self.waveView.progress = self.slider.value;
    NSLog(@"进度===%f",self.slider.value);
}
@end
