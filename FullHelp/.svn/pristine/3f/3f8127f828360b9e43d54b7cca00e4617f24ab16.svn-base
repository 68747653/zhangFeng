//
//  AddAccountNumberViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/10.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "AddAccountNumberViewController.h"
#import "GlobalFile.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import "MenuInfo.h"
#import "AddAccountNumberChildViewController.h"
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>

@interface AddAccountNumberViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *arrMenu;
@property (nonatomic, strong) UIView *spView;
@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation AddAccountNumberViewController

- (instancetype)initWithAddAccountNumberSuccessedBlock:(AddAccountNumberSuccessedBlock)addAccountNumberSuccessedBlock {
    if (self = [super init]) {
        self.addAccountNumberSuccessedBlock = addAccountNumberSuccessedBlock;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加账户";
    self.view.backgroundColor = [GlobalFile backgroundColor];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    
    [self addClassButton];
    [self setChildViewController];
    [self setupScrollView];
}

- (void)addClassButton {
    for (NSInteger i = 0;i<self.arrMenu.count;i++) {
        UIButton *classButton = [[UIButton alloc]initWithFrame:CGRectMake(i*[HHSoftAppInfo AppScreen].width/self.arrMenu.count, 0, [HHSoftAppInfo AppScreen].width/self.arrMenu.count, 40)];
        [classButton setTitleColor:[HHSoftAppInfo defaultDeepSystemColor] forState:UIControlStateNormal];
        [classButton setTitleColor:[GlobalFile themeColor] forState:UIControlStateSelected];
        classButton.tag = i;
        classButton.titleLabel.font = [UIFont systemFontOfSize:16];
        MenuInfo *menuInfo = self.arrMenu[i];
        [classButton setTitle:menuInfo.menuName forState:UIControlStateNormal];
        
        if (i == 0) {
            classButton.selected = YES;
        }
        classButton.backgroundColor = [UIColor whiteColor];
        [classButton addTarget:self action:@selector(classButtonClickEnent:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:classButton];
    }
    _spView = [[UIView alloc]initWithFrame:CGRectMake(20, 38, [HHSoftAppInfo AppScreen].width/self.arrMenu.count-40, 2)];
    [self.view addSubview:_spView];
    _spView.backgroundColor = [GlobalFile themeColor];
}

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

#pragma mark --- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _spView.frame = CGRectMake(scrollView.contentOffset.x/self.arrMenu.count+20, 38, [HHSoftAppInfo AppScreen].width/self.arrMenu.count-40, 2);
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

- (void)setChildViewController {
    AddAccountNumberChildViewController *addWeixinViewController = [[AddAccountNumberChildViewController alloc]initWithViewType:1 addAccountNumberSuccessed:^{
        if (_addAccountNumberSuccessedBlock) {
            _addAccountNumberSuccessedBlock();
        }
    }];
    [self addChildViewController:addWeixinViewController];
    AddAccountNumberChildViewController *addZhifubaoViewController = [[AddAccountNumberChildViewController alloc]initWithViewType:0 addAccountNumberSuccessed:^{
        if (_addAccountNumberSuccessedBlock) {
            _addAccountNumberSuccessedBlock();
        }
    }];
    [self addChildViewController:addZhifubaoViewController];
}

- (void)classButtonClickEnent:(UIButton *)button {
    AddAccountNumberChildViewController *addAccountNumberChildViewController = [[AddAccountNumberChildViewController alloc]init];
    addAccountNumberChildViewController = self.childViewControllers[button.tag];
    //    [appoinmentListViewController reloadDate];
    for (UIView *subView in [self.view subviews]) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *noButton = (UIButton *)subView;
            noButton.selected = NO;
        }
    }
    button.selected = YES;
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = [HHSoftAppInfo AppScreen].width * button.tag;
    [self.scrollView setContentOffset:offset animated:YES];
}

- (NSMutableArray *)arrMenu {
    _arrMenu = [[NSMutableArray alloc]init];
    MenuInfo *weixinMenu = [[MenuInfo alloc]initWithMenuID:1 menuName:@"微信"];
    [_arrMenu addObject:weixinMenu];
    MenuInfo *zhifubaoMenu = [[MenuInfo alloc]initWithMenuID:2 menuName:@"支付宝"];
    [_arrMenu addObject:zhifubaoMenu];
    return _arrMenu;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
