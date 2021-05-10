//
//  LSDrawSignView.h
//  UIBezierPathDemo
//
//  Created by 李诗 on 2021/4/9.
//  Copyright © 2021 李诗. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^drawStateBlock)(BOOL hasPath);

@interface LSDrawSignView : UIView

@property (nonatomic, strong) UIColor * pathColor;
@property (nonatomic) CGFloat lineWidth;
@property (nonatomic, copy) drawStateBlock block;

//清除绘画内容
-(void)cleanContent;

//撤销
- (void)revoke;

@end

NS_ASSUME_NONNULL_END
