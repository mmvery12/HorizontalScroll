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
@protocol HorizontalDelegate <NSObject>
-(void)horizontalViewWillDismiss:(HorizontalView *)view index:(NSInteger)index;
-(void)horizontalViewWillDisplay:(HorizontalView *)view index:(NSInteger)index;
@end

typedef HorizontalView * (^HorizontalViewAtIndex) (HorizontalScrollView *scroll,NSInteger index);
typedef CGFloat (^HorizontalWidthAtIndex) (HorizontalScrollView *scroll,NSInteger index);
typedef NSInteger (^HorizontalCount)(HorizontalScrollView *scroll);
typedef void (^HorizontalViewWillDismiss)(HorizontalView *view,NSInteger index);
@interface HorizontalScrollView : UIScrollView<UIScrollViewDelegate>
@property (nonatomic,assign)id<HorizontalDelegate> horidelegate; //require
@property (nonatomic,copy)HorizontalViewAtIndex horizontalViewAtIndex; //require
@property (nonatomic,copy)HorizontalCount horzontalCount; //require
@property (nonatomic,copy)HorizontalWidthAtIndex horizontalWidthAtIndex; //require

-(CGRect)viewRectAtIndex:(NSInteger)index;
- (id)initHorizontalScrollViewWithFrame:(CGRect)frame;
-(HorizontalView *)deqreuseViewAtIndex:(NSInteger)index identity:(NSString *)identity;
@end
