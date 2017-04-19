//
//  MyAttentionViewController.m
//  FullHelp
//
//  Created by hhsoft on 17/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "MyAttentionViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import "GlobalFile.h"
#import "MenuInfo.h"
#import "AttentionAdvertViewController.h"
#import "AttentionNewsViewController.h"
#import "AttentionDemandViewController.h"
#import "AttentionNoticeViewController.h"

@interface MyAttentionViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) NSMutableArray *arrMenu;
@property (nonatomic,strong) UIView *spView;
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,assign) NSInteger orderState;
//判断 是否要更改上面的类别按钮
@property (nonatomic,assign) BOOL isReloadClassButton;
@property (nonatomic,strong) UIButton *rightBarButton;
@property (nonatomic,strong) AttentionAdvertViewController *attentionAdvertViewController;
@property (nonatomic,strong) AttentionNewsViewController *attentionNewsViewController;
@property (nonatomic,strong) AttentionDemandViewController *attentionDemandViewController;
@property (nonatomic,strong) AttentionNoticeViewController *attentionNoticeViewController;

@end

@implementation MyAttentionViewController
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
/*-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if (_isReloadClassButton) {
        if (_orderState != 0) {
            UIButton *button = (UIButton *)[self.view viewWithTag:_orderState+200];
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
            offset.x = [HHSoftAppInfo AppScreen].width *(_orderState+200);
            [self.scrollView setContentOffset:offset animated:YES];
        }
        _isReloadClassButton = NO;
    }
}*/
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的关注";
    self.view.backgroundColor = [GlobalFile backgroundColor];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    
    _rightBarButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    [_rightBarButton setTitle:@"编辑" forState:UIControlStateNormal];
    _rightBarButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_rightBarButton setTitleColor:[GlobalFile themeColor] forState:UIControlStateNormal];
    [_rightBarButton setTitleColor:[GlobalFile themeColor] forState:UIControlStateSelected];
    
    [_rightBarButton addTarget:self action:@selector(rightBarButtonItemEvent) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *serviceItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBarButton];
    UIBarButtonItem *rightFixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightFixedSpace.width = -15;
    self.navigationItem.rightBarButtonItems = @[rightFixedSpace,serviceItem];
    _rightBarButton.userInteractionEnabled = NO;
    //初始化顶部按钮
    [self addClassButton];
    //加载子控制器
    [self setChildViewController];
    //加载ScrollView
    [self setupScrollView];
    _isReloadClassButton = YES;
}
-(void)rightBarButtonItemEvent{
    if ([_rightBarButton.titleLabel.text isEqualToString:@"编辑"]) {
        [_rightBarButton setTitle:@"完成" forState:UIControlStateNormal];
    }else{
        [_rightBarButton setTitle:@"编辑" forState:UIControlStateNormal];
    }
    
    if (self.scrollView.contentOffset.x == 0) {
        [_attentionAdvertViewController deleteSelectCollect];
    }else if(self.scrollView.contentOffset.x == [HHSoftAppInfo AppScreen].width*1){
        [_attentionNewsViewController deleteSelectCollect];
    }else if(self.scrollView.contentOffset.x == [HHSoftAppInfo AppScreen].width*2){
        [_attentionDemandViewController deleteSelectCollect];
    }else if(self.scrollView.contentOffset.x == [HHSoftAppInfo AppScreen].width*3){
        [_attentionNoticeViewController deleteSelectCollect];
    }
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
    _attentionAdvertViewController = [[AttentionAdvertViewController alloc] initWithAttentionAdvertCanEditBlock:^(BOOL canEdit) {
        if (canEdit) {
            _rightBarButton.userInteractionEnabled = YES;
        }else{
            _rightBarButton.userInteractionEnabled = NO;
        }
    } AttentionAdvertIsAllDeleteBlock:^(BOOL isAllDelete) {
        if (isAllDelete) {
            [_rightBarButton setTitle:@"编辑" forState:UIControlStateNormal];
            _rightBarButton.userInteractionEnabled = NO;
        }
    }];
    [self addChildViewController:_attentionAdvertViewController];
    _attentionNewsViewController = [[AttentionNewsViewController alloc] initWithAttentionNewsCanEditBlock:^(BOOL canEdit) {
        if (canEdit) {
            _rightBarButton.userInteractionEnabled = YES;
        }else{
            _rightBarButton.userInteractionEnabled = NO;
        }
    } AttentionNewsIsAllDeleteBlock:^(BOOL isAllDelete) {
        if (isAllDelete) {
            [_rightBarButton setTitle:@"编辑" forState:UIControlStateNormal];
            _rightBarButton.userInteractionEnabled = NO;
        }
    }];
    [self addChildViewController:_attentionNewsViewController];
    _attentionDemandViewController = [[AttentionDemandViewController alloc] initWithAttentionDemandCanEditBlock:^(BOOL canEdit) {
        if (canEdit) {
            _rightBarButton.userInteractionEnabled = YES;
        }else{
            _rightBarButton.userInteractionEnabled = NO;
        }
    } AttentionDemandIsAllDeleteBlock:^(BOOL isAllDelete) {
        if (isAllDelete) {
            [_rightBarButton setTitle:@"编辑" forState:UIControlStateNormal];
            _rightBarButton.userInteractionEnabled = NO;
        }
    }];
    [self addChildViewController:_attentionDemandViewController];
    _attentionNoticeViewController = [[AttentionNoticeViewController alloc] initWithAttentionNoticeCanEditBlock:^(BOOL canEdit) {
        if (canEdit) {
            _rightBarButton.userInteractionEnabled = YES;
        }else{
            _rightBarButton.userInteractionEnabled = NO;
        }
    } AttentionNoticeIsAllDeleteBlock:^(BOOL isAllDelete) {
        if (isAllDelete) {
            [_rightBarButton setTitle:@"编辑" forState:UIControlStateNormal];
            _rightBarButton.userInteractionEnabled = NO;
        }
    }];
    [self addChildViewController:_attentionNoticeViewController];
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
    [_rightBarButton setTitle:@"编辑" forState:UIControlStateNormal];
    _rightBarButton.userInteractionEnabled = NO;
    [self.childViewControllers[button.tag-200] setTableEditing:NO];
    [self.childViewControllers[button.tag-200] reloadAttentionData];
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
        MenuInfo *menuInfo0 = [[MenuInfo alloc]initWithMenuID:0 menuName:@"广告"];
        MenuInfo *menuInfo1 = [[MenuInfo alloc]initWithMenuID:1 menuName:@"资讯"];
        MenuInfo *menuInfo2 = [[MenuInfo alloc]initWithMenuID:2 menuName:@"需求"];
        MenuInfo *menuInfo3 = [[MenuInfo alloc]initWithMenuID:3 menuName:@"公示公告"];
        _arrMenu = [NSMutableArray arrayWithObjects:menuInfo0,menuInfo1,menuInfo2,menuInfo3, nil];
        
    }
    return _arrMenu;
}
@end
