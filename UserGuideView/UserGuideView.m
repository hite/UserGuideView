//
//  UserGuideView.m
//
//  Created by liang on 2019/8/23.
//  Copyright © 2019 ssmily.co. All rights reserved.
//

#import "UserGuideView.h"


@interface UserGuideView ()

@property(nonatomic, assign) NSInteger step;

/**
 已经看过的步骤
 */
@property(nonatomic, strong) NSMutableArray *takenSteps;

/**
 遮罩区域，在 subLayer 层级掏透明的洞
 */
@property(nonatomic, strong) UIView *mask;
/**
 承载提示文案的地方
 */
@property(nonatomic, strong) UIView *wrap;
@end

@implementation UserGuideView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.takenSteps = [NSMutableArray arrayWithCapacity:3];
        // 遮罩
        UIView *mask = [[UIView alloc] initWithFrame:self.bounds];
        self.mask = mask;
        [self addSubview:mask];
        
        // 容器
        UIView *wrap = [[UIView alloc] initWithFrame:self.bounds];
        self.wrap = wrap;
        wrap.backgroundColor = [UIColor clearColor];
        [self addSubview:wrap];

        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [wrap addGestureRecognizer:tap];
    }
    
    return self;
}

- (void)show{
    NSInteger total = [self.dataSource totalStep:self];
    if (self.step >= total) {
        NSLog(@"[UseGuideView] 数据源错误");
        return;
    }
    // 要绘制的提示信息
    UIView *toShowView = nil;
    if (self.step < self.takenSteps.count) {
        toShowView = [self.takenSteps objectAtIndex:self.step];
    }
    if (toShowView == nil) {
        toShowView = [self.dataSource guideInfoForStep:self.step guideView:self];
    }
    [self.wrap.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 绘制中空 mask；
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:0];
    UIBezierPath *circlePath = [self.dataSource hollowPathForStep:self.step guideView:self];

    [path appendPath:circlePath];
    [path setUsesEvenOddFillRule:YES];
    
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule = kCAFillRuleEvenOdd;
    fillLayer.fillColor = [[UIColor blackColor] colorWithAlphaComponent:0.7].CGColor;
 
    [self.mask.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self.mask.layer addSublayer:fillLayer];
    
    CGRect hollowFrame = circlePath.bounds;
    // 在中空以下开始布局提示文案
    toShowView.frame = CGRectMake(toShowView.frame.origin.x, hollowFrame.origin.y + hollowFrame.size.height, CGRectGetWidth(toShowView.bounds), CGRectGetHeight(toShowView.bounds));
    [self.wrap addSubview:toShowView];
    // 按钮在下面，居中显示
    UIButton *done = [UIButton new];
    NSString *doneTxt = [self.dataSource actionTitleForStep:self.step guideView:self];
    [done setTitle:doneTxt forState:UIControlStateNormal];
    [done setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    done.titleLabel.font = [UIFont systemFontOfSize:16];
    [done addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    done.backgroundColor = [UIColor clearColor];
    done.layer.borderColor = [UIColor whiteColor].CGColor;
    done.layer.borderWidth = 1;
    done.layer.cornerRadius = 20;
    
    [done sizeToFit];
    
    [self.wrap addSubview:done];
    CGFloat btnWidth = 208.f;
    done.frame = CGRectMake((CGRectGetWidth(self.wrap.bounds) - btnWidth) / 2.f, toShowView.frame.size.height + toShowView.frame.origin.y, btnWidth, 40);
    
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
    }  completion:nil];
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    }  completion: nil];
    if ([self.delegate respondsToSelector:@selector(didGuideViewDismiss:)] ) {
        [self.delegate didGuideViewDismiss:self];
    }
}

#pragma mark - event
- (void)next:(id)sender{
    if ([self.delegate respondsToSelector:@selector(finishStep:guideView:)] ) {
        [self.delegate finishStep:self.step guideView:self];
    }
    
    NSInteger total = [self.dataSource totalStep:self];
    if (self.step >= total - 1) {
        [self dismiss];
    } else {
        self.step++;
        [self show];
    }
}

@end
