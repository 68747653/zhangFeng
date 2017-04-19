//
//  SupplierRewardApplyViewController.m
//  FullHelp
//
//  Created by hhsoft on 17/2/13.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "SupplierRewardApplyViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import "GlobalFile.h"
#import "MenuInfo.h"
#import "SupplierRewardOngoingViewController.h"
#import "SupplierRewardCompletedViewController.h"
#import "SupplierRewardRefusedViewController.h"

@interface SupplierRewardApplyViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) NSMutableArray *arrMenu;
@property (nonatomic,strong) UIView *spView;
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,assign) NSInteger infoID;

@end

@implementation SupplierRewardApplyViewController
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(instancetype)initWithInfoID:(NSInteger)infoID{
    if(self = [super init]){
        _infoID = infoID;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //供货商
    self.navigationItem.title = @"我的打赏申请";
    self.view.backgroundColor = [GlobalFile backgroundColor];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    //初始化顶部按钮
    [self addClassButton];
    //加载子控制器
    [self setChildViewController];
    //加载ScrollView
    [self setupScrollView];
}
#pragma mark -- 初始化顶部按钮
-(void)addClassButton{
    for (NSInteger i = 0;i<self.arrMenu.count;i++) {
        UIButton *classButton = [[UIButton alloc]initWithFrame:CGRectMake(i*[HHSoftAppInfo AppScreen].width/self.arrMenu.count, 0, [HHSoftAppInfo AppScreen].width/self.arrMenu.count, 40)];
        [classButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [classButton setTitleColor:[HHSoftAppInfo defaultDeepSystemColor] forState:UIControlStateSelected];
        classButton.tag = 200+i;
        classButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        MenuInfo *menuInfo = self.arrMenu[i];
        [classButton setTitle:menuInfo.menuName forState:UIControlStateNormal];
        [classButton setTitle:menuInfo.menuName forState:UIControlStateSelected];
        
        if (i == 0) {
            classButton.selected = YES;
            classButton.titleLabel.font = [UIFont systemFontOfSize:16];
        }
        classButton.backgroundColor =[UIColor whiteColor];
        [classButton addTarget:self action:@selector(classButtonClickEnent:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:classButton];
    }
    _spView = [[UIView alloc]initWithFrame:CGRectMake(5, 38, [HHSoftAppInfo AppScreen].width/self.arrMenu.count-10, 2)];
    [self.view addSubview:_spView];
    _spView.backgroundColor = [GlobalFile themeColor];
}
#pragma mark -- 加载ScrollView
- (void)setupScrollView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 40, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-40);
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.scrollEnabled = NO;
    scrollView.bounces = NO;
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * [HHSoftAppInfo AppScreen].width,0);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
}
#pragma mark -- 加载子控制器
-(void)setChildViewController{
    SupplierRewardOngoingViewController *supplierRewardOngoingViewController = [[SupplierRewardOngoingViewController alloc] initWithMark:1 InfoID:_infoID];
    [self addChildViewController:supplierRewardOngoingViewController];
    SupplierRewardCompletedViewController *supplierRewardCompletedViewController = [[SupplierRewardCompletedViewController alloc] initWithMark:2 InfoID:_infoID];
    [self addChildViewController:supplierRewardCompletedViewController];
    SupplierRewardRefusedViewController *supplierRewardRefusedViewController = [[SupplierRewardRefusedViewController alloc] initWithMark:3 InfoID:_infoID];
    [self addChildViewController:supplierRewardRefusedViewController];
}
#pragma mark -- scrollView的代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _spView.frame = CGRectMake(scrollView.contentOffset.x/self.arrMenu.count+5, 38, [HHSoftAppInfo AppScreen].width/self.arrMenu.count-10, 2);
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x/scrollView.frame.size.width;
    UIViewController *willShowChildVc = self.childViewControllers[index];
    if (willShowChildVc.isViewLoaded) {
        return;
    }
    willShowChildVc.view.frame = scrollView.bounds;
    [scrollView addSubview:willShowChildVc.view];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
#pragma mark -- 按钮点击事件
-(void)classButtonClickEnent:(UIButton *)button{
    [self.childViewControllers[button.tag-200] reloadRewardData];
    for (UIView *subView in [self.view subviews]) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *noButton=(UIButton *)subView;
            noButton.selected = NO;
            noButton.titleLabel.font = [UIFont systemFontOfSize:14];
        }
    }
    button.selected = YES;
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = [HHSoftAppInfo AppScreen].width *(button.tag-200);
    [self.scrollView setContentOffset:offset animated:YES];
}
#pragma mark -- 初始化菜单数据
-(NSMutableArray *)arrMenu{
    if (!_arrMenu) {
        _arrMenu = [[NSMutableArray alloc]init];
        MenuInfo *menuInfo0 = [[MenuInfo alloc]initWithMenuID:0 menuName:@"申请中"];
        MenuInfo *menuInfo1 = [[MenuInfo alloc]initWithMenuID:1 menuName:@"已打赏"];
        MenuInfo *menuInfo2 = [[MenuInfo alloc]initWithMenuID:2 menuName:@"已拒绝"];
        _arrMenu = [NSMutableArray arrayWithObjects:menuInfo0,menuInfo1,menuInfo2, nil];
        
    }
    return _arrMenu;
}





@end
