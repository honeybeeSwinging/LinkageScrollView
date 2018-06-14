//
//  ViewController.m
//  ScrollViewAndScroView
//
//  Created by HENING on 2018/6/13.
//  Copyright © 2018年 HeNing. All rights reserved.
//

#import "ViewController.h"
#import "ScrollHeaderView.h"
#import "TopMenuView.h"
#import "SubViewOne.h"
#import "SubViewTwo.h"
#import "SubViewThree.h"

#define HUIRGBColor(r, g, b, a)      [UIColor colorWithRed:(r)/255.00 green:(g)/255.00 blue:(b)/255.00 alpha:(a)]

@interface ViewController ()<UIScrollViewDelegate,TopMenuViewDelegate,PagemenuDelegate>{
    CGFloat _headerHeight;      // 头部视图高度
    CGFloat _menuHeight;        // 菜单高度
    CGFloat _navBarheight;      // 导航栏总高度
}

@property (nonatomic,strong)    ScrollHeaderView    *headerView;
//切换按钮
@property (nonatomic,strong)    TopMenuView         *menuView;
//子view
@property (nonatomic,strong)    UIScrollView     *scrollView;
@property (nonatomic,strong)    SubViewOne       *detailNewsView;
@property (nonatomic,strong)    SubViewTwo       *detailMessageView;
@property (nonatomic,strong)    SubViewThree     *detailInfoView;
//保存subTableView方便同步滚动
@property (nonatomic,strong)    NSMutableArray      *subMainTableViewArray;

@end

@implementation ViewController

#pragma mark- 懒加载
- (ScrollHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[ScrollHeaderView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, _headerHeight)];
        _headerView.backgroundColor = [UIColor colorWithRed:0 green:139/255.0 blue:139/255.0 alpha:1];
    }
    return _headerView;
}

- (TopMenuView *)menuView{
    if(!_menuView){
        NSArray *btnTitleArr = @[@"动态",@"留言",@"介绍"];
        _menuView = [[TopMenuView alloc]initWithFrame:CGRectMake(0, _headerHeight-_menuHeight-1, [UIScreen mainScreen].bounds.size.width, _menuHeight) andTitleArray:btnTitleArr];
        _menuView.backgroundColor = [UIColor whiteColor];
        _menuView.delegate = self;
    }
    return _menuView;
}

- (UIScrollView *)scrollView{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _scrollView.contentSize = CGSizeMake(3*[UIScreen mainScreen].bounds.size.width, 1);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (SubViewOne *)detailNewsView{
    if (!_detailNewsView) {
        _detailNewsView = [[SubViewOne alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-_navBarheight)];
        _detailNewsView.delegate = self;
    }
    return _detailNewsView;
}

- (SubViewTwo *)detailMessageView{
    if (!_detailMessageView) {
        _detailMessageView = [[SubViewTwo alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-_navBarheight)];
        _detailMessageView.delegate = self;
    }
    return _detailMessageView;
}

- (SubViewThree *)detailInfoView{
    if (!_detailInfoView) {
        _detailInfoView = [[SubViewThree alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*2, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-_navBarheight)];
        _detailInfoView.delegate = self;
    }
    return _detailInfoView;
}

#pragma mark- viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _headerHeight = headerViewHeight;
    _menuHeight = 44;
    
    //_navBarheight包括导航栏和statusBar两部分高度：44导航栏固定高度 + statusBarFrame.height
    _navBarheight = 44 + [UIApplication sharedApplication].statusBarFrame.size.height;
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.menuView];
    
    //添加子view
    [self.scrollView addSubview:self.detailNewsView];
    [self.scrollView addSubview:self.detailMessageView];
    [self.scrollView addSubview:self.detailInfoView];
    
    self.subMainTableViewArray = [NSMutableArray arrayWithObjects:
                                  self.detailNewsView.mainTableView,
                                  self.detailMessageView.mainTableView,
                                  self.detailInfoView.mainTableView, nil];
    
    __weak __typeof(&*self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.detailNewsView refresh];
    });
}

#pragma mark- 点击menu手动切换子View
- (void)refreshWithTag:(NSInteger)menuTag{
    NSInteger page = menuTag;
    [self.scrollView scrollRectToVisible:CGRectMake([UIScreen mainScreen].bounds.size.width * page, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) animated:YES];
    [self scrollIndex:page];
}

#pragma mark- 滑动切换切换子View
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    NSInteger selectedBtnTag = page;
    [self.menuView selectItemChangedWithSelectedIndex:selectedBtnTag];
    [self scrollIndex:page];
}

#pragma mark- 切换完分页后的操作
- (void)scrollIndex:(NSInteger)page{
    switch (page) {
        case 0:
            [self.detailNewsView refresh];
            break;
            
        case 1:
            [self.detailMessageView refresh];
            break;
            
        case 2:
            [self.detailInfoView refresh];
            break;
            
        default:
            break;
    }
}

#pragma mark- 头跟随view滚动
- (void) scrollChangedOffset:(CGFloat)offset scrollView:(UIScrollView *)scrollview{
    // 计算总的偏移量
    CGFloat scrollY = -(_headerHeight+offset);
    // 预留手动切换菜单高度_menuHeight即悬停位置
    CGFloat intVal = (_headerHeight-_menuHeight);
    
    /**当需要用到导航栏透明度时去掉此注释
     CGFloat navAlph = (offsetY+_headerHeight)/_headerHeight;
     [self.navigationController.navigationBar lt_setBackgroundColor:HUIRGBColor(255, 255, 255, (navAlph>0.5)?1:navAlph)];
    */
    if (scrollY<=0&&scrollY>=-intVal) {
        // 因为要留下_menuHeight高度的切换按钮所滑动的距离为headerH-menuH
        self.headerView.transform = CGAffineTransformMakeTranslation(0, scrollY);
        // 同步滚动
        for (UIScrollView *subScroll in self.subMainTableViewArray) {
            if (subScroll!=scrollview) {
                [subScroll setContentOffset:CGPointMake(0, offset)];
            }
        }
    }else if (scrollY>0){
        // tableView快速下拉时，滑动太快的时候导致header和tableview滚动不同步，直接位置恢复
        self.headerView.transform = CGAffineTransformIdentity;
    }else if (scrollY<-intVal){
        // tableView快速上拉时，滑动太快的时候导致header和tableview滚动不同步，直接位置平移
        self.headerView.transform = CGAffineTransformMakeTranslation(0, -intVal);
        // 同步滚动
        for (UIScrollView *subScroll in self.subMainTableViewArray) {
            if (subScroll.contentOffset.y<-_menuHeight) {
                [subScroll setContentOffset:CGPointMake(0, -_menuHeight)];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
