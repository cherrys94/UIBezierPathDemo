//
//  LSDrawSignViewController.m
//  UIBezierPathDemo
//
//  Created by 李诗 on 2021/4/9.
//  Copyright © 2021 李诗. All rights reserved.
//

#import "LSDrawSignViewController.h"
#import "LSDrawSignView.h"

@interface LSDrawSignViewController ()
- (IBAction)cleanAction:(id)sender;
- (IBAction)saveAction:(id)sender;
- (IBAction)revokeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@property (weak, nonatomic) IBOutlet LSDrawSignView *signView;
@property (weak, nonatomic) IBOutlet UIImageView *signImageView;
@property (nonatomic) BOOL hasPath;

@end

@implementation LSDrawSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"手写签名";
    __weak typeof(self) weakSelf = self;
    self.signView.block = ^(BOOL hasPath) {
        weakSelf.hasPath = hasPath;
    };
}


- (IBAction)revokeAction:(id)sender {
    [self.signView revoke];
}

- (IBAction)saveAction:(id)sender {
    if (!self.hasPath) {
        NSLog(@"没有绘制图形");
        return;
    }
    UIImage * image = [self changeToImage];
    self.signImageView.image = image;
}

- (IBAction)cleanAction:(id)sender {
    [self.signView cleanContent];
}

//转换图片
- (UIImage *)changeToImage {
    
    UIGraphicsBeginImageContextWithOptions(self.signView.frame.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.signView.layer renderInContext:ctx];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//图片转字符串
-(NSString *)UIImageToBase64Str:(UIImage *) image {
    NSData * data = UIImageJPEGRepresentation(image, 1.0f);
    NSString * encodedImageStr = [data base64EncodedStringWithOptions:0];
    return encodedImageStr;
}
@end
