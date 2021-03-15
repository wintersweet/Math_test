//
//  TestView.m
//  MathAlgorithm
//
//  Created by Leo on 2021/3/3.
//  Copyright © 2021 dongdonghu. All rights reserved.
//

#import "TestView.h"

@implementation TestView
//如果要立即刷新，要先调用[view setNeedsLayout]，把标记设为需要布局，然后马上调用[view layoutIfNeeded]，实现布局
//在视图第一次显示之前，标记肯定是“需要刷新”的，所以直接调用[view layoutIfNeeded]就会进行立即更新


// 当需要调整UIView子视图布局时，需要在主线程调用该方法。该方法记录请求并立即返回,等待下一个更新周期更新视图
-(void)setNeedsLayout{

}
//强制视图立即更新其布局，即同步执行
-(void)layoutIfNeeded{

}


-(void)layoutSubviews{

}
@end
