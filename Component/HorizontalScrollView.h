//
//  HorizontalScrollView.h
//  FrameWork
//
//  Created by liyuchang on 15-1-22.
//  Copyright (c) 2015年 com.Vacn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SysAsseist.h"
#import "HorizontalView.h"

@class HorizontalScrollView;
typedef HorizontalView * (^HorizontalViewAtIndex) (HorizontalScrollView *scroll,NSInteger index);
typedef CGFloat (^HorizontalWidthAtIndex) (HorizontalScrollView *scroll,NSInteger index);
typedef NSInteger (^HorizontalCount)(HorizontalScrollView *scroll);
@interface HorizontalScrollView : UIScrollView<UIScrollViewDelegate>
@property (nonatomic,copy)HorizontalViewAtIndex horizontalViewAtIndex;
@property (nonatomic,copy)HorizontalCount horzontalCount;
@property (nonatomic,copy)HorizontalWidthAtIndex horizontalWidthAtIndex;
-(CGRect)viewRectAtIndex:(NSInteger)index;
- (id)initHorizontalScrollViewWithFrame:(CGRect)frame;
-(HorizontalView *)deqreuseViewAtIndex:(NSInteger)index identity:(NSString *)identity;
@end
