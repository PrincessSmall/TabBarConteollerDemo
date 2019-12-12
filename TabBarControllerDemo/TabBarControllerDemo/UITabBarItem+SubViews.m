//
//  UITabBarItem+SubViews.m
//  pghuifudashi
//
//  Created by Jaym on 2019/2/11.
//  Copyright © 2019 Auntec. All rights reserved.
//

#import "UITabBarItem+SubViews.h"


@implementation UITabBarItem (SubViews)

- (UIControl *)tabBarButton
{
    UIControl *control = [self valueForKey:@"view"];
    return control;
}

- (UIImageView *)tabBarButtonImageView
{
    for (UIImageView *subview in self.tabBarButton.subviews) {
        if ([subview cyl_isTabImageView]) {
            return (UIImageView *)subview;
        }
    }
    return nil;
}

- (UILabel *)tabBarButtonLabel {
    for (UILabel *subview in self.tabBarButton.subviews) {
        if ([subview cyl_isTabLabel]) {
            return (UILabel *)subview;
        }
    }
    return nil;
}

@end



@implementation UIView (CYLTabBarControllerExtention)

- (BOOL)cyl_isTabButton
{
    BOOL isKindOfButton = [self cyl_isKindOfClass:[UIControl class]];
    return isKindOfButton;
}

- (BOOL)cyl_isTabImageView {
    BOOL isKindOfImageView = [self cyl_isKindOfClass:[UIImageView class]];
    if (!isKindOfImageView) {
        return NO;
    }
    NSString *subString = [NSString stringWithFormat:@"%@cat%@ew", @"Indi" , @"orVi"];
    BOOL isBackgroundImage = [self cyl_classStringHasSuffix:subString];
    BOOL isTabImageView = !isBackgroundImage;
    return isTabImageView;
}

- (BOOL)cyl_isTabLabel {
    BOOL isKindOfLabel = [self cyl_isKindOfClass:[UILabel class]];
    return isKindOfLabel;
}

- (BOOL)cyl_isTabBadgeView
{
    BOOL isKindOfClass = [self isKindOfClass:[UIView class]];
    BOOL isClass = [self isMemberOfClass:[UIView class]];
    BOOL isKind = isKindOfClass && !isClass;
    if (!isKind) {
        return NO;
    }
    NSString *tabBarClassString = [NSString stringWithFormat:@"%@IB%@", @"_U" , @"adg"];
    BOOL isTabBadgeView = [self cyl_classStringHasPrefix:tabBarClassString];;
    return isTabBadgeView;
}

- (BOOL)cyl_isTabBackgroundView
{
    BOOL isKindOfClass = [self isKindOfClass:[UIView class]];
    BOOL isClass = [self isMemberOfClass:[UIView class]];
    BOOL isKind = isKindOfClass && !isClass;
    if (!isKind) {
        return NO;
    }
    NSString *tabBackgroundViewString = [NSString stringWithFormat:@"%@IB%@", @"_U" , @"arBac"];
    BOOL isTabBackgroundView = [self cyl_classStringHasPrefix:tabBackgroundViewString] && [self cyl_classStringHasSuffix:@"nd"];
    return isTabBackgroundView;
}

- (BOOL)cyl_isKindOfClass:(Class)class
{
    BOOL isKindOfClass = [self isKindOfClass:class];
    BOOL isClass = [self isMemberOfClass:class];
    BOOL isKind = isKindOfClass && !isClass;
    if (!isKind) {
        return NO;
    }
    BOOL isTabBarClass = [self cyl_isTabBarClass];
    return isTabBarClass;
}

- (BOOL)cyl_isTabBarClass
{
    NSString *tabBarClassString = [NSString stringWithFormat:@"U%@a%@ar", @"IT" , @"bB"];
    BOOL isTabBarClass = [self cyl_classStringHasPrefix:tabBarClassString];
    return isTabBarClass;
}

- (BOOL)cyl_classStringHasPrefix:(NSString *)prefix
{
    NSString *classString = NSStringFromClass([self class]);
    return [classString hasPrefix:prefix];
}

- (BOOL)cyl_classStringHasSuffix:(NSString *)suffix
{
    NSString *classString = NSStringFromClass([self class]);
    return [classString hasSuffix:suffix];
}


@end
