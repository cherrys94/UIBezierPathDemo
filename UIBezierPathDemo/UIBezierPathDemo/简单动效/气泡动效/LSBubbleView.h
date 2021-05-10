//
//  LSBubbleView.h
//  UIBezierPathDemo
//
//  Created by 李诗 on 2021/4/27.
//  Copyright © 2021 李诗. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum{
    pathLeft = 0,//贝塞尔曲线先向左弯曲
    pathRight,
}PathType;

@interface LSBubbleView : UIView



-(instancetype)initWithSuperView:(UIView *)superView withoOriginPoint:(CGPoint)originPoint;

@end

NS_ASSUME_NONNULL_END
