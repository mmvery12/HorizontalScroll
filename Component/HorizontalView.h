//
//  HorizontalView.h
//  FrameWork
//
//  Created by liyuchang on 15-1-22.
//  Copyright (c) 2015年 com.Vacn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HorizontalScrollView;
@interface HorizontalView : UIView
@property (nonatomic,assign,readonly,getter=getIdentity)NSString * identity;
@property (nonatomic,assign,readonly)NSInteger index;
-(void)resize:(HorizontalScrollView *)scroll index:(NSInteger)index;
- (instancetype)initWithHorizontalScroll:(HorizontalScrollView *)horizontalScroll index:(NSInteger)index Identity:(NSString *)idetity;
@end
