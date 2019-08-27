//
//  YXUserGuideView.h
//
//  Created by liang on 2019/8/23.
//  Copyright © 2019 ssmily.co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@class UserGuideView;
@protocol UserGuideViewDataSource <NSObject>
@required
/**
 每一步提示下方按钮的文案，

 @param stepNO 第几步的提示
 @return 提示文案
 */
- (NSString *)actionTitleForStep:(NSInteger)stepNO guideView:(UserGuideView *)guideView;

/**
 每一步提示，最主要的的提示文案显示区域。注意这个 View 需要设置 frame，其中 y 是没有用的。frame.y 是根据中空的区域自动定位 y 左边。其他 x，width、height 都是由于的属性。用来定位和撑开显示区域。
 在 guideInfo 下面紧跟着一个按钮区域，这个按钮是居中对齐，顶部紧靠着 guideInfo 的底部。

 @param stepNO 第几步的提示
 @param guideView 实例对象
 @return 返回一个自定义 View，这个 view 被添加在中空和按钮区域的中间；
 */
- (UIView *)guideInfoForStep:(NSInteger)stepNO guideView:(UserGuideView *)guideView;

/**
 中空区域的大小和位置

 @param guideView 当前视图
 @return 返回一个贝塞尔路径
 */
- (UIBezierPath *)hollowPathForStep:(NSInteger)stepNO guideView:(UserGuideView *)guideView;

/**
 一共有多少步。用来觉得哪一步的按钮需要使用不一样的样式

 @param guideView 当前视图
 @return 返回总引导的步数。
 */
- (NSInteger)totalStep:(UserGuideView *)guideView;

@end

@protocol UserGuideViewDelegate <NSObject>
@optional

/**
 用户点击第 step 时的回调，组件会自动关闭弹窗

 @param stepNO 第几步
 @param guideView 组件本身
 */
- (void)finishStep:(NSInteger)stepNO guideView:(UserGuideView *)guideView;

/**
 用户点击空白或者点击完成后的关闭弹窗的回调

 @param guideView 组件本身
 */
- (void)didGuideViewDismiss:(UserGuideView *)guideView;

@end

@interface UserGuideView : UIView

@property(nonatomic, weak) id<UserGuideViewDelegate> delegate;

@property(nonatomic, weak) id<UserGuideViewDataSource> dataSource;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (void)show;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
