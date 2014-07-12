//
//  newViewController.m
//  苏伊仕博客登录
//
//  Created by Louis on 14-6-23.
//  Copyright (c) 2014年 Louis. All rights reserved.
//

#import "newViewController.h"
#import "UIButton+YE.h"
#import "MainViewController.h"
#import "OAuthViewController.h"

#pragma mark - 规定要展示的页数
#define kPageCount 4
#pragma mark - 规定pagecontrol在屏幕中的位置
#define kPageRatio 0.95

@interface newViewController ()

@end

@implementation newViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark - 加载一张底图
-(void)loadView
{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"new_feature_background.png"]];
    
    //    UIImageView *imageView = [[UIImageView alloc]init];
    //    imageView.image = [UIImage ]
    //    UIImageView *backgroundImageView = [[UIImageView alloc]init];
    //    backgroundImageView.image = [UIImage fulls]
    
    
    // 设置frame大小
    imageView.frame = [UIScreen mainScreen].applicationFrame;
    // 允许用户交互，传递触事件
    imageView.userInteractionEnabled = YES;
    
    self.view = imageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 加载scroview
    [self addScrollview];
    
    //    加载scrollview上的图片
    [self addScrollViewImage];
    
    //    加载pagecontrolle
    [self addPageController];
}


-(void)addScrollview
{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    
    // 隐藏水平滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    
    CGSize contentsize = CGSizeMake(self.view.frame.size.width * kPageCount, 0);
    scrollView.contentSize = contentsize;
    
    // 设置分页
    scrollView.pagingEnabled = YES;
    
    //    添加代理
    scrollView.delegate = self;
    
    [self.view addSubview:scrollView];
    _myScrollView = scrollView;
}

-(void)addScrollViewImage
{
    CGSize size = _myScrollView.frame.size;
    
    for (int i = 0; i<kPageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        // 1.显示图片
        NSString *name = [NSString stringWithFormat:@"new_feature_%d.png", i + 1];
        imageView.image = [UIImage imageNamed:name];
        // 2.设置frame
        imageView.frame = CGRectMake(i * size.width, 0, size.width, size.height);
        imageView.userInteractionEnabled = YES;
        [_myScrollView addSubview:imageView];
        
        if (i == kPageCount - 1) { // 最后一页，添加2个按钮
            UIButton *shareButton = [UIButton buttonWithImageNomal:@"new_feature_share_false.png" imageSelected:@"new_feature_share_true.png"];
            UIButton *startButton = [UIButton buttonWithImageNomal:@"new_feature_finish_button.png" imageSelected:@"new_feature_finish_button_highlighted.png"];
            
            [shareButton addTarget:self action:@selector(checkShare:) forControlEvents:UIControlEventTouchUpInside];
            [startButton addTarget:self action:@selector(startWeibo:) forControlEvents:UIControlEventTouchUpInside];
            
            shareButton.center =
            CGPointMake(imageView.frame.size.width*0.5, imageView.frame.size.height * (kPageRatio - 0.2));
            startButton.center =
            CGPointMake(imageView.frame.size.width*0.5, imageView.frame.size.height * (kPageRatio - 0.1));
            
#pragma mark - bounds 和frame的区别就是，bounds是以自己为坐标原点，而frame是以屏幕为坐标原点，下面的例子就说明了，当时bounds的时候button显示的位置正常，因为前面已经指定了button的center所以这里不需要再指定他的位置了，只需要指定大小就可以了，而用frame的时候会出现button出现在顶端的情况
            //            checkButton.frame = CGRectMake(0, 0, 300, 50);
            shareButton.bounds = CGRectMake(0, 0, 300, 50);
            startButton.bounds = CGRectMake(0, 0, 300, 50);
            
            //  按钮默认选择：分享
            shareButton.selected = YES;
            startButton.selected = YES;
            shareButton.adjustsImageWhenHighlighted = NO;
            
            [imageView addSubview:shareButton];
            [imageView addSubview:startButton];
        }
    }
}

- (void)checkShare:(UIButton *)shareButton
{
    shareButton.selected = !shareButton.selected;
}

- (void)startWeibo:(UIButton *)startButton
{
    //    MainViewController *mainVC = [[MainViewController alloc]init];
     self.view.window.rootViewController = [[OAuthViewController alloc]init];
    //    self.view.window.rootViewController =  mainVC;
}

-(void)addPageController
{
#pragma mark UIPageViewController  UIPageControl区别在哪里？
    
    //    CGSize size = _scrollView.frame.size;    _scrollView.frame  self.view.frame不是一个东西，self.view.是imageview
    CGSize size = self.view.frame.size;
    
    UIPageControl *pageController = [[UIPageControl alloc]init];
    NSLog(@"self %@, self.view%@ size:%@, bounds:%@", self, self.view, NSStringFromCGRect(self.view.frame), NSStringFromCGRect(self.view.bounds));
    //    这个pagecontrol不需要指定它的大小，只需要指定它的中心点位置就可以
    //    pageController.frame = CGRectMake(_scrollView.bounds.size.width*0.5, _scrollView.bounds.size.height * kPageRatio, 200, 0);
    
    pageController.center = CGPointMake(size.width * 0.5, size.height * kPageRatio);
    
    // 设置page的数目
    pageController.numberOfPages = kPageCount;
    
    //设置page被选中页面的图片
    pageController.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_checked_point.png"]];
    pageController.pageIndicatorTintColor  = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_point.png"]];
    
    pageController.bounds = CGRectMake(0, 0, 150, 0);
    //    pageController.backgroundColor = [UIColor redColor];
    
#pragma mark 这里要加到那个view上面自己一定要搞清楚
    [self.view addSubview:pageController];
    //    [_scrollView addSubview:pageController]；
    _myPageControl = pageController;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
#pragma mark 各种size啊，都搞晕了
    NSLog(@"currentpage %f,ss:%f  dd:%f", scrollView.contentOffset.x,   scrollView.contentSize.width, scrollView.frame.size.width);
    
    _myPageControl.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
}

#pragma mark - 设置默认不支持屏幕翻转
-(BOOL)shouldAutorotate
{
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
