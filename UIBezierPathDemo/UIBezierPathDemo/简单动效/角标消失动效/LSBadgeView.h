//
//  LSBadgeView.h
//  UIBezierPathDemo
//
//  Created by 李诗 on 2021/5/7.
//  Copyright © 2021 李诗. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSBadgeView : UIView

@property (nonatomic, copy) NSString * countStr;//角标内容
@property (nonatomic, copy) void(^dismissBlock)(void);//触发销毁动画block，用来回调请求清除角标接口，调用了这个，才会有拖拽消失动效

@end

NS_ASSUME_NONNULL_END
