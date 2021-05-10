//
//  ViewController.m
//  UIBezierPathDemo
//
//  Created by 李诗 on 2021/4/8.
//  Copyright © 2021 李诗. All rights reserved.
//

#import "ViewController.h"
#import "LSSimpleUseViewController.h"
#import "LSProgressViewController.h"
#import "LSDrawSignViewController.h"
#import "LSProgressAnimationViewController.h"
#import "LSBubbleViewController.h"
#import "LSBubbleViewController2.h"
#import "LSShoppingViewController.h"
#import "LSWaveViewController.h"
#import "LSBadgeViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray * dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"贝塞尔曲线";
    self.dataArray = @[@"简单使用",@"绘制进度条",@"实现手写签名",@"简单动效1 - 进度条类型动效",@"简单动效2 - 冒泡泡动效",@"简单动效2.1 - 冒泡泡动效2",@"简单动效3 - 加入购物车",@"简单动效4 - 水波纹动效",@"简单动效5 - 角标消失动效"];
    [self.tableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
        LSSimpleUseViewController *vc = [[LSSimpleUseViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 1){
        LSProgressViewController * vc = [[LSProgressViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 2){
        LSDrawSignViewController * vc = [[LSDrawSignViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 3){
        LSProgressAnimationViewController * vc = [[LSProgressAnimationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 4){
        LSBubbleViewController * vc = [[LSBubbleViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 5){
        LSBubbleViewController2 * vc = [[LSBubbleViewController2 alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 6){
        LSShoppingViewController * vc = [[LSShoppingViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 7){
        LSWaveViewController * vc = [[LSWaveViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 8){
        LSBadgeViewController * vc = [[LSBadgeViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
