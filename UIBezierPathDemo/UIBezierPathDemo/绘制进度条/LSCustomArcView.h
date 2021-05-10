//
//  LSCustomArcView.h
//  ConstructionVersion
//
//  Created by 李诗 on 2021/4/21.
//  Copyright © 2021 李诗. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSCustomArcView : UIView

/*
 圆环默认底色为灰色，进度条颜色为红色
 */
-(void)LSCustomArcViewWithSuperViewStarAngle:(CGFloat)starAngle
                           endAngle:(CGFloat)endAngle
                          lineWidth:(int)lineWidth;

@property (nonatomic, copy) UIColor * baseColor;
@property (nonatomic, copy) NSArray * colorsArray;//渐变色数组，注意使用CGColor
@property (nonatomic) CGFloat progress;
@end

NS_ASSUME_NONNULL_END
