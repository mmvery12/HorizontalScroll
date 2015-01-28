//
//  HorizontalView.h
//  FrameWork
//
//  Created by liyuchang on 15-1-22.
//  Copyright (c) 2015年 com.Vacn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HorizontalView : UIView
@property (nonatomic,assign,readonly,getter=getIdentity)NSString * identity;
@property (nonatomic,assign,readonly)NSInteger index;
-(void)reachIndex:(NSInteger)indt;
- (instancetype)initWithIdentity:(NSString *)idetity;
@end
