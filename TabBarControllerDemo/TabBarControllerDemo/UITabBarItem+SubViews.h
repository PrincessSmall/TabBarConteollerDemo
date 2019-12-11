//
//  UITabBarItem+SubViews.h
//  pghuifudashi
//
//  Created by Jaym on 2019/2/11.
//  Copyright © 2019 Auntec. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITabBarItem (SubViews)

@property (nonatomic, readonly) UIControl *tabBarButton;
@property (nonatomic, readonly) UIImageView *tabBarButtonImageView;
@property (nonatomic, readonly) UILabel *tabBarButtonLabel;

@end

@interface UIView (CYLTabBarControllerExtention)

- (BOOL)cyl_isTabButton;
- (BOOL)cyl_isTabImageView;
- (BOOL)cyl_isTabLabel;
- (BOOL)cyl_isTabBackgroundView;

@end

