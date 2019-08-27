//
//  ViewController.m
//  UserGuideView
//
//  Created by liang on 2019/8/27.
//  Copyright © 2019 liang. All rights reserved.
//

#import "ViewController.h"
#import "UserGuideView.h"

@interface ViewController () <UserGuideViewDelegate, UserGuideViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    // Do any additional setup after loading the view.
    UserGuideView *ug = [[UserGuideView alloc] initWithFrame:self.view.bounds];
    ug.delegate = self;
    ug.dataSource = self;
    [ug show];
    [self.view addSubview:ug];
}

- (nonnull NSString *)actionTitleForStep:(NSInteger)stepNO guideView:(nonnull UserGuideView *)guideView {
    return @"马上试试";
}

#define YXScreenWidth                   [UIScreen mainScreen].bounds.size.width
- (nonnull UIView *)guideInfoForStep:(NSInteger)stepNO guideView:(nonnull UserGuideView *)guideView {
    UIView *cus = [UIView new];
    cus.frame = CGRectMake(0, 0, YXScreenWidth, 265);
    
    UIImageView *point = [UIImageView new];
    point.image = [UIImage imageNamed:@"arrow"];
    [cus addSubview:point];
    [point sizeToFit];
    point.frame = CGRectMake(40.5, 12, 205 / 2.f, 175 / 2.f);

    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"新增热销榜，点击可以查看对应分类\n的实时热销排行榜。";
    label.numberOfLines = -1;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    [cus addSubview:label];
    label.frame = CGRectMake(21, point.frame.origin.y + point.frame.size.height + 5, YXScreenWidth - 56.5 - 5, 40);
    
    return cus;
}

- (nonnull UIBezierPath *)hollowPathForStep:(NSInteger)stepNO guideView:(nonnull UserGuideView *)guideView {
    CGFloat circleSize = 74.f;
    CGRect ret = CGRectMake(87, 170, 100, 100);
    // 右下角坐标
    CGFloat right_x = ret.origin.x + CGRectGetWidth(ret), bottom_y = ret.origin.y + CGRectGetHeight(ret);
    ret = CGRectMake(right_x - circleSize - 11, bottom_y  - 22, circleSize, circleSize);
    UIBezierPath *circle = [UIBezierPath bezierPathWithRoundedRect:ret cornerRadius: circleSize / 2];
    
    return circle;
}

- (NSInteger)totalStep:(nonnull UserGuideView *)guideView {
    return 1;
}

@end
